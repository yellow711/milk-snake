# 用 GitHub 生成一个永久链接

好消息：**网页版我已经帮你打包好、本地 git 仓库也建好提交好了**，
你只需要「建仓库 → 推上去 → 开 Pages」三步，大约 2 分钟。

链接会长这样：

```
https://你的用户名.github.io/milk-snake/
```

发给谁都能点开就玩，**不用你开着电脑**，也不用花钱。

---

## 为什么不能我直接帮你传

GitHub 上传需要**你账号的登录凭据**，这台机器上：

- `git` 装了 ✓
- `gh`（GitHub CLI）**没装** ✗，也没有任何已登录的 GitHub 凭据

凭据只在你手里，所以最后这一步必须你来点。我已经把能自动化的部分全做完了。

---

## 方式一：双击脚本（推荐，最省事）

双击 **`发布到GitHub.bat`**，它会：

1. 自动打开 GitHub 建仓库的页面（仓库名、可见性都帮你填好）
2. 让你输入 GitHub 用户名
3. 自动把本地仓库推上去（第一次会弹登录窗口，授权一下）
4. 推成功后自动打开 Pages 设置页，并告诉你最终链接

你只需要在浏览器里点几下确认。

---

## 方式二：手动敲命令

先打开 https://github.com/new 建一个**空**仓库：

- Repository name 填 `milk-snake`
- 选 **Public**
- **Add README / .gitignore / license 一个都别勾**（勾了会冲突，等下推不上去）
- 点 Create repository

然后在 PowerShell 里：

```powershell
cd "D:\huang\Documents\奶蛇-网页版"
git remote add origin https://github.com/你的用户名/milk-snake.git
git push -u origin main
```

再开 Pages：仓库页面 → **Settings** → 左侧 **Pages** →
Source 选 **Deploy from a branch** → Branch 选 **main**、目录选 **/ (root)** → **Save**。

等 1~2 分钟，访问 `https://你的用户名.github.io/milk-snake/`。

---

## 仓库里已经准备好了什么

本地仓库（就在 `奶蛇-网页版` 文件夹里）已经 commit 好了：

| 文件 | 说明 |
| --- | --- |
| `index.html` `index.js` `index.wasm` `index.pck` | 游戏本体 |
| `index.icon.png` `index.png` `index.apple-touch-icon.png` | 图标/favicon |
| `index.audio.*.worklet.js` | Godot 运行时需要的文件 |
| `.nojekyll` | 跳过 Jekyll 处理（Pages 需要） |
| `.gitattributes` | **把 wasm/pck 标成二进制**，防止换行符转换弄坏文件 |
| `.gitignore` | 排除那个 10MB 的 zip，别重复提交 |

### 两个坑我已经替你避掉了

1. **wasm 不能被当文本转换**
   Git 在 Windows 上默认 `autocrlf=true`，会把文本文件的换行符改成 CRLF。
   如果 `.wasm` 被误判成文本，**37MB 的引擎文件会被改坏，游戏在浏览器里直接白屏**。
   我加了 `.gitattributes` 明确标成二进制，并且**比对过仓库里的 wasm 和工作区逐字节一致**。

2. **必须是「非多线程」的 web 导出**
   Godot 的多线程 web 版需要服务器发 `COOP/COEP` 响应头，
   而 **GitHub Pages 不能自定义响应头** —— 用了多线程版就会加载失败。
   我导出时特意关掉了线程支持，所以纯静态托管就能跑。

---

## 常见问题

**Q：Pages 打开是 404？**
A：刚开启要等 1~2 分钟构建。另外确认 Branch 选的是 `main`、目录是 `/ (root)`。
仓库名如果用中文，链接会变成一串百分号编码，建议就用 `milk-snake`。

**Q：以后更新游戏怎么办？**
A：重新导出 → 在 `奶蛇-网页版` 文件夹里执行
`git add -A` → `git commit -m "更新"` → `git push`，Pages 会自动重新发布。

**Q：仓库公开会不会有问题？**
A：里面只有导出的游戏文件，没有任何隐私内容（Godot 工程源码不在里面）。
不想公开的话，Pages 也可以配合私有仓库用（需要 GitHub 付费版）。

**Q：不想用 GitHub 呢？**
A：见 `怎么分享给别人玩.md` —— itch.io 也是免费且更方便（拖个 zip 就完事）。
