#!/usr/bin/env  
#coding: utf-8
#################################################
# 作者：xiyang
# 时间：2015-05-14
# 版本：1.0
#################################################
import MySQLdb
from config import * 

class DButils(object):
    def __init__(self):
        super(DButils, self).__init__()

        #init mysql connection
        self.conn= MySQLdb.connect(
            host=db_host,
            port = db_port,
            user=db_user,
            passwd=db_passwd,
            connect_timeout=6000
        )
        self.cur = self.conn.cursor() 
     
    def fetchmany(self,sql):
        try:
            return self.cur.fetchmany(self.cur.execute(sql))
        except Exception, e:
            print e
            print sql
    
    def executemany(self,sql,values):
        try:
            self.cur.executemany(sql,values)
            self.conn.commit()
        except Exception, e:
            print e
            print sql
      
    def fetchone(self,sql):
        try:
            self.cur.execute(sql)
            return self.cur.fetchone()
        except Exception, e:
            print e
            print sql

    def execute(self,sql):
        try:
            self.cur.execute(sql)
            self.conn.commit()
        except Exception, e:
            print e
            print sql
    def execute(self,sql,values):
    	try:
    		self.cur.execute(sql,values)
    		self.conn.commit()
    	except Exception, e:
    		print e
    		print sql

    def create(self,sql):
        try:
            self.cur.execute(sql)
            self.conn.commit()
        except Exception, e:
            print e

    def is_table_exit(self,tableName):
        show_sql = 'show tables;'
        try:
            return tableName in self.cur.fetchmany(self.cur.execute(show_sql))
        except Exception,e:
            print e
    def close_db(self):
        self.cur.close()
        self.conn.close()
if __name__ == "__main__":
    try:
        db = DButils()

        sql = "select * from qding_platform.order_base limit 1"
        
        print sql
        result = db.fetchmany(sql)

        print result
        for r in result:
            print r
    finally:
        db.close_db()


