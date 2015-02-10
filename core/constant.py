#! /usr/bin/env python
# -*- coding: UTF-8 -*-
import os
from jinja2 import Environment, FileSystemLoader

FS = "\\"
BASEPATH = os.getcwd()
PROJECT_DEF_PATH = os.path.join(BASEPATH,"project_def")
CONF_PATH = os.path.join(BASEPATH,"conf","codeg.json")
TEMPLATE_PATH = os.path.join(BASEPATH,"templates","jfinalweb")
VIEWPATH = os.path.join(TEMPLATE_PATH,"common","view","dwz","freemarker")


env = Environment(loader=FileSystemLoader('templates/jfinalweb'))
