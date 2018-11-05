dxdiag /t %USERPROFILE%\Desktop\%username%-SendTo-HR.txt
wmic MEMORYCHIP >> %USERPROFILE%\Desktop\%username%-SendTo-HR1.txt
type %USERPROFILE%\Desktop\%username%-SendTo-HR1.txt > %USERPROFILE%\Desktop\%username%-SendTo-HR3.txt 
type %USERPROFILE%\Desktop\%username%-SendTo-HR.txt >> %USERPROFILE%\Desktop\%username%-SendTo-HR3.txt 
del %USERPROFILE%\Desktop\%username%-SendTo-HR.txt
del %USERPROFILE%\Desktop\%username%-SendTo-HR1.txt
