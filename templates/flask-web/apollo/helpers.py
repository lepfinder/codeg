#!/usr/bin/env python
# coding=utf-8

import requests
import datetime
import json
from models import Book, BookTag, Syslog
from apollo.extensions import db


# 豆瓣接口api
class DoubanClient():
    def parse_book_info(self, isbn):
        r = requests.get('http://api.douban.com/v2/book/isbn/%s' % isbn)

        jsonObj = json.loads(r.text)

        book = Book()

        if jsonObj['title']:
            book.title = jsonObj['title']

            authors = jsonObj['author']
            book.author = ",".join(authors)

            book.price = jsonObj['price']
            book.summary = jsonObj['summary']
            book.catalog = jsonObj['catalog']
            book.publisher = jsonObj['publisher']
            book.isbn13 = jsonObj['isbn13']
            book.douban_id = jsonObj['id']
            book.image = jsonObj['image']
            book.douban_url = jsonObj['alt']
            book.pages = jsonObj['pages']
            book.pubdate = jsonObj['pubdate']
            book.rating = jsonObj['rating']['average']

            # 处理标签
            book.tags = jsonObj['tags']

            book.borrow_id = 0
            book.borrow_name = ''
            book.borrow_counts = 0
            book.status = 0  # 初始状态为空闲中

        return book


def save_syslog(current_user, op_ip, content):
    syslog = Syslog()
    if current_user.is_authenticated:
        syslog.account_id = current_user.id
        syslog.account_name = current_user.name
    syslog.op_ip = op_ip
    syslog.op_time = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    syslog.content = content
    db.session.add(syslog)
    db.session.commit()


if __name__ == "__main__":
    client = DoubanClient()
    client.parse_book_info("123")
