#! /usr/bin/env python
# -*- coding: UTF-8 -*-

import os
import json
import MySQLdb
from flask import Flask
from flask import render_template,request,redirect,url_for,flash,send_from_directory
from core import Manager,TARGET_PATH
from db import DButils
from ziputils import zip_dir
from config import *

app = Flask(__name__)

@app.route("/")
def index():
	return render_template("index.html")

@app.route("/help")
def help():
	return render_template("help.html")

@app.route("/gen", methods=['GET', 'POST'])
def gen():
	content = request.form['config']
	
	pdef = json.loads(content)
	pdef['project']['group'] = 'qdingweb'

	#pdef['dbinfo']['host'] = db_host
	#pdef['dbinfo']['port'] = db_port
	#pdef['dbinfo']['username'] = db_user
	#pdef['dbinfo']['password'] = db_passwd


	manager = Manager()
	manager.set_pdef(pdef)

	manager.create_zip()

	zip_dir(manager.project.targetfolder,os.path.join(manager.project.targetfolder,manager.project.folder_name+".zip"))

	try:
		db = DButils()
		sql = "insert into codeg.gen_log(pdef_content,filename,uuid) values (%s,%s,%s)"
		db.execute(sql,(content.encode("utf-8"),manager.project.folder_name,manager.project.uuid_name))
	finally:
		db.close_db()

	return redirect("/list")

@app.route("/list", methods=['GET', 'POST'])
def list():

	field_dict = {}
	projects = []
	try:
		db = DButils()
		sql = "select * from codeg.gen_log order by create_at desc limit 20"
		results = db.fetchmany(sql)

		for r in results:
			projects.append(
				{
					"id":r[0],
					"create_at":r[1],
					"config":r[2],
					"name":r[3]
				}
			)

	finally:
		db.close_db()

	return render_template("list.html",projects = projects)

@app.route("/download/<path:id>")
def downloader(id):
	dirname = ""
	filename = ""
	try:
		db = DButils()
		sql = "select * from codeg.gen_log where id = " + id
		r = db.fetchone(sql)
		dirname = os.path.join("target",r[4])
		filename = r[3] +".zip"

	finally:
		db.close_db()
	print dirname,filename
	return send_from_directory(dirname,filename,as_attachment=True)

if __name__ == '__main__':
    app.run(debug=True,host='0.0.0.0',port=5001)
