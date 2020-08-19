echo off
rem clone with DOS cmd (%%): git clone "https://swissre.visualstudio.com/EAPOOL-EAC-EAPOOL%%20VSTS/_git/srzlma" GITvsts/EAPOOL-EAC-EAPOOL/srzlma
rem Es muss auf einem gemappten drive gearbeitet werden, da git nicht mit network drives arbeiten kann
rem https://rogerdudler.github.io/git-guide/index.de.html
rem git config --global http.proxy http://gate.zrh.swissre.com:8080
rem git config --global http.sslVerify false
rem git add test.txt
rem add = stage, commit <> stash, merken!
rem test4

cd %CD%
for /F "tokens=1,2,3,4 delims=. " %%a in ('date /t') do set d=%%c%%b%%a
for /F "tokens=1,2 delims=: " %%r in ('time /t') do set t=%%r%%s

git config user.name "ml"
git config user.email "ml@example.com"

echo ------------------------------------------------------- pull
git pull
echo.
echo status
echo ------
git status

set /p push=including push?

if "%push%" == "y" (call :pushblock)
echo -------------------------------------------------------- done
pause
exit 

:pushblock
	set /p gitrun=including GitRun.bat?
	echo ------------------------------------------------------- add
	if "%gitrun%" == "y" (git add *)
	if NOT "%gitrun%" == "y" (git add * -- :!%CD%\GitRun.bat)
	echo.
	echo status
	echo ------
	git status
	echo ------------------------------------------------------- commit
	git commit -m %computername%_%d%_%t%
	echo.
	echo status
	echo ------
	git status
	echo ------------------------------------------------------- push
	git push origin master
	echo.
	echo status
	echo ------
	git status



