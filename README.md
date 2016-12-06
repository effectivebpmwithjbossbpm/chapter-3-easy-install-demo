Chapter 3 - Easy Install Demo 
=============================
This is an example project for the Effective Business Process Management with JBoss BPM book, 
used in chapter 3. It is a project to automate the installation of the product JBoss BPM Suite 
with preconfigured admin user and sane project defaults.


Option 1 - Install on your machine
----------------------------------
1. [Download and unzip.](https://github.com/effectivebpmwithjbossbpm/chapter-3-easy-install-demo/archive/master.zip)

2. Add product installer to installs directory.

3. Run 'init.sh' or 'init.bat' file. 'init.bat' must be run with Administrative privileges. 

4. Login to http://localhost:8080/business-central  (u:erics / p:bpmsuite1!)

5. Enjoy installed and configured JBoss BPM Suite.


Option 2 - Generate containerized installation
----------------------------------------------
The following steps can be used to configure and run the demo in a container

1. [Download and unzip.](https://github.com/effectivebpmwithjbossbpm/chapter-3-easy-install-demo/archive/master.zip)

2. Add product installer to installs directory.

3. Build demo image.

	```
	docker build -t effectivebpmwithjbossbpm/chapter-3-easy-install-demo .
	```
4. Start demo container

	```
	docker run -it -p 8080:8080 -p 9990:9990 effectivebpmwithjbossbpm/chapter-3-easy-install-demo
	```
Login to http://localhost:8080/business-central (u:erics / p:bpmsuite1!) 


Released versions
-----------------
See the tagged releases for the following versions of the product:

- v1.2 - JBoss BPM Suite 6.4.0 installed on JBoss EAP 7.0.0 and optional containerized install.

- v1.1 - JBoss BPM Suite 6.3.0 installed on JBoss EAP 6.4.7 and optional containerized install.

- v1.0 - JBoss BPM Suite 6.2.0 installed on JBoss EAP 6.4.4.

![BPM Suite](https://raw.githubusercontent.com/effectivebpmwithjbossbpm/chapter-3-easy-install-demo/master/docs/demo-images/bpmsuite.png)
