#! /usr/bin/env python
# -*- coding: UTF-8 -*-

import logging

class Field():

    def __init__(self,label,dbName,dbType,javaName,javaType,isPrimaryKey,isSearchable):
        self.label = label
        self.dbName = dbName
        self.dbType = dbType
        self.javaName = javaName
        self.javaType = javaType
        self.isPrimaryKey = isPrimaryKey
        self.isSearchable = isSearchable
    
    def to_dict(self):
        return self.__dict__
