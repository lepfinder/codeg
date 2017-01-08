安装 cx_Oracle

![](http://7xo9p3.com1.z0.glb.clouddn.com/markdown/1483859218296.png?imageMogr2/thumbnail/!100p/quality/100!)
出现上面的错误，需要安装oracle的环境

![](http://7xo9p3.com1.z0.glb.clouddn.com/markdown/1483859195494.png?imageMogr2/thumbnail/!100p/quality/100!)




http://www.oracle.com/technetwork/topics/intel-macsoft-096467.html

![](http://7xo9p3.com1.z0.glb.clouddn.com/markdown/1483858266233.png?imageMogr2/thumbnail/!100p/quality/100!)

instantclient-basic-macos.x64-12.1.0.2.0.zip

instantclient-sdk-macos.x64-12.1.0.2.0.zip 

Installation

Installing Instant Client 12.1 on OS X

Instant Client 12.1.0.2 supports OS X El Capitan, Yosemite and Mavericks.


1. Download the desired Instant Client ZIP files. All installations require the Basic or Basic Lite package.

2. Unzip the packages into a single directory such as "~/instantclient_12_1". For example, to use SQL*Plus:

cd ~
unzip instantclient-basic-macos.x64-12.1.0.2.0.zip
unzip instantclient-sqlplus-macos.x64-12.1.0.2.0.zip
unzip instantclient-sdk-macos.x64-12.1.0.2.0.zip
                        

3. Create the appropriate libclntsh.dylib link for the version of Instant Client. For example:

cd ~/instantclient_12_1
ln -s libclntsh.dylib.12.1 libclntsh.dylib
                                             

4. To be able to run SQL*Plus, update PATH. For example:

export PATH=~/instantclient_12_1:$PATH
                        

5. Run SQL*Plus and connect using your database credentials and connection string:

sqlplus hr/welcome@localhost/orcl





![](http://7xo9p3.com1.z0.glb.clouddn.com/markdown/1483860027322.png?imageMogr2/thumbnail/!100p/quality/100!)

https://github.com/kubo/fix_oralib_osx


install_name_tool -add_rpath ~/developer/instantclient_12_1 /Users/xiexiyang/workspace/github/codeg/venv/lib/python2.7/site-packages/cx_Oracle.so
