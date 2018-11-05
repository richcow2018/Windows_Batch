:: Tomcat7 restart schedule job
:: Process everyday at 18:55pm and 8:30am
:: run in C:\Program Files (x86)\Script\
:: edited by Jimmy @18Apr2018

@echo off

echo " ====  Start Tomcat restart %DATE%  %TIME%  ====" >> e:\log\TomcatRestartLog_%date:~-4,4%%date:~-7,2%%date:~-10,2%.log

sc query "Tomcat7" | find "STATE" | find "RUNNING"
IF %ERRORLEVEL%==0 (
	net stop "Tomcat7"
	net start "Tomcat7"
) ELSE (
	net start "Tomcat7"
)

IF errorlevel 1 goto STR

:COMPLETEDNORMALL
echo "** completed normally **" >> e:\log\TomcatRestartLog_%date:~-4,4%%date:~-7,2%%date:~-10,2%.log
goto EXITPROGRAM

:STR
echo "** Error **" >> e:\log\TomcatRestartLog_%date:~-4,4%%date:~-7,2%%date:~-10,2%.log


:EXITPROGRAM
echo " ====  End Tomcat restart %DATE%  %TIME%  ====" >> e:\log\TomcatRestartLog_%date:~-4,4%%date:~-7,2%%date:~-10,2%.log
EXIT /B 1