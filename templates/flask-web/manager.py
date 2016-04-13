#!/usr/bin/env python
#coding=utf-8

import uuid

from flask import Flask, current_app
from flask.ext.script import  Server,Manager,Command

from apollo import create_app

manager = Manager(create_app('config.cfg'))

manager.add_command("runserver", Server('0.0.0.0',port=5000))


if __name__ == "__main__":
    manager.run()
