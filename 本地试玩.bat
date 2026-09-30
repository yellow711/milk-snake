@echo off
chcp 936 >nul
rem 双击这个文件：在本机启动一个小服务器，然后自动打开浏览器试玩
setlocal
cd /d "%~dp0"
set "PORT=8060"

where python >nul 2>nul
if errorlevel 1 (
	echo.
	echo   [错误] 没找到 python，起不了本地服务器。
	echo   替代办法：把「奶蛇-网页版.zip」上传到 itch.io，一样能在线玩。
	echo.
	pause
	exit /b 1
)

echo.
echo   ============================================
echo     本机试玩：  http://127.0.0.1:%PORT%/
echo.
echo     同一个 WiFi 下，别人也能打开下面这些地址：
echo   ============================================
ipconfig | findstr /i "IPv4"
echo.
echo   （关掉这个黑窗口 = 关掉服务器）
echo.
echo   正在打开浏览器……
echo.

start "" "http://127.0.0.1:%PORT%/"
python -m http.server %PORT%
