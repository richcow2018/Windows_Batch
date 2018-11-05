@echo on
:: remove temp files script
:: Process everyday at 3:00am
:: Remove all temp files.
:: implemented by Jimmy @ 13Apr2018

:: dmp - C:\Users\user.name\AppData\Local\Lotus\Notes\Data\workspace\logs
:: google cache C:\Users\user.name\AppData\Local\Google\Chrome\User Data\Default\Cache
:: google cache C:\Users\user.name\AppData\Local\Google\Chrome\User Data\Default\Media Cache
:: google tmp file C:\Users\user.name\AppData\Local\Google\Chrome\User Data\*.tmp
:: C:\Users\user.name\Desktop\*.pdf
:: C:\Users\user.name\Desktop\*.doc
:: C:\Users\user.name\Desktop\*.docx
:: C:\Users\user.name\Desktop\*.xls
:: C:\Users\user.name\Desktop\*.xlsx
:: C:\Users\user.name\Desktop\*.zip
:: temp - C:\Users\user.name\AppData\Local\Temp
:: Downloads C:\Users\user.name\Downloads
:: Any C:\Users\remwell.ruta\Desktop
:: rd /s /q c:\$Recycle.Bin


SET TempDir=c:\temp
SET SourceDir=C:\Users
SET SourceSubDir=0

::files in c:\temp older than 7 days will be deleted
echo " ====  Start File Delete %DATE%  %TIME%  ====" >> d:\log\FileRemoveTemp_%date:~-4,4%%date:~-7,2%%date:~-10,2%.log
forfiles /p %TempDir% /s /m * /d -7 /c "cmd /c echo @path >> d:\log\FileRemoveTemp_%date:~-4,4%%date:~-7,2%%date:~-10,2%.log & cmd /c del /q @path"


:: clean up google cache in C:\Users\%username%\AppData\Local\Google\Chrome\User Data\Default\Cache
set SourceSubDir=%SourceSubDir%;AppData\Local\Google\Chrome\User Data\Default\Cache
:: SET SourceSubDir=AppData\Local\Google\Chrome\User Data\Default\Cache
:: FOR /D %%X IN ("%SourceDir%\*") DO FOR %%Y IN ("%%~X\%SourceSubDir%\*.*") DO DEL /Q /F "%%~Y" 

:: clean up google media cache in C:\Users\%username%\AppData\Local\Google\Chrome\User Data\Default\Cache
set SourceSubDir=%SourceSubDir%;AppData\Local\Google\Chrome\User Data\Default\Media Cache
:: SET SourceSubDir=AppData\Local\Google\Chrome\User Data\Default\Media Cache
:: FOR /D %%X IN ("%SourceDir%\*") DO FOR %%Y IN ("%%~X\%SourceSubDir%\*.*") DO DEL /Q /F "%%~Y" 

:: clean up temp files in C:\Users\%username%\AppData\Local\Temp
set SourceSubDir=%SourceSubDir%;AppData\Local\Temp
:: FOR /D %%X IN ("%SourceDir%\*") DO FOR %%Y IN ("%%~X\%SourceSubDir%\*.*") DO DEL /Q /F "%%~Y" 

:: clean up download files in C:\Users\%username%\Downloads
set SourceSubDir=%SourceSubDir%;Downloads

 for %%a in (%SourceSubDir%) do (
	 if %%a GTR 0 (
		FOR /D %%X IN ("%SourceDir%\*") DO FOR %%Y IN ("%%~X\%%a\*.*") DO DEL /Q /F "%%~Y" 
	 )
 )

:: clean up google tmp files in C:\Users\%username%\AppData\Local\Google\Chrome\User Data\*.tmp
set SourceSubDir=AppData\Local\Google\Chrome\User Data
FOR /D %%X IN ("%SourceDir%\*") DO FOR %%Y IN ("%%~X\%SourceSubDir%\*.tmp") DO DEL /Q /F "%%~Y" 

:: clean up .dmp in C:\Users\%username%\AppData\Local\Lotus\Notes\Data\workspace\logs
:: set SourceSubDir=%SourceSubDir%;AppData\Local\Lotus\Notes\Data\workspace\logs
 SET SourceSubDir=AppData\Local\Lotus\Notes\Data\workspace\logs
 FOR /D %%X IN ("%SourceDir%\*") DO FOR %%Y IN ("%%~X\%SourceSubDir%\*.dmp") DO DEL /Q /F "%%~Y" 


:: empty users' recycle bin
 rd /s /q c:\$Recycle.Bin

echo " ====  End File Delete %DATE%  %TIME%  ====" >> d:\log\FileRemoveTemp_%date:~-4,4%%date:~-7,2%%date:~-10,2%.log 

goto :finish
	
:finish
echo Finished with no error !!!
exit /b 0