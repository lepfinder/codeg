#! /usr/bin/env python
# -*- coding: UTF-8 -*-

import logging

class Entity():

    def __init__(self,name,label,tableName):
        self.name = self.get_name(tableName)
        self.label = label
        self.tableName = tableName

    def set_fields(self,fields):
        self.fields = fields

    def get_name(self,tableName):
        self.javaName = ''
        for s in tableName.split("_"):
            self.javaName = self.javaName + s[0].upper()+s[1:]
        #print self.javaName[0].lower()+self.javaName[1:]
        return self.javaName[0].lower()+self.javaName[1:]

    
    def to_dict(self):
        fieldList = []
        for field in self.fields:
            fieldList.append(field.to_dict())

        return {
            "name":self.name,
            "label":self.label,
            "tableName":self.tableName,
            "fieldList":fieldList
        }