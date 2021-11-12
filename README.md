# Dorea Plugin Loader

> Extend your DoreaDB system.

This package can help you to create some plugin for your `DoreaDB`

## Install

### Preparatory Work

If you want to use this package, then you should install `lua5.4` parser on your system:

- [Lua Language](https://www.lua.org/) - **required**
- [LuaRocks Manager](https://luarocks.org/) - **optional**

#### Optional Requiremnt

If you want to load other package with lua, then you should install `LuaRocks` tool.

### Clone Package

If you already have to installed the `DoreaDB`, then you need to open the folder for `DoreaDB`:

1. you can get the *path* on the log for `DoreaDB`
```
configure loaded from: "/Users/xxx/Library/Application Support/Dorea"
```

2. and you should `clone` this package to this folder: (`sub-folder` name should be `plugin`)

```
git clone https://github.com/doreadb/dorea-plugin-loader.git plugin
```

3. then edit `plugin.toml` and open the switch.