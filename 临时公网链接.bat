@echo off
chcp 936 >nul
rem 双击这个文件：起本地服务器 + 开一条 SSH 隧道，换一个「公网链接」，
rem 把那个链接发给任何人，对方点开就能玩（关掉窗口链接失效）。
setlocal
cd /d "%~dp0"
set "PORT=8060"

where python >nul 2>nul
if errorlevel 1 (
	echo   [错误] 没找到 python。请用「本地试玩.bat」或上传 itch.io。
	pause
	exit /b 1
)
where ssh >nul 2>nul
if errorlevel 1 (
	echo   [错误] 没找到 ssh（Windows 自带 OpenSSH 客户端，可在「可选功能」里安装）。
	pause
	exit /b 1
)

start "奶蛇-本地服务器" /min cmd /c "python -m http.server %PORT%"
timeout /t 2 >nul

echo.
echo   ==========================================================
echo     下面会出现一个 https://xxxx.lhr.life 的地址，
echo     把它发给任何人，对方点开就能玩。
echo     这是临时链接：关掉这个窗口就失效了。
echo   ==========================================================
echo.

ssh -o StrictHostKeyChecking=accept-new -R 80:localhost:%PORT% nokey@localhost.run

echo.
echo   隧道已断开，正在关闭本地服务器……
taskkill /f /fi "WINDOWTITLE eq 奶蛇-本地服务器*" >nul 2>nul
pause
