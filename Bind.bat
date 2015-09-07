@echo off
setlocal EnableDelayedExpansion

set BASEDIR=%~dp0
if "%BASEDIR:~-1%" == "\" set BASEDIR=%BASEDIR:~0,-1%

set CURDIR=%CD%
if "%CURDIR:~-1%" == "\" set CURDIR=%CURDIR:~0,-1%

if "%BASEDIR%" == "%CURDIR%" ( 
	echo Target directory is the same
	goto EXIT 
)

rem Resolving base directory

if exist "%CURDIR%\Assets" goto CURDIR_RESOLVED

set CHECKDIR=%CURDIR%
set ROOTDIR=

:ROOT_LOOP

for %%i in ("%CHECKDIR%") do (
	if "%%~nxi" == "" goto ROOT_LOOP_END	
	if "%%~nxi" == "Assets" (
		set ROOTDIR=%%~dpi
		if "!ROOTDIR:~-1!" == "\" set ROOTDIR=!ROOTDIR:~0,-1!
		goto ROOT_LOOP_END
	)
)

for %%i in ("%CHECKDIR%\..") do set CHECKDIR=%%~fi
goto ROOT_LOOP

:ROOT_LOOP_END

if "%ROOTDIR%" == "" (
	echo Unity project is not found for "%CURDIR%"
) else (
	echo Unity project is found in "%ROOTDIR%"
	set CURDIR=%ROOTDIR%
)

:CURDIR_RESOLVED

if not exist "%CURDIR%\Assets\Standard Assets\LWF" (
	mkdir "%CURDIR%\Assets\Standard Assets\LWF"
)
if not exist "%CURDIR%\Assets\Standard Assets\LWF\core" ( 
	mklink /j "%CURDIR%\Assets\Standard Assets\LWF\core" "%BASEDIR%\csharp\core"
)
if not exist "%CURDIR%\Assets\Standard Assets\LWF\extension" ( 
	mklink /j "%CURDIR%\Assets\Standard Assets\LWF\extension" "%BASEDIR%\csharp\unity\extension"
)
if not exist "%CURDIR%\Assets\Standard Assets\LWF\renderer" ( 
	mklink /j "%CURDIR%\Assets\Standard Assets\LWF\renderer" "%BASEDIR%\csharp\unity\renderer"
)
if not exist "%CURDIR%\Assets\Standard Assets\LWF\wrapper" ( 
	mklink /j "%CURDIR%\Assets\Standard Assets\LWF\wrapper" "%BASEDIR%\csharp\unity\renderer"
)


if not exist "%CURDIR%\Assets\Resources\LWF" (
	mkdir "%CURDIR%\Assets\Resources\LWF"
)
if not exist "%CURDIR%\Assets\Resources\LWF\shaders" ( 
	mklink /j "%CURDIR%\Assets\Resources\LWF\shaders" "%BASEDIR%\csharp\unity\shaders"
)


if not exist "%CURDIR%\Assets\Standard Assets\Editor" (
	mkdir "%CURDIR%\Assets\Standard Assets\Editor"
)
if not exist "%CURDIR%\Assets\Standard Assets\Editor\LWF" ( 
	mklink /j "%CURDIR%\Assets\Standard Assets\Editor\LWF" "%BASEDIR%\csharp\unity\editor"
)

:EXIT