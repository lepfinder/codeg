#!/usr/bin/env python 
# -*- coding: utf-8 -*- 
 
from zipfile import * 
import os
import zipfile 
 
#解压zip文件 
def unzip(): 
    source_zip="c:\\update\\SW_Servers_20120815.zip" 
    target_dir="c:\\update\\" 
    myzip=ZipFile(source_zip) 
    myfilelist=myzip.namelist() 
    for name in myfilelist: 
        f_handle=open(target_dir+name,"wb") 
        f_handle.write(myzip.read(name))       
        f_handle.close() 
    myzip.close() 
 
#添加文件到已有的zip包中 
def addzip(): 
    f = zipfile.ZipFile('archive.zip','w',zipfile.ZIP_DEFLATED) 
    f.write('file_to_add.py') 
    f.close() 
 
#把整个文件夹内的文件打包 
def adddirfile(): 
    f = zipfile.ZipFile('/Users/xiexiyang/workspace/github/codeg/archive.zip','w',zipfile.ZIP_DEFLATED) 
    startdir = "/Users/xiexiyang/workspace/github/codeg/target/aabbbb19-9376-11e5-91bd-d0a637ea2bf7" 
    for dirpath, dirnames, filenames in os.walk(startdir): 
        print dirpath,dirnames,filenames
        for filename in filenames: 
            f.write(os.path.join(dirpath,filename)) 
    f.close() 


if __name__ == '__main__':
    adddirfile()