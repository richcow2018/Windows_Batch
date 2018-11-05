:: Make a Windows Backup in NAS drive \\abc201.service.abc.com\SL184311-1\WinsBackup\%hostname%\%DATE:~0,3%
:: Process everyday at 3:00am
:: Older than 7 days backup will be removed
:: implemented by Jimmy @ 13Apr2018

echo " ====  Start Backup %DATE%  %TIME%  ====" >> d:\log\windowsbackuplog_%date:~-4,4%%date:~-7,2%%date:~-10,2%.log

:: extract the hostname and set it in variable
FOR /F %%H IN ('hostname') DO SET hostnamevar=%%H

:: define the NAS path variable 
set NASPATH=\\abc201.service.abc.com\SL184311-1\WinsBackup

:: define the Full and sub backup path variable 
set FullBackupPath=%NASPATH%\%hostnamevar%\%DATE:~0,3%
set SubBackupPath=%NASPATH%\%hostnamevar%

:: echo %FullBackupPath%
:: mount NAS drive as K:
if exist K:\ ( net use K: /delete  )
net use K: \\abc201.service.abc.com\SL184311-1\WinsBackup /user:username password /persistent:yes

:: if \\abc201.service.abc.com\SL184311-1\WinsBackup\hostname\%DATE:~0,3% not exist, will create it
if not exist %SubBackupPath% (mkdir %SubBackupPath%)
if not exist %FullBackupPath% (mkdir %FullBackupPath%) 

:: incremental backup
wbadmin start backup -backupTarget:%FullBackupPath% -include:C: -allCritical -quiet -vssFull >> d:\log\windowsbackuplog_%date:~-4,4%%date:~-7,2%%date:~-10,2%.log

:: check if any backups older 7 days, it will be removed 
Wbadmin delete backup -keepversions:7 -backupTarget:%FullBackupPath% -quiet

:: unmount NAS drive as K:
if exist K:\ ( net use K: /delete  )

echo " ====  End Backup %DATE%  %TIME%  ====" >> d:\log\windowsbackuplog_%date:~-4,4%%date:~-7,2%%date:~-10,2%.log