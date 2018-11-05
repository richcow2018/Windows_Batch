:: Make a Windows Backup in NAS drive \\nas201.service.softlayer.com\SL184311-1\WinsBackup\%hostname%
:: Process everyday at 3:00am
:: Older than 7 days backup will be removed
:: implemented by Jimmy @ 13Apr2018

echo " ====  Start Backup %DATE%  %TIME%  ====" >> E:\log\windowsbackuplog_%date:~-4,4%%date:~-7,2%%date:~-10,2%.log

:: extract the hostname and set it in variable
FOR /F %%H IN ('hostname') DO SET hostnamevar=%%H

:: define the NAS path variable 
set NASPATH=\\nas201.service.softlayer.com\SL184311-1\WinsBackup

:: define the Fulll backup path variable 
set FullBackupPath=%NASPATH%\%hostnamevar%

:: echo %FullBackupPath%
:: mount NAS drive as K:
net use K: %NASPATH% /user:SL184311-1 Qima@2017 /persistent:yes

:: if \\nas201.service.softlayer.com\SL184311-1\WinsBackup\hostname not exist, will create it
if not exist %FullBackupPath% (mkdir %FullBackupPath%) 

:: incremental backup
wbadmin start backup -backupTarget:%FullBackupPath% -include:C: -allCritical -quiet -vssFull >> E:\log\windowsbackuplog_%date:~-4,4%%date:~-7,2%%date:~-10,2%.log

echo " ====  End Backup %DATE%  %TIME%  ====" >> E:\log\windowsbackuplog_%date:~-4,4%%date:~-7,2%%date:~-10,2%.log