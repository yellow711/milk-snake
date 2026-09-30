@echo off
chcp 936 >nul
rem 双击这个文件：把最新的网页版更新到你的 GitHub（不用重新建仓库）
setlocal
cd /d "%~dp0"

echo.
echo   ==========================================================
echo     把最新的网页版更新到 GitHub
echo   ==========================================================
echo.

git remote -v | findstr /i "origin" >nul
if errorlevel 1 (
	echo   [提示] 这台电脑上还没配置过 GitHub 地址。
	echo          请先双击「发布到GitHub.bat」走一遍完整流程。
	echo.
	pause
	exit /b 1
)

echo   正在检查有没有新东西……
git add -A
git diff --cached --quiet
if not errorlevel 1 (
	echo.
	echo   没有新改动，网站已经是最新的了。
	echo.
	pause
	exit /b 0
)

git -c user.name="yellow711" -c user.email="m19194903624@163.com" commit -q -m "更新网页版"
echo   正在上传……
git push

if errorlevel 1 (
	echo.
	echo   ----------------------------------------------------------
	echo   上传失败。可能是登录过期了，重试一次通常就好。
	echo   还是不行就把这个窗口拍照发我。
	echo   ----------------------------------------------------------
	pause
	exit /b 1
)

echo.
echo   ==========================================================
echo     更新完成！
echo     等 1~2 分钟，然后用手机重新打开你的链接
echo     （手机浏览器记得刷新，或者把旧页面关掉重开）
echo   ==========================================================
echo.
pause
