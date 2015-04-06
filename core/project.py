#! /usr/bin/env python
# -*- coding: UTF-8 -*-
import logging
from constant import *
from jinja2 import Environment, FileSystemLoader

class Project():

    def __init__(self,name,port,desc,jdbcurl,username,password,packageName,group):
        self.name = name
        self.port = port
        self.desc = desc
        self.jdbcurl = jdbcurl
        self.username = username
        self.password = password
        self.packageName = packageName
        self.targetpath =  os.path.join(BASEPATH,"target",self.name)
        self.group = group
        self.env = Environment(loader=FileSystemLoader("templates/%s" % group.templateName))

    def set_entitys(self,entitys):
        self.entitys = entitys

    def run_group(self):
        for task in self.group.task_list:
            task.run(self)

    def to_dict(self):
        entityList = []
        for entity in self.entitys:
            entityList.append(entity.to_dict())

        return {
            "name":self.name,
            "port":self.port,
            "desc":self.desc,
            "jdbcurl":self.jdbcurl,
            "username":self.username,
            "password":self.password,
            "packageName":self.packageName,
            "entityList":entityList
        }