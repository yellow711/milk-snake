@echo off
chcp 936 >nul
rem 双击这个文件：把已经准备好的网页版仓库推送到你的 GitHub，然后开 Pages
setlocal
cd /d "%~dp0"
set "REPO=milk-snake"

echo.
echo   ==========================================================
echo     第一步：先在浏览器里建一个空仓库（只需一次）
echo   ==========================================================
echo.
echo     1) 打开  https://github.com/new
echo     2) Repository name 填：  %REPO%
echo     3) 选  Public
echo     4) 下面的 Add README / .gitignore / license 一个都别勾
echo     5) 点  Create repository
echo.
start "" "https://github.com/new?name=%REPO%&visibility=public"
echo     建好后回到这里按任意键继续……
pause >nul

set /p GHUSER=请输入你的 GitHub 用户名（大小写不敏感）: 
if "%GHUSER%"=="" (
	echo.
	echo   没输入用户名，退出。
	pause
	exit /b 1
)

echo.
echo   正在推送到 https://github.com/%GHUSER%/%REPO%.git
echo   （第一次会弹出 GitHub 登录窗口，按要求登录授权即可）
echo.

git remote remove origin >nul 2>nul
git remote add origin https://github.com/%GHUSER%/%REPO%.git
git push -u origin main

if errorlevel 1 (
	echo.
	echo   第一次没传上去。最常见的原因：建仓库时勾了 Add a README file，
	echo   远程仓库里已经有一条记录，和本地对不上。
	echo.
	echo   正在改用「覆盖上传」重试（你本地这份是完整的，不会丢东西）……
	echo.
	git push -u origin main --force
)

if errorlevel 1 (
	echo.
	echo   ----------------------------------------------------------
	echo   推送失败。按顺序检查：
	echo     1. 仓库名是不是 %REPO%（必须一模一样）
	echo     2. 用户名是否输错
	echo     3. 登录窗口有没有被关掉
	echo   改好后重新双击本文件即可。
	echo   ----------------------------------------------------------
	pause
	exit /b 1
)

echo.
echo   ==========================================================
echo     第二步：开启 GitHub Pages（只需一次）
echo   ==========================================================
echo.
echo     1) 打开  https://github.com/%GHUSER%/%REPO%/settings/pages
echo     2) Source 选  Deploy from a branch
echo     3) Branch 选  main ，目录选  / (root) ，点 Save
echo     4) 等 1~2 分钟，你的链接就是：
echo.
echo        https://%GHUSER%.github.io/%REPO%/
echo.
echo   （这个链接发给谁都能点开就玩，不用你开着电脑）
echo.
start "" "https://github.com/%GHUSER%/%REPO%/settings/pages"
pause
