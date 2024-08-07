@echo OFF
SETLOCAL enabledelayedexpansion
CHCP 65001

SET "WARTALE_HOME=%ProgramFiles(x86)%\Steam\steamapps\common\Wartales" || goto :error
SET "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Wartales directory not found. Please select the directory where Wartales is installed manually',0,0).self.path"" || goto :error

IF NOT EXIST "%WARTALE_HOME%" (
  echo Wartales directory not found. Please select the directory where Wartales is installed manually at the prompt
  FOR /f "usebackq delims=" %%I IN (`powershell %psCommand%`) DO SET "WARTALE_HOME=%%I" || goto :error
) || goto :error

SET "LAST_PATCHED_TRACKER=%WARTALE_HOME%\__LAST_KR_PATCHED_AT" || goto :error

echo Try to rollback "assets.pak" from "assets.pak.back"...
IF EXIST "%WARTALE_HOME%\assets.pak.back" MOVE /Y "%WARTALE_HOME%\assets.pak.back" "%WARTALE_HOME%\assets.pak" || goto :error

echo Try to rollback "res.pak" from "assets.pak.back"...
IF EXIST "%WARTALE_HOME%\res.pak.back" MOVE /Y "%WARTALE_HOME%\res.pak.back" "%WARTALE_HOME%\res.pak" || goto :error

echo Remove patch tracker file..
IF EXIST "%LAST_PATCHED_TRACKER%" DEL "%LAST_PATCHED_TRACKER%" || goto :error


echo(
echo Reveret done!
echo(

pause
goto :EOF


:error
echo(
echo Failed with error #%errorlevel%.
echo(

pause
