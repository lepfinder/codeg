#! /usr/bin/env python
# -*- coding: UTF-8 -*-
import os
import logging
from constant import *
from jinja2 import Template

logging.basicConfig(level=logging.INFO)

class Task():

    def __init__(self,name,taskType,folder,filename,templatePath):
        self.name = name
        self.type = taskType
        self.folder = folder
        self.filename = filename
        self.templatePath = templatePath

    def run(self,project):
        logging.info("task " + self.name + " run");
        
        if "single" == self.type:
            SingleTaskProcesser().process(project,self)
        elif "multiple" == self.type:
            MultiTaskProcesser().process(project,self)

        logging.info("task " + self.name + " end");

    def parse_template(self,project,entity):
        folderTemplate = Template(self.folder)
        folder = folderTemplate.render({
            "project":project.to_dict(),
            "entity":entity.to_dict()
        })

        folder = os.path.join(project.targetpath,folder)

        filenameTemplate = Template(self.filename)
        filename = filenameTemplate.render({
            "project":project.to_dict(),
            "entity":entity.to_dict()
        })

        self.target_folder = folder
        self.target_filepath = os.path.join(folder,filename)

    def parse_template_single(self,project):
        folderTemplate = Template(self.folder)
        folder = folderTemplate.render({
            "project":project.to_dict()
        })

        folder = os.path.join(project.targetpath,folder)

        filenameTemplate = Template(self.filename)
        filename = filenameTemplate.render({
            "project":project.to_dict()
        })

        self.target_folder = folder
        self.target_filepath = os.path.join(folder,filename)


class TaskProcesser():

    def process(self,project,task):
        pass

class MultiTaskProcesser(TaskProcesser):
    def process(self,project,task):
        for entity in project.entitys:
            template = env.get_template(task.templatePath)
            text = template.render({
                "project":project.to_dict(),
                "entity":entity.to_dict()
            })

            task.parse_template(project,entity)

            if not os.path.exists(task.target_folder):
                os.makedirs(task.target_folder)

            f = open(task.target_filepath,"wb").write(text.encode("utf-8"))

class SingleTaskProcesser(TaskProcesser):
    def process(self,project,task):
        template = env.get_template(task.templatePath)
        text = template.render({
            "project":project.to_dict()
        })

        task.parse_template_single(project)

        if not os.path.exists(task.target_folder):
            os.makedirs(task.target_folder)

        f = open(task.target_filepath,"wb").write(text.encode("utf-8"))
    