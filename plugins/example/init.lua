local module = require("interface")

-- 插件基本信息定义
module.setting.name = "Example"
module.setting.version = "V0.01"
module.setting.author = "YuKun Liu<mrxzx.info@gmail.com>"

-- 插件兼容信息（table）
-- 一个插件必须为某个版本兼容则使用：{"=NEEDVERSION"}
-- 插件支持某个范围内的版本则使用：{">STARTSUPPORT", "<ENDSUPPORT"}
-- 这个属性开发的主要原因为：Dorea 在前期开发版本中，插件接口将频繁的进行变更。所以说需要限制好兼容版本
-- 不知道能兼容到什么版本的时候，最好直接锁到当前开发所使用的版本
module.setting.compatible_version = {"=0.3.0"}

-- Lua依赖列表，会提醒用户安装相关依赖
-- 请使用 LuaRocks：https://luarocks.org
module.setting.dependency_lib = {
    ["dump"] = { ["optional"] = true, ["version"] = "0.1.1" } -- dump: 用于代码调试（可选依赖）
}

local logger = module.log -- 日志系统

-- 加载时事件
module.func.plugin_onload = function ()
    -- 插件加载时程序
end

-- 卸载时事件
module.func.plugin_unload = function ()
    -- 插件卸载时程序
end

-- 定时任务事件
module.setting.interval = 60 * 60 * 12
module.func.plugin_interval = function (counter)
    --- 完成定时任务功能
end

-- 自定义命令集
module.setting.custom_command = {
    ["target"] = {
        ["argument"] = "=1",
        ["function"] = function(i) return module.func.command_target(i) end
    },
}

-- 这个函数也可以不定义在这里，直接写在 `setting.custom_command` 中
-- 但为了代码规范，建议还是这么单独编写
-- 返回值会作为客户端回应
module.func.command_target = function (info)
    
    local dump = require("dump")
    if dump == nil then
        dump = module.tool.dump
    end

    return 'target: example ' .. dump(info)
end

-- 将最终模块返回（交给插件调度器调度）
return module
