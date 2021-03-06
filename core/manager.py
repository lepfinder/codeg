#! /usr/bin/env python
# -*- coding: UTF-8 -*-
import json
import logging
import shutil
import MySQLdb
from sqlalchemy import *
from sqlalchemy.engine import reflection
from project import Project
from group import Group
from entity import Entity
from field import Field
from task import Task
from constant import *
from jinja2 import Environment, FileSystemLoader
import sys

reload(sys)
sys.setdefaultencoding('utf8')


class Manager():
    def __init__(self):
        self.load_conf()

    def set_pdef_name(self, pdef_name):
        self.pdef_path = os.path.join(PROJECT_DEF_PATH, pdef_name)

        content = open(self.pdef_path).read()
        self.pdef_content = content

        pdef = json.loads(content)

        self.load_pdef(pdef)

    def set_pdef(self, pdef):

        self.load_pdef(pdef)

    def create(self):
        logging.info("start create project:" + self.project.name)

        self.cleandirs()
        self.mkdirs()
        self.copyStaticFiles()

        self.project.run_group()

    def create_zip(self):
        logging.info("start create project:" + self.project.name)

        self.cleandirs()
        self.mkdirs()
        self.copyStaticFiles()

        self.project.run_group()

    def create2(self):
        logging.info("start create project:" + self.project.name)

        # self.project.run_group()

    def cleandirs(self):
        if os.path.exists(self.project.targetpath):
            shutil.rmtree(self.project.targetpath)

    def mkdirs(self):
        targetpath = self.project.targetpath
        os.makedirs(targetpath)
        os.makedirs(targetpath + FS + "src")
        os.makedirs(targetpath + FS + "src" + FS + "main")
        os.makedirs(targetpath + FS + "src" + FS + "test")
        os.makedirs(targetpath + FS + "src" + FS + "test" + FS + "java")
        os.makedirs(targetpath + FS + "src" + FS + "test" + FS + "resources")
        os.makedirs(targetpath + FS + "src" + FS + "main" + FS + "java")
        os.makedirs(targetpath + FS + "src" + FS + "main" + FS + "resources")
        # os.makedirs(targetpath + FS + "src" + FS + "main" + FS + "webapp")
        # os.makedirs(targetpath + FS + "src" + FS + "main" + FS + "webapp" + FS + "WEB-INF")

    def copyStaticFiles(self):
        print "====", self.project.group.staticFileName;
        if self.project.group.staticFileName:
            olddir = self.project.group.staticFileName
            newdir = self.project.targetpath + FS + "src" + FS + "main" + FS + "webapp"
            shutil.copytree(olddir, newdir, False)
        else:
            print "no static files."

    def load_conf(self):
        conf = json.loads(open(CONF_PATH).read())
        # print conf

        group_def = {}
        for group in conf['groupdef']:
            task_list = []
            for task in group['taskdef']:
                task_list.append(
                    Task(task['name'], task['type'], task['folder'], task['filename'], task['templatePath']))
            group_def[group['name']] = Group(group['name'], group['templateName'], group['staticFileName'], task_list)

        self.group_def = group_def

    # 加载项目的定义信息
    def load_pdef(self, pdef):

        tables = []
        try:
            tables = pdef['dbinfo']['tables']
        except:
            pass

        # print pdef
        # 加载项目定义信息
        if not pdef['project'].has_key('group'):
            pdef['project']['group'] = "qdingweb-v3"

        if not pdef['dbinfo'].has_key('type'):
            pdef['dbinfo']['type'] = "mysql"

        self.project = Project(
            pdef['project']['folder_name'],
            pdef['project']['name'],
            pdef['project']['desc'],
            pdef['dbinfo']['type'],
            pdef['dbinfo']['host'],
            pdef['dbinfo']['port'],
            pdef['dbinfo']['name'],
            pdef['dbinfo']['username'],
            pdef['dbinfo']['password'],
            tables,
            pdef['project']['packageName'],
            self.group_def[pdef['project']['group']]
        )

        db_url = 'mysql://%s:%s@%s:%s/%s'
        schema_sql = """
            select TABLE_SCHEMA,TABLE_NAME,COLUMN_NAME,COLUMN_COMMENT 
            from information_schema.`COLUMNS`  where 
            TABLE_SCHEMA = '%s' 
            """ % self.project.db_name
        if self.project.db_type == 'oracle':
            db_url = 'oracle://%s:%s@%s:%s/%s'
            schema_sql = """
            select a.OWNER,a.TABLE_NAME,a.COLUMN_NAME,b.COMMENTS 
            from all_tab_cols a inner join user_col_comments b on a.COLUMN_NAME = b.COLUMN_NAME
            where a.owner = '%s'
            """ % self.project.db_username

        engine = create_engine(db_url % (
        self.project.db_username, self.project.db_password, self.project.db_host, self.project.db_port,
        self.project.db_name),encoding='utf8')

        #engine = create_engine('oracle://scott:a@10.37.223.134:1521/orcl')

        insp = reflection.Inspector.from_engine(engine)
        # print insp.get_table_names()

        self.dbconn = engine.connect()

        self.field_dict = {}
        try:
            
            results = self.dbconn.execute(schema_sql).fetchall()

            print results
            for r in results:
                # print r[3].encode('utf-8')
                if r[3]:
                    self.field_dict[(r[1], r[2])] = r[3].encode('utf-8')
        except Exception, e:
            print e
            print schema_sql
        self.dbconn.close()

        print self.field_dict

        # 加载项目实体定义
        entityList = []
        for table_name in insp.get_table_names():
            if self.project.db_tables and table_name not in self.project.db_tables:
                continue

            logging.info("reflection table:" + table_name)
            entity = Entity(table_name, table_name, table_name)

            field_list = []
            for c in insp.get_columns(table_name):
                # 获取注释
                lable = ""
                if self.field_dict.has_key((table_name, c['name'])):
                    lable = self.field_dict[(table_name, c['name'])]

                field_list.append(Field(
                    c['name'],
                    c['type'],
                    lable.encode("utf-8")
                ))
            entity.set_fields(field_list)

            entityList.append(entity)

            # print entity.to_dict()

        self.project.set_entitys(entityList)
