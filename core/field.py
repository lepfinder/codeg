#! /usr/bin/env python
# -*- coding: UTF-8 -*-

import logging

class Field():

    def __init__(self,name,label,isPrimaryKey,isSearchable,fieldType,longness):
        self.name = name
        self.label = label
        self.isPrimaryKey = isPrimaryKey
        self.isSearchable = isSearchable
        self.fieldType = fieldType
        self.longness = longness
        self.dbtype = self.get_dbtype()
    
    def to_dict(self):
        return self.__dict__

    def get_dbtype(self):
        if "int" == self.fieldType:
            return "int"
        elif "long" == self.fieldType:
            return "long"
        elif "String" == self.fieldType:
            return "varchar"