@ECHO OFF
setlocal

set PROJECT_HOME=%~dp0
set DEMO=Install Demo
set AUTHORS=Andrew Block, Eric D. Schabell
set PROJECT=git@github.com:eschabell/jboss-bpm-in-action-install-demo.git
set PRODUCT=JBoss BPM Suite
set JBOSS_HOME=%PROJECT_HOME%target\jboss-eap-6.4
set SERVER_DIR=%JBOSS_HOME%\standalone\deployments
set SERVER_CONF=%JBOSS_HOME%\standalone\configuration\
set SERVER_BIN=%JBOSS_HOME%\bin
set SRC_DIR=%PROJECT_HOME%\installs
set SUPPORT_DIR=%PROJECT_HOME%\support
set PRJ_DIR=%PROJECT_HOME%\projects
set BPMS=jboss-bpmsuite-6.2.0.GA-installer.jar
set EAP=jboss-eap-6.4.0-installer.jar
set EAP_PATCH=jboss-eap-6.4.4-patch.zip
set VERSION=6.2

REM wipe screen.
cls

echo.
echo ##########################################################################
echo ##                                                                      ##   
echo ##  Setting up the %DEMO%                                         ##
echo ##                                                                      ##   
echo ##                                                                      ##   
echo ##     ####  ####   #   #      ### #   # ##### ##### #####              ##
echo ##     #   # #   # # # # #    #    #   #   #     #   #                  ##
echo ##     ####  ####  #  #  #     ##  #   #   #     #   ###                ##
echo ##     #   # #     #     #       # #   #   #     #   #                  ##
echo ##     ####  #     #     #    ###  ##### #####   #   #####              ##
echo ##                                                                      ##   
echo ##                                                                      ##   
echo ##  brought to you by,                                                  ##   
echo ##             %AUTHORS%                           ##
echo ##                                                                      ##   
echo ##  %PROJECT%  ##
echo ##                                                                      ##  
echo ##########################################################################
echo.

REM make some checks first before proceeding.	
if exist %SRC_DIR%\%EAP% (
        echo Product sources are present...
        echo.
) else (
        echo Need to download %EAP% package from the Customer Support Portal
        echo and place it in the %SRC_DIR% directory to proceed...
        echo.
        GOTO :EOF
)

if exist %SRC_DIR%\%EAP_PATCH% (
        echo Product patches are present...
        echo.
) else (
        echo Need to download %EAP_PATCH% package from the Customer Support Portal
        echo and place it in the %SRC_DIR% directory to proceed...
        echo.
        GOTO :EOF
)

if exist %SRC_DIR%\%BPMS% (
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
call java -jar %SRC_DIR%/%EAP% %SUPPORT_DIR%\installation-eap -variablefile %SUPPORT_DIR%\installation-eap.variables


if not "%ERRORLEVEL%" == "0" (
  echo.
	echo Error Occurred During JBoss EAP Installation!
	echo.
	GOTO :EOF
)

call set NOPAUSE=true

echo.
echo Applying JBoss EAP patch now...
echo.
call %JBOSS_HOME%/bin/jboss-cli.bat --command="patch apply %SRC_DIR%/%EAP_PATCH% --override-all"

if not "%ERRORLEVEL%" == "0" (
  echo.
	echo Error Occurred During JBoss EAP Patch Installation!
	echo.
	GOTO :EOF
)

echo.
echo BPM Suite installer running now...
echo.
call java -jar %SRC_DIR%/%BPMS% %SUPPORT_DIR%\installation-bpms -variablefile %SUPPORT_DIR%\installation-bpms.variables

if not "%ERRORLEVEL%" == "0" (
  echo.
	echo Error Occurred During JBoss BPM Suite Installation!
	echo.
	GOTO :EOF
)

echo.
echo - enabling demo accounts role setup in application-roles.properties file...
echo.
xcopy /Y /Q "%SUPPORT_DIR%\application-roles.properties" "%SERVER_CONF%"
echo. 

echo - setting up standalone.xml configuration adjustments...
echo.
xcopy /Y /Q "%SUPPORT_DIR%\standalone.xml" "%SERVER_CONF%"
echo.

echo - setup email task notification users...
echo.
xcopy /Y /Q "%SUPPORT_DIR%\userinfo.properties" "%SERVER_DIR%\business-central.war\WEB-INF\classes\"

echo.
echo You can now start the %PRODUCT% with %SERVER_BIN%\standalone.bat
echo.
echo You can open business central in browser at:
echo.
echo  localhost:8080/business-central 
echo.
echo and login as user: erics and password: bpmsuite1!
echo.
echo %PRODUCT% %VERSION% %DEMO% Setup Complete.
echo.
