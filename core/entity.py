#! /usr/bin/env python
# -*- coding: UTF-8 -*-

import logging

class Entity():

    def __init__(self,name,label,tableName):
        self.name = name
        self.label = label
        self.tableName = tableName

    def set_fields(self,fields):
        self.fields = fields
    
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