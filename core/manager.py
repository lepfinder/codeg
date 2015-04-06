#! /usr/bin/env python
# -*- coding: UTF-8 -*-
import json
import logging
import shutil
from project import Project
from group import Group
from entity import Entity
from field import Field
from task import Task
from constant import *
from jinja2 import Environment, FileSystemLoader


class Manager():

    def __init__(self,pdef_name):
        self.pdef_path = os.path.join(PROJECT_DEF_PATH,pdef_name)
        
        self.load_conf()
        self.load_pdef()

    def create(self):
        logging.info("start create project:" + self.project.name)
        
        self.cleandirs()
        self.mkdirs()
        self.copyStaticFiles()

        self.project.run_group()

    def create2(self):
        logging.info("start create project:" + self.project.name)

        self.project.run_group()

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
        #os.makedirs(targetpath + FS + "src" + FS + "main" + FS + "webapp")
        #os.makedirs(targetpath + FS + "src" + FS + "main" + FS + "webapp" + FS + "WEB-INF")

    def copyStaticFiles(self):
        olddir = self.project.group.staticFileName
        newdir = self.project.targetpath + FS + "src" + FS + "main" + FS + "webapp"
        shutil.copytree( olddir, newdir, False)

    def load_conf(self):
        conf = json.loads(open(CONF_PATH).read())
        #print conf

        group_def = {}
        for group in conf['groupdef']:
            task_list = []
            for task in group['taskdef']:
                task_list.append(Task(task['name'],task['type'],task['folder'],task['filename'],task['templatePath']))
            group_def[group['name']] = Group(group['name'],group['templateName'],group['staticFileName'],task_list)

        self.group_def = group_def

    #加载项目的定义信息
    def load_pdef(self):
        logging.info("pdef_path:"+self.pdef_path);
        pdef = json.loads(open(self.pdef_path).read())

        #print pdef
        #加载项目定义信息
        self.project = Project(
            pdef['project']['name'],
            pdef['project']['port'],
            pdef['project']['desc'],
            pdef['dbinfo']['jdbcurl'],
            pdef['dbinfo']['username'],
            pdef['dbinfo']['password'],
            pdef['project']['packageName'],
            self.group_def[pdef['project']['group']]
        )

        #加载项目实体定义
        entityList = []
        for edef in pdef['entity']:
            entity = Entity(edef['name'],edef['label'])

            field_list = []
            for fdef in edef['fields']:
                field_list.append(Field(
                    fdef[0],
                    fdef[1],
                    fdef[2],
                    fdef[3],
                    fdef[4],
                    fdef[5],
                    fdef[6]
                ))

            entity.set_fields(field_list)

            entityList.append(entity)

            #print entity.to_dict()

        self.project.set_entitys(entityList)