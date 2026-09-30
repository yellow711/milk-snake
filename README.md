# 奶蛇（网页版）

浏览器里直接玩的贪吃蛇小游戏，用 Godot 4 做的。蛇头、食物都是自己抠的图。

## 玩

https://YOURNAME.github.io/REPO/

（把上面这行换成你自己的地址）

- 键盘：方向键 / WASD 移动，P 或 Esc 暂停，R 重开
- 手机：自动出现屏幕方向键，竖屏在游戏区下方、横屏在右下角

## 说明

这个仓库只放**导出的网页版**（Godot 编辑器工程不在里面）。
页面靠 GitHub Pages 托管，`.nojekyll` 用来跳过 Jekyll 处理。

引擎是 Godot 4.7.2 的 web 导出（**非多线程**版本），
所以不需要 COOP/COEP 响应头，GitHub Pages 这种纯静态托管就能跑。
