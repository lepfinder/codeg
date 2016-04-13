#!/usr/bin/env python
# coding=utf-8

from apollo.extensions import db


class Book(db.Model):
    __tablename__ = 'books'

    id = db.Column(db.Integer, primary_key=True)

    PER_PAGE = 12

    title = db.Column(db.String(64))

    isbn13 = db.Column(db.String(64))
    author = db.Column(db.String(64))
    rating = db.Column(db.Float)
    pubdate = db.Column(db.String(16))
    image = db.Column(db.String(128))
    douban_id = db.Column(db.Integer)
    publisher = db.Column(db.String(64))
    douban_url = db.Column(db.String(128))
    summary = db.Column(db.Text)
    price = db.Column(db.String(32))
    pages = db.Column(db.String(32))
    catalog = db.Column(db.Text)
    owner_name = db.Column(db.String(64))
    owner_id = db.Column(db.Integer)
    borrow_name = db.Column(db.String(64))
    borrow_id = db.Column(db.Integer)
    borrow_log_id = db.Column(db.Integer)
    borrow_counts = db.Column(db.Integer)
    # 图书状态 0 ：空闲中 1：借阅中 2：归还中
    status = db.Column(db.Integer)
    recommend = db.Column(db.Text)
    city = db.Column(db.String(64))


class BorrowLog(db.Model):
    __tablename__ = 'borrow_log'

    id = db.Column(db.Integer, primary_key=True)

    account_id = db.Column(db.Integer)
    account_name = db.Column(db.String(64))
    book_id = db.Column(db.Integer)
    book_name = db.Column(db.String(128))
    create_time = db.Column(db.DateTime)
    reback_time = db.Column(db.DateTime)
    real_reback_time = db.Column(db.DateTime)

    def __init__(self, account_id, account_name, book_id, book_name):
        self.account_id = account_id
        self.account_name = account_name
        self.book_id = book_id
        self.book_name = book_name


class Tag(db.Model):
    __tablename__ = 'tags'

    id = db.Column(db.Integer, primary_key=True)

    name = db.Column(db.String(64))
    counts = db.Column(db.Integer)
    create_time = db.Column(db.DateTime)


class BookTag(db.Model):
    __tablename__ = 'book_tag'

    id = db.Column(db.Integer, primary_key=True)

    book_id = db.Column(db.Integer)
    tag_id = db.Column(db.Integer)
    count = db.Column(db.Integer)


class Comment(db.Model):
    __tablename__ = 'comments'

    id = db.Column(db.Integer, primary_key=True)

    book_id = db.Column(db.Integer)
    account_id = db.Column(db.Integer)
    account_name = db.Column(db.String(64))
    content = db.Column(db.Text)
    create_time = db.Column(db.DateTime)


class Task(db.Model):
    __tablename__ = 'tasks'

    id = db.Column(db.Integer, primary_key=True)

    user_id = db.Column(db.Integer)
    book_id = db.Column(db.Integer)
    content = db.Column(db.Text)
    create_time = db.Column(db.DateTime)
    opt_time = db.Column(db.DateTime)
    status = db.Column(db.Integer)
