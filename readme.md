## 概述

codeg是一个轻量级的代码生成器内核（代码仅300行左右），基于Python和jinja2开发，你可以定制自己的项目模板，快速生成可以直接运行的工程项目。


## 功能特点
1. 根据数据库连接配置可以支持直接生成java工程
2. 支持生成指定表的工程代码
3. 支持读取数据库表注释，自动完成java类注释
4. 微框架设计，方便自己修改模板完成自己的重复性代码工作

![](http://7xo9p3.com1.z0.glb.clouddn.com/markdown/1448276888720.png?imageMogr2/thumbnail/!50p/quality/100!)

## 依赖

- python 2.7.3 +
- easy_install virtualenv

如果安装时出现如下错误：EnvironmentError: mysql_config not found
```
sudo apt-get install libmysqld-dev
```
error: command 'x86_64-linux-gnu-gcc' failed with exit status 1
```
sudo apt-get install python2.7-dev
```

## 快速上手

1. 安装
```
下载源码
git clone git@github.com:lepfinder/codeg.git

cd ~/workspace/codeg
. venv/bin/activate
pip install -r requirements.txt

以上是mac上的操作,如果 windows 自己研究 
```

2. 修改project_def目录下的qdingweb-base.json配置文件,支持MYSQL或ORACLE数据库。
```
MYSQL:
{
  "project": {
    "folder_name": "qding-brick",
    "name": "hotcycle",
    "port": "8888",
    "desc": "基础数据",
    "packageName": "com.qding.brick",
    "group": "qdingweb"
  },
  "dbinfo": {
    "host": "10.37.253.31",
    "port": "3307",
    "name": "qding_brick",
    "username": "dev",
    "password": "",
    "tables" : [
      "keyword_conf"
    ]
  }
}
```

``` 
ORACLE:
{
  "project": {
    "folder_name": "qding-oracle",
    "name": "oracle",
    "desc": "反作弊系统",
    "packageName": "com.qding.oracle"
  },
  "dbinfo": {
    "type": "oracle",
    "host": "10.37.223.134",
    "port": "1521",
    "name": "orcl",
    "username": "SCOTT",
    "password": "a"
  }
}
```

3. 执行根目录的codeg.py可以生成demo工程，在target目录中可以查看生成好的代码。
```
python codeg.py
```


manager.py中可以指定使用的项目配置文件，在有多个工程的时候会比较有用。
```
#! /usr/bin/env python
# -*- coding: UTF-8 -*-
from core import Manager

manager = Manager()
manager.set_pdef_name("qdingweb-base.json")

manager.create()

```

## 部署
```
安装setuptools
pip instlal virtualenv
virtualenv venv
. venv/bin/activate

pip install -r requirements.txt

安装过程中如果出现如下错误,参考如下解决方案解决.
安装mysql-python
下载MySQL-python-1.2.3.tar.gz（见附件），解压到指定目录。
到解压后的MySQL-python-1.2.3目录下编译配置MySQL-python：
python setup.py build
此时系统报错：EnvironmentError: mysql_config not found
很明显没有mysql_config这个文件
执行find / -name mysql_config，没有任何数据，表明系统中没有mysql_config这个文件


网上有人解释说使用apt-get安装的MySQL是没有mysql_config这个文件的
解决办法：
（1）ubuntu下
执行sudo apt-get install libmysqld-dev
（2）fedora下
执行 sudo yum install python-devel
若出现：my_config.h:没有那个文件或目录，就执行：sudo yum install mysql-devel
注意：yum也是python写的，默认是调用/usr/bin/python的，这是系统本身自带的python，自己安装的一般在/usr/local/bin/python，所以最好别把系统自带的python给卸载掉了，自己下载的python没有yum模块。

此时执行  find / -name mysql_config 在/usr/bin/下发现了这个文件
然后修改MySQL-python-1.2.3目录下的site.cfg文件
去掉mysql_config=XXX这行的注释，并改成mysql_config=/usr/bin/mysql_config（以mysql_config文件所在机器上的目录为准）
执行下面命令，此时可以成功编译安装了：
python setup.py build
python setup.py install
```

## 项目配置
codeg所有的配置都是json格式。

每一个项目都是一个单独的配置文件，一个例子如下所示：
```
{
  "project": {
    "folder_name": "qding-brick",
    "name": "hotcycle",
    "port": "8888",
    "desc": "基础数据",
    "packageName": "com.qding.brick",
    "group": "qdingweb"
  },
  "dbinfo": {
    "host": "10.37.253.31",
    "port": "3307",
    "name": "qding_brick",
    "username": "dev",
    "password": "",
    "tables" : [
      "keyword_conf"
    ]
  }
}
```

目前生成器支持如下三种项目的生成：

- jfinalweb
	- 基于jfinal的一个web项目
- mybatis-base
	- 可以生成mybatis的映射文件、dao
- qding-web
	- 可以生成一个基于maven构建的springMVC + mybatis + Hessian的web工程

如果想要定义自己的项目，可以在project_def文件夹中定义项目的配置信息，然后保存成一个单独的文件，修改codeg.py将新保存的文件名作为Manager的参数传入即可。

## web管理界面
codeg基于flask实现了一个简单的web管理页面，可以在页面中完成项目配置，在服务器端生成代码后，提供下载到本地。假如在公司，可以部署一个公用的服务，供大家一起使用。

### 首页
![](http://7xo9p3.com1.z0.glb.clouddn.com/markdown/1448501714488.png?imageMogr2/thumbnail/!50p/quality/100!)

根据现有的配置信息做简单修改后，点击生成按钮，完成项目的自动生成。

### 下载页
![](http://7xo9p3.com1.z0.glb.clouddn.com/markdown/1448501770828.png?imageMogr2/thumbnail/!50p/quality/100!)
每次生成会保留项目的配置信息，供参考和重复使用，以及排查错误使用。


## 设计思路

生成器包含如下的几个基本模块：

- Project
- Group
- Entity
- Field
- Task

Project 代表一个工程属性，比如项目名称、包名、数据库相关配置以及该项目使用哪一个Group任务组。

Group 包含了一组Task可以完成一组任务，换另外一种说法，Group可以定义不同的项目模板。

Task 是一个任务描述，用来完成模板文件到最终文件的生成，其定义了原始的模板文件以及最终生成的文件的文件名及目标地址。

Entity 代表项目中的一个实体，基于此可以完成数据库表的创建，以及程序中各组件文件的生成，比如Domain、Dao和Service等。一个Entity包含多个Field。

Field 代表一个实体的一个字段，标示了某个字段的名称、db类型、java类型和是否为主键、是否可检索等属性。

## 模板

jinja2模板文档
http://docs.jinkan.org/docs/jinja2/templates.html#

## 高级特性
假如自己平时也有一些重复性的编码工作，可以很方便的使用codeg完成一个简单的代码生成模板。
codeg提供了足够的扩展能力支持各种代码生成。

如何自己设计模板？
首先看codeg目前支持的三种项目生成：JFinal、mybatis-base、qdingweb
每一个模板都是一组任务的聚合，比如qdingweb，有如下几种任务：

- 生成java bean
- 生成pom文件
- 生成dao
- 生成service
- 生成mybatis 映射文件
- ...

自己的模板也可以按此思路完成任务的拆解，然后编写原始的template文件下面是codeg的目录结构：
![](http://7xo9p3.com1.z0.glb.clouddn.com/markdown/1448502203703.png?imageMogr2/thumbnail/!50p/quality/100!)
如上 conf/codeg.json 配置了任务组，templates下的每个文件夹是各自的基础模板。如果需要自己扩展，简单的步骤如下：

1. 在 conf/codeg.josn 中添加一个节点，配置任务列表
2. 在 templates文件夹下新建一个文件夹，里面编写自己的模板文件
3. 再project_def文件夹下创建一个项目配置文件，定义项目配置
4. 测试生成




## TODO
- 生成单元测试
- 自动生成接口文档
- 自动生成接口测试程序
- 完成一个CS/BS的客户端程序，来完成项目的配置和实体的定义[已完成bs客户端]


