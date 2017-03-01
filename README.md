Chapter 3 - Easy Install Demo 
=============================
This is an example project for the Effective Business Process Management with JBoss BPM book, 
used in chapter 3. It is a project to automate the installation of the product JBoss BPM Suite 
with preconfigured admin user and sane project defaults.


Option 1 - Install on your machine
----------------------------------
1. [Download and unzip.](https://github.com/effectivebpmwithjbossbpm/chapter-3-easy-install-demo/archive/master.zip)

2. Download JBoss EAP & JBoss BPM Suite, add to installs directory (see installs/README).

3. Run 'init.sh' or 'init.bat' file. 'init.bat' must be run with Administrative privileges. 

4. Login to http://localhost:8080/business-central  (u:erics / p:bpmsuite1!)

5. Enjoy installed and configured JBoss BPM Suite.


Option 2 - Generate containerized installation
----------------------------------------------
The following steps can be used to configure and run the demo in a container

1. [Download and unzip.](https://github.com/effectivebpmwithjbossbpm/chapter-3-easy-install-demo/archive/master.zip)

2. Download JBoss EAP & JBoss BPM Suite, add to installs directory (see installs/README).

3. Build demo image.

	```
	docker build -t effectivebpmwithjbossbpm/chapter-3-easy-install-demo .
	```
4. Start demo container

	```
	docker run -it -p 8080:8080 -p 9990:9990 -p 8001:8001 effectivebpmwithjbossbpm/chapter-3-easy-install-demo
	```

Login to http://localhost:8080/business-central (u:erics / p:bpmsuite1!) 

Read-write access to container JBoss BPM Suite git repo is available through ssh. For example, if you create a repo called 'BackOffice', clone it locally with read-write access as follows:

   ```
   $ git clone ssh://erics@localhost:8001/BackOffice

   Cloning into 'BackOffice'...
   The authenticity of host '[localhost]:8001 ([::1]:8001)' can't be established.
   DSA key fingerprint is SHA256:ok9ukS2j16
   Are you sure you want to continue connecting (yes/no)? yes

   Warning: Permanently added '[localhost]:8001' (DSA) to the list of known hosts.
   Password authentication
   Password: bpmsuite1!

   remote: Counting objects: 3, done
   remote: Finding sources: 100% (3/3)
   remote: Getting sizes: 100% (2/2)
   remote: Compressing objects: 100% (116/116)
   Receiving objects: 100% (3/3), done.
   remote: Total 3 (delta 0), reused 0 (delta 0)
   ```


Released versions
-----------------
See the tagged releases for the following versions of the product:

- v1.2 - JBoss BPM Suite 6.4.0 installed on JBoss EAP 7.0.0 and optional containerized install.

- v1.1 - JBoss BPM Suite 6.3.0 installed on JBoss EAP 6.4.7 and optional containerized install.

- v1.0 - JBoss BPM Suite 6.2.0 installed on JBoss EAP 6.4.4.

![BPM Suite](https://raw.githubusercontent.com/effectivebpmwithjbossbpm/chapter-3-easy-install-demo/master/docs/demo-images/bpmsuite.png)
