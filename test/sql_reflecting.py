#! /usr/bin/env python
# -*- coding: UTF-8 -*-
from sqlalchemy import *
from sqlalchemy.engine import reflection


db_username = 'dev'
db_password = '458kT*!W'
db_host = '10.37.253.31'
db_port = 3307
db_name = 'qding_dcenter'

engine = create_engine('mysql://%s:%s@%s:%s/%s' % 
	(db_username,db_password,db_host,db_port,db_name))

insp = reflection.Inspector.from_engine(engine)

tables = insp.get_table_names()
print insp.default_schema_name

for table_name in tables:
	print table_name
	for c in insp.get_columns(table_name):
		print c
