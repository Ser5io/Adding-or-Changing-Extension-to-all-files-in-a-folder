@echo OFF
SETLOCAL

:DropFolder1
ECHO Drag and drop the Folder in which you would like to change or add an extension to its files
SET /p Folder1= 
IF '%Folder1%' == '' ( 
	ECHO You entered an empty message, so please
	goto DropFolder1
)
SET Folder1=%Folder1:~1,-1%

:EnterExtension
ECHO Enter the extension, ie. "jpg" or "png" or anything else
SET /p Extension= 
IF '%Extension%' == '' ( 
	ECHO You entered an empty message, so please
	goto EnterExtension
)

SET /A nbrFolder1=0
setlocal ENABLEDELAYEDEXPANSION
FOR %%n IN ("%Folder1%\*") DO (
	SET /A nbrFolder1=nbrFolder1+1
)

SET /A estimatedTime=!nbrFolder1!*25/10000
SET /A estimatedTimeLeft=%estimatedTime%*7/10
SET /A estimatedTimeRight=%estimatedTime%*13/10
SET /A estimatedTimeLeftMinutes=%estimatedTimeLeft%/60
SET /A estimatedTimeRightMinutes=%estimatedTimeRight%/60
ECHO Estimated Duration between:
ECHO %estimatedTimeLeft% - %estimatedTimeRight% secondes
ECHO %estimatedTimeLeftMinutes% - %estimatedTimeRightMinutes% minutes

pause Start PNG Renaming ?

TIME /T > "%~dp0time.txt"
SET /p startTime= <time.txt
DEL "%~dp0time.txt"

ECHO Start Time: %startTime%
ECHO Renaming files to PNG...
FOR %%f IN ("%Folder1%\*") DO (
	REN "%%f" "%%~nf.%Extension%"
	ECHO Renamed: %%~nf to %%~nf.%Extension%
)
ECHO Done :)
ECHO ----------

TIME /T > "%~dp0time.txt"
SET /p endTime= <time.txt
DEL "%~dp0time.txt"

ECHO Duration: From %startTime% to %endTime%
pause