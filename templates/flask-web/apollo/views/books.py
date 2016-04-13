#!/usr/bin/env python
# coding=utf-8

import datetime

from flask import Module, Response, request, flash, jsonify, g, current_app, \
    abort, redirect, url_for, session, render_template

from flask.ext.login import login_required, current_user
from sqlalchemy import or_

from apollo.models import Res, Book, BorrowLog, Tag, BookTag, Comment, Task, Syslog, Account
from apollo.extensions import db
from apollo.helpers import DoubanClient
from apollo.helpers import save_syslog

books = Module(__name__)


# 首页
@books.route("/", methods=("GET", "POST"))
def index():
    page = 1
    keywords = u''
    # 热门标签
    tag_list = Tag.query.order_by(Tag.counts.desc()).limit(10)

    # 城市标签
    sql = "select DISTINCT city from books "
    city_list = db.engine.execute(sql)

    if request.method == "POST":
        page = request.form['page']
        keywords = request.form['q']
        keywords = keywords.encode("utf-8")
        page = int(page) if page else 1

        # print "keywords=", keywords, "page=", page
        if not keywords:
            page_obj = Book.query.order_by(Book.id.desc()).paginate(page, Book.PER_PAGE, False)
        else:
            page_obj = Book.query.filter(
                or_(Book.title.ilike('%' + keywords + "%"), Book.author.ilike('%' + keywords + "%"),
                    Book.owner_name.ilike('%' + keywords + "%"))).order_by(Book.id.desc()).paginate(page, Book.PER_PAGE,
                                                                                                    False)
    else:
        page_obj = Book.query.order_by(Book.id.desc()).paginate(page, Book.PER_PAGE, False)

    return render_template("index.html", q="", tag_list=tag_list, city_list=city_list, page_obj=page_obj)


# 关于页
@books.route("/about/", methods=("GET", "POST"))
def about():
    return render_template("about.html")


# 个人主页
@books.route("/my/", methods=("GET", "POST"))
@login_required
def my():
    current_borrow_book = Book.query.filter_by(borrow_id=current_user.id).first()
    surplus_days = 0
    if current_borrow_book:
        current_borrow_log = BorrowLog.query.filter_by(id=current_borrow_book.borrow_log_id).first()
        # 剩余天数
        surplus_days = (datetime.datetime.combine(current_borrow_log.reback_time,
                                                  datetime.datetime.min.time()) - datetime.datetime.now()).days

    share_book_list = Book.query.filter_by(owner_id=current_user.id).order_by(Book.id.desc())

    print dir(share_book_list)
    # 借阅历史
    borrow_log_list = BorrowLog.query.filter_by(account_id=current_user.id).order_by(BorrowLog.id.desc()).limit(10)

    return render_template("my_books.html",
                           current_borrow_book=current_borrow_book,
                           share_book_list=share_book_list,
                           borrow_log_list=borrow_log_list,
                           surplus_days=surplus_days
                           )


# 查看单个图书详情
@books.route("/<int:book_id>/", methods=("GET", "POST"))
def view(book_id):
    book = Book.query.filter_by(id=book_id).first()

    save_syslog(current_user, request.remote_addr, u"查看图书详情，书名:《%s》" % book.title)
    # 借阅历史
    borrow_log_list = BorrowLog.query.filter_by(book_id=book.id).order_by(BorrowLog.id.desc()).limit(10)

    # 评论
    comments = Comment.query.filter_by(book_id=book.id).order_by(Comment.id.desc()).limit(10)

    return render_template("book_detail.html",
                           book=book,
                           borrow_log_list=borrow_log_list,
                           comments=comments)


# 我要分享
@books.route("/share/", methods=("GET", "POST"))
@login_required
def share():
    if request.method == "GET":
        return render_template("share.html")

    isbn = request.form['isbn']

    # 校验书是否重复
    book = Book.query.filter_by(isbn13=isbn).filter_by(owner_id=current_user.id).first()
    print book

    if book:
        res = Res(400, "分享失败，你已经共享过此书。")
        return jsonify(res.serialize())

    city = request.form['city']
    recommend = request.form['recommend']
    client = DoubanClient()
    book = client.parse_book_info(isbn)

    if book:
        book.owner_id = current_user.id
        book.owner_name = current_user.name
        book.recommend = recommend
        book.city = city

        db.session.add(book)
        db.session.commit()

        for tag in book.tags:
            t = Tag.query.filter_by(name=tag['name'].encode('utf-8')).first()
            if not t:  # 如果以前不存在
                t = Tag()
                t.name = tag['name']
                t.counts = int(tag['count'])
                t.create_time = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
                db.session.add(t)
                db.session.commit()
            else:
                t.counts = t.counts + int(tag['count'])

            bookTag = BookTag()
            bookTag.book_id = book.id
            bookTag.tag_id = t.id
            bookTag.count = tag['count']
            db.session.add(bookTag)
            db.session.commit()
        save_syslog(current_user, request.remote_addr, u"分享图书，书名:《%s》" % book.title)

        # 处理当前人的城市属性
        # 修改当前登录人的城市为最后分享图书的城市
        account = Account.query.filter_by(id=current_user.id).first()
        account.city = book.city
        db.session.commit()

        print account

        res = Res(200, "分享成功")
    else:
        res = Res(400, "分享失败")

    return jsonify(res.serialize())


# 还书
@books.route("/reback/<int:book_id>/", methods=("GET", "POST"))
@login_required
def reback(book_id):
    print "reback book , book_id=", book_id

    book = Book.query.filter_by(id=book_id).first()

    # 修改图书属性
    # book.borrow_id = None
    # book.borrow_name = ''
    book.status = 2  # 还书成功，将状态恢复为2  0 ：空闲中 1：借阅中 2：归还中

    # 记录到还书确认任务表中
    task = Task()
    task.user_id = book.owner_id
    task.book_id = book.id
    task.content = u"%s 要归还书：<<%s>>，请确认是否收到。" % (current_user.name, book.title)
    task.status = 0
    task.create_time = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    db.session.add(task)

    # 记录还书时间
    borrow_log = BorrowLog.query.filter_by(id=book.borrow_log_id).first()
    borrow_log.real_reback_time = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')

    db.session.commit()

    save_syslog(current_user, request.remote_addr, u"申请还书，书名:《%s》" % book.title)

    flash(u"申请还书成功，请找%s确认" % book.owner_name, "danger")
    return redirect(url_for("books.my"))


# 借书
@books.route("/borrow/<int:book_id>/", methods=("GET", "POST"))
@login_required
def borrow(book_id):
    print "borrow book , book_id=", book_id

    # 检查当前用户是否存在未还的图书，同一时间只允许借一本书
    checkBook = Book.query.filter_by(borrow_id=current_user.id).first()
    if checkBook:
        flash(u"借书失败，你当前还有未还的图书，不要太贪心。", "danger")
        return redirect(url_for("books.view", book_id=book_id))

    # 修改图书的相关属性
    book = Book.query.filter_by(id=book_id).first()

    # 检查当前图书的状态，如果被别人借阅中，则不能借入
    if book.status == 1:
        flash(u"借书失败，当前图书已经被别人借阅了。", "danger")
        return redirect(url_for("books.view", book_id=book_id))

    # 记入借阅历史
    borrow_log = BorrowLog(current_user.id, current_user.name, book_id, book.title)
    borrow_log.create_time = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    borrow_log.reback_time = (datetime.datetime.now() + datetime.timedelta(days=14)).strftime('%Y-%m-%d')

    db.session.add(borrow_log)

    # 这一行不能删，首先保存之后，可以获取borrow_log的ID
    db.session.commit()

    book.borrow_id = current_user.id
    book.borrow_name = current_user.name
    book.borrow_counts += 1
    book.borrow_log_id = borrow_log.id
    book.status = 1  # 借书成功，设置状态为借阅中

    db.session.commit()

    flash(u"借书成功，请一定要按时归还吆。", "danger")
    return redirect(url_for("books.my"))


# 查看某个标签的图书
@books.route("/tag/<int:tag_id>/", methods=("GET", "POST"))
def tag_books(tag_id):
    print "tag_id=", tag_id
    tag = Tag.query.filter_by(id=tag_id).first()
    tag_list = Tag.query.order_by(Tag.counts.desc()).limit(10)

    sql = "select b.* from book_tag a left join books b on a.book_id = b.id where a.tag_id=%d" % tag_id
    book_list = db.engine.execute(sql)

    return render_template("tag_books.html", tag=tag, books=book_list, tag_list=tag_list)


# 查看某个城市的图书
@books.route("/city/<city>/", methods=("GET", "POST"))
def city_books(city):
    page = 1

    tag_list = Tag.query.order_by(Tag.counts.desc()).limit(10)

    # 城市标签
    sql = "select DISTINCT city from books "
    city_list = db.engine.execute(sql)

    if request.method == "POST":
        page = request.form['page']
        page = int(page) if page else 1

        print page

        # print "keywords=", keywords, "page=", page
        page_obj = Book.query.filter_by(city=city).order_by(Book.id.desc()).paginate(page, 20,False)
    else:
        page_obj = Book.query.filter_by(city=city).order_by(Book.id.desc()).paginate(page, 20, False)

    print dir(page_obj)
    return render_template("city_books.html", city=city, page_obj=page_obj, city_list=city_list)


# 查看某个标签的图书
@books.route("/tags/", methods=("GET", "POST"))
def tags():
    tags = Tag.query.all()

    return render_template("tags.html", tags=tags)


# 还书任务列表
@books.route("/tasks/", methods=("GET", "POST"))
@login_required
def tasks():
    tasks = Task.query.filter_by(status=0).filter_by(user_id=current_user.id).order_by(Task.create_time).all()

    return render_template("tasks.html", tasks=tasks)


# 获取任务数量
@books.route("/task_count/", methods=("GET", "POST"))
@login_required
def task_count():
    tasks = Task.query.filter_by(status=0).filter_by(user_id=current_user.id).order_by(Task.create_time).all()

    return tasks.count()


# 确认还书流程
@books.route("/confirm_reback/<int:id>", methods=("GET", "POST"))
@login_required
def confirm_reback(id):
    task = Task.query.filter_by(id=id).first()

    if task:
        print task.book_id
        book = Book.query.filter_by(id=task.book_id).first()

        if book:
            print book.borrow_id
            # 修改图书属性
            book.borrow_id = None
            book.borrow_name = ''
            book.status = 0  # 还书成功，将状态恢复为0  0 ：空闲中 1：借阅中 2：归还中

            print book.borrow_id
            db.session.commit()

            task.status = 1
            task.opt_time = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')

            db.session.commit()

            save_syslog(current_user, request.remote_addr, u"还书确认成功，书名:《%s》" % book.title)

            flash(u"确认成功。", "success")
        else:
            flash(u"确认失败，没有找到对应的图书。", "danger")

    else:
        flash(u"确认失败，没有找到任务。", "danger")

    return redirect(url_for("books.tasks"))


# 添加评论
@books.route("/comment/", methods=("GET", "POST"))
@login_required
def comment():
    content = request.form['content']
    book_id = request.form['book_id']

    print "add comment:", content.encode("utf-8"), book_id
    comment = Comment()
    comment.content = content
    comment.book_id = book_id
    comment.account_id = current_user.id
    comment.account_name = current_user.name
    comment.create_time = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    db.session.add(comment)
    db.session.commit()

    save_syslog(current_user, request.remote_addr, u"评价成功")

    flash(u"评价成功", "info")
    return redirect(url_for("books.view", book_id=book_id))


# 查看操作日志
@books.route("/syslog/", methods=("GET", "POST"))
@books.route("/syslog/<int:page>/", methods=("GET", "POST"))
def syslog(page=1):
    page_obj = Syslog.query.order_by(Syslog.id.desc()).paginate(page, Syslog.PER_PAGE, False)

    return render_template("syslog.html", page_obj=page_obj)
