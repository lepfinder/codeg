## 书香馆

### 介绍
书香馆是一个基于flask开发的P2P图书分享应用。

主要特点：

- 可以分享自己的藏书
- 可以向周围的人借阅图书
- 一个人同一时间只允许借阅一本图书
- 感谢豆瓣提供图书api
- 部分创意来源于美图的内部图书馆项目


### 快速运行

```
1. 下载并安装依赖库
git clone git@github.com:lepfinder/apollo.git
cd apollo
pip install virtualenv
virtualenv venv


. venv/bin/activate
pip install -r requirments.txt

2. 创建数据库，建表文件db.sql

3. 修改apollo/config.cfg文件，配置数据库url

4. 启动服务
python manager.py runserver
nohup python manager.py runserver &
```

### 问题
1. 如果机器有两个python环境
virtualenv --python=/usr/bin/X11/python2.7 venv
修改系统默认的环境为2.7的，可以用软连接的形式

2. _mysql.c:29:20: fatal error: Python.h: No such file or directory
sudo apt-get install python-dev


### 系统截图演示
首页全部图书
![](http://7xo9p3.com1.z0.glb.clouddn.com/markdown/1452435886759.png?imageMogr2/thumbnail/!50p/quality/100!)

我的个人页面
![](http://7xo9p3.com1.z0.glb.clouddn.com/markdown/1452436069406.png?imageMogr2/thumbnail/!50p/quality/100!)

分享图书
![](http://7xo9p3.com1.z0.glb.clouddn.com/markdown/1452436045766.png?imageMogr2/thumbnail/!50p/quality/100!)

### 设计思路

#### 豆瓣API
https://developers.douban.com/wiki/?title=book_v2

https://api.douban.com/v2/book/isbn/9787513408165

#### oa联合登录
http://localhost:5000/accounts/oa_login/?login_name=xiyang&name=sadf


### change log

2016-01-10:

- 完成图书标签 图书评论功能


2016-01-24:

- 添加操作日志功能
- bugfix：我的图书，没有显示全个人分享的所有图书列表
- bugfix：图书分享，同一个人可以多次分享同一本书


2016-02-22:

- 分享图书和借阅图书时添加图书所在城市属性

2016-03-24
- 添加城市标签功能

### TODO

- 还书添加确认流程
- 日志体系
- 异常处理
- 接入第三方登录
- 优化分享流程
- 添加社交属性

### 开发参考文档
http://stackoverflow.com/questions/17972020/how-to-execute-raw-sql-in-sqlalchemy-flask-app

