::will only keep 5 day windows backup 

echo " ====  Start Backup Delete %DATE%  %TIME%  ====" >> d:\log\fileremoved_C_%date:~-4,4%%date:~-7,2%%date:~-10,2%.log
Wbadmin delete backup -keepversions:5 -backupTarget:D: -quiet
echo " ====  End Backup Delete %DATE%  %TIME%  ====" >> d:\log\fileremoved_C_%date:~-4,4%%date:~-7,2%%date:~-10,2%.log

::files older than 7 days will be deleted

echo " ====  Start File Delete %DATE%  %TIME%  ====" >> d:\log\fileremoved_C_%date:~-4,4%%date:~-7,2%%date:~-10,2%.log
forfiles /p c:\temp\ /s /m * /d -7 /c "cmd /c echo @path >> d:\log\fileremoved_C_%date:~-4,4%%date:~-7,2%%date:~-10,2%.log & cmd /c del /q @path"
echo " ====  End File Delete %DATE%  %TIME%  ====" d:\log\fileremoved_C_%date:~-4,4%%date:~-7,2%%date:~-10,2%.log 

IF errorlevel 1 goto STR

:STR
EXIT /B 1
