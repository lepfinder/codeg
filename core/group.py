#! /usr/bin/env python
# -*- coding: UTF-8 -*-
from task import Task
from constant import *

class Group:

    def __init__(self,name,templateName,staticFileName,task_list):
        self.name = name
        self.templateName = templateName
        self.staticFileName = ""
        if staticFileName:
        	self.staticFileName = os.path.join(BASEPATH,"templates",templateName,"static",staticFileName)
        self.task_list = task_list
       