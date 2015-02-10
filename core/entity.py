#! /usr/bin/env python
# -*- coding: UTF-8 -*-

import logging

class Entity():

    def __init__(self,name,label):
        self.name = name
        self.label = label

    def set_fields(self,fields):
        self.fields = fields
    
    def to_dict(self):
        fieldList = []
        for field in self.fields:
            fieldList.append(field.to_dict())

        return {
            "name":self.name,
            "label":self.label,
            "fieldList":fieldList
        }