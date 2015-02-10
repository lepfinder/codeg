# Readme

## 概述

codeg是一个轻量级的代码生成器内核（代码仅300行左右），基于Python和jinja2开发，你可以定制自己的项目模板，快速生成可以直接运行的工程项目。

## 快速上手

下载源码
```
https://github.com/lepfinder/codeg
```
执行根目录的codeg.py可以生成demo工程，在target目录中可以查看生成好的代码。
```
#! /usr/bin/env python
# -*- coding: UTF-8 -*-
from core import Manager

manager = Manager("demo.json")

manager.create()
```

## 创建项目
codeg所有的配置都是json格式。

如果想要定义自己的项目，可以在project_def文件夹中定义项目的配置信息，然后保存成一个单独的文件，修改codeg.py将新保存的文件名作为Manager的参数传入即可。


## 设计思路

- Project
- Groups
- Entity
- Field
- Task

## 模板

jinja2模板文档
http://docs.jinkan.org/docs/jinja2/templates.html#
