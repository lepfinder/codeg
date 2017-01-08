#! /usr/bin/env python
# -*- coding: UTF-8 -*-
import logging
import uuid
from constant import *
from jinja2 import Environment, FileSystemLoader
import datetime
import time


class Project():
    def __init__(self, folder_name, name, desc, db_type, db_host, db_port, db_name, db_username, db_password, db_tables,
                 packageName, group):
        self.folder_name = folder_name
        self.name = name
        self.desc = desc
        self.db_type = db_type
        self.db_host = db_host
        self.db_port = db_port
        self.db_name = db_name
        self.db_username = db_username
        self.db_password = db_password
        self.db_tables = db_tables
        self.packageName = packageName
        self.uuid_name = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S ') + self.folder_name
        self.targetfolder = os.path.join(BASEPATH, "target", self.uuid_name)

        self.targetpath = os.path.join(self.targetfolder, self.folder_name)
        self.group = group
        self.env = Environment(loader=FileSystemLoader("templates/%s" % group.templateName))

    def set_entitys(self, entitys):
        self.entitys = entitys

    def run_group(self):
        for task in self.group.task_list:
            task.run(self)

    def to_dict(self):
        entityList = []
        for entity in self.entitys:
            entityList.append(entity.to_dict())

        return {
            "folder_name": self.folder_name,
            "name": self.name,
            "port": self.db_port,
            "desc": self.desc,
            "db_name": self.db_name,
            "username": self.db_username,
            "password": self.db_password,
            "packageName": self.packageName,
            "entityList": entityList
        }
