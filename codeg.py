#! /usr/bin/env python
# -*- coding: UTF-8 -*-
from core import Manager

manager = Manager()
#manager.set_pdef_name("qdingweb-oracle.json")
manager.set_pdef_name("qdingweb-base.json")

manager.create()


