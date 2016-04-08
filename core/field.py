#! /usr/bin/env python
# -*- coding: UTF-8 -*-

import logging

class Field():

    def __init__(self,dbName,dbType,label):
        self.label = label
        self.dbName = dbName
        self.dbType = str(dbType)
        self.javaName = self.get_java_name()
        self.javaType = self.get_java_type()
        self.isPrimaryKey = 0
        self.isSearchable = 0
        print self.dbType,'--->',self.javaType

    def get_java_name(self):
        self.javaName = ''
        for s in self.dbName.split("_"):
            self.javaName = self.javaName + s[0].upper()+s[1:]
        #print self.javaName[0].lower()+self.javaName[1:]
        return self.javaName[0].lower()+self.javaName[1:]

    def get_java_type(self):

        if self.dbType.startswith('VARCHAR'):
            return "String"
        if self.dbType.startswith('BIGINT'):
            return "Long"
        if self.dbType.startswith('INTEGER'):
            return "Integer"
        if self.dbType.startswith('FLOAT'):
            return "Float"
        if self.dbType.startswith('DOUBLE'):
            return "Double"
        if self.dbType.startswith('DATE'):
            return "Date"
        if self.dbType.startswith('TINYINT'):
            return "Date"
        if self.dbType.startswith('TIMESTAMP'):
            return "Date"
        if self.dbType.startswith('DECIMAL'):
            return "Double"
        if self.dbType.startswith('LONGTEXT'):
            return "String"
        if self.dbType.startswith('TEXT'):
            return "String"

    def to_dict(self):
        return self.__dict__
