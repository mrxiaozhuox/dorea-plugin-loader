# Dorea Plugin Loader

> 拓展你的 DoreaDB

这个软件包可以帮助你开发插件拓展你的 `DoreaDB`

## 安装

### 预备工作

如果你想让这个包能在你的系统上正常运行，那么你需要安装 `Lua5.4` 的解析器。

- [Lua 语言](https://www.lua.org/) - **必选**
- [LuaRocks 管理器](https://luarocks.org/) - **可选**

#### 可选环境

如果你想在插件中添加一些 `Lua` 的支持包，那么你就需要安装 `LuaRocks` 系统。

### 克隆仓库包

如果你的机器上已经安装了 `DoreaDB` 系统，那么你就可以开始安装 `插件系统` 了。

1. 通过 `DoreaDB` 日志获取运行目录:
```
configure loaded from: "/Users/xxx/Library/Application Support/Dorea"
```

2. 克隆仓库到运行目录下（新的子目录必须名为 `plugin`）

```
git clone https://github.com/doreadb/dorea-plugin-loader.git plugin
```

3. 编辑 `plugin.toml` 并打开插件系统开关。