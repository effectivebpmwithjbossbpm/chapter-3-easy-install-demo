@ECHO OFF
setlocal

set PROJECT_HOME=%~dp0
set DEMO=Chapter 3 Easy Install Demo
set AUTHORS=Andrew Block, Eric D. Schabell
set PROJECT=git@github.com:effectivebpmwithjbossbpm/chapter-3-easy-install-demo.git"
set PRODUCT=JBoss BPM Suite
set JBOSS_HOME=%PROJECT_HOME%target\jboss-eap-7.0
set SERVER_DIR=%JBOSS_HOME%\standalone\deployments
set SERVER_CONF=%JBOSS_HOME%\standalone\configuration\
set SERVER_BIN=%JBOSS_HOME%\bin
set SRC_DIR=%PROJECT_HOME%installs
set SUPPORT_DIR=%PROJECT_HOME%support
set PRJ_DIR=%PROJECT_HOME%projects
set BPMS=jboss-bpmsuite-6.4.0.GA-deployable-eap7.x.zip
set EAP=jboss-eap-7.0.0-installer.jar
set VERSION=6.4

REM wipe screen.
cls

echo.
echo ###############################################################################
echo ##                                                                           ##   
echo ##  Setting up the %DEMO%                               ##
echo ##                                                                           ##   
echo ##                                                                           ##   
echo ##     ####  ####   #   #      ### #   # ##### ##### #####                   ##
echo ##     #   # #   # # # # #    #    #   #   #     #   #                       ##
echo ##     ####  ####  #  #  #     ##  #   #   #     #   ###                     ##
echo ##     #   # #     #     #       # #   #   #     #   #                       ##
echo ##     ####  #     #     #    ###  ##### #####   #   #####                   ##
echo ##                                                                           ##   
echo ##                                                                           ##   
echo ##  brought to you by,                                                       ##   
echo ##             %AUTHORS%                                ##
echo ##                                                                           ##   
echo ##  %PROJECT%  ##
echo ##                                                                           ##  
echo ###############################################################################
echo.

REM make some checks first before proceeding.	
if exist "%SRC_DIR%\%EAP%" (
        echo Product sources are present...
        echo.
) else (
        echo Need to download %EAP% package from the Customer Support Portal
        echo and place it in the %SRC_DIR% directory to proceed...
        echo.
        GOTO :EOF
)

if exist "%SRC_DIR%\%BPMS%" (
        echo Product sources are present...
        echo.
) else (
        echo Need to download %BPMS% package from the Customer Support Portal
        echo and place it in the %SRC_DIR% directory to proceed...
        echo.
        GOTO :EOF
)

REM Move the old JBoss instance, if it exists, to the OLD position.
if exist %JBOSS_HOME% (
         echo - removing existing JBoss product install...
         echo.
        
         rmdir /s /q "%JBOSS_HOME%"
 )


REM Run installers.
echo EAP installer running now...
echo.
call java -jar %SRC_DIR%\%EAP% %SUPPORT_DIR%\installation-eap -variablefile %SUPPORT_DIR%\installation-eap.variables


if not "%ERRORLEVEL%" == "0" (
  echo.
	echo Error Occurred During JBoss EAP Installation!
	echo.
	GOTO :EOF
)

echo.
echo BPM Suite installer running now...
echo.
cscript /nologo %SUPPORT_DIR%\unzip.vbs %SRC_DIR%\%BPMS% %PROJECT_HOME%\target

if not "%ERRORLEVEL%" == "0" (
  echo.
	echo Error Occurred During JBoss BPM Suite Installation!
	echo.
	GOTO :EOF
)

echo.
echo - enabling demo account setup...
echo.
call %JBOSS_HOME%\bin\add-user.bat -a -r ApplicationRealm -u erics -p bpmsuite1! -ro analyst,admin,manager,user,kie-server,kiemgmt,rest-all --silent
echo. 

echo - setting up standalone.xml configuration adjustments...
echo.
xcopy /Y /Q %SUPPORT_DIR%\standalone.xml %SERVER_CONF%
echo.

echo - setup email task notification users...
echo.
xcopy /Y /Q %SUPPORT_DIR%\userinfo.properties %SERVER_DIR%\business-central.war\WEB-INF\classes\

echo.
echo ========================================================================
echo =                                                                      =
echo =  You can now start the %PRODUCT% with:                         =
echo =                                                                      =
echo =   %SERVER_BIN%\standalone.bat                           =
echo =                                                                      =
echo =  Log in into business central at:                                    =
echo =                                                                      =
echo =    http://localhost:8080/business-central  [u:erics / p:bpmsuite1!]  =
echo =                                                                      =
echo =  %PRODUCT% %VERSION% %DEMO% Setup Complete.            =
echo =                                                                      =
echo ========================================================================
echo.

