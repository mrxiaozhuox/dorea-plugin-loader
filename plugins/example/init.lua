local module = require("interface")

-- Dorea-Interface 包使用 Rust 语言提供 so 调用库

-- 插件基本信息定义
module.setting.name = "Example"
module.setting.version = "V0.01"
module.setting.author = "mrxzx<mrxzx.info@gmail.com>"

-- 插件兼容信息（table）
-- 一个插件必须为某个版本兼容则使用：{"=NEEDVERSION"}
-- 插件支持某个范围内的版本则使用：{">STARTSUPPORT", "<ENDSUPPORT"}
-- 这个属性开发的主要原因为：Dorea 在前期开发版本中，插件接口将频繁的进行变更。所以说需要限制好兼容版本
-- 不知道能兼容到什么版本的时候，最好直接锁到当前开发所使用的版本
module.setting.compatible_version = {"=0.3.0-alpha"}

local logger = module.log

-- 加载时事件
module.func.plugin_onload = function ()
    
end

-- 卸载时事件
module.func.plugin_unload = function ()
    return "Helllo Dorea"
end

-- 定时任务事件
module.setting.interval = 60 * 60 * 12
module.func.plugin_interval = function (counter)
    -- Token 申请的间隔时长建议在 12小时 以内。
    module.db:apply_token()
end

-- 自定义命令集
module.setting.custom_command = {
    ["target"] = { }
}

module.func.command_target = function (info)
    return "Hello Target"
end

-- 将最终模块返回（交给插件调度器调度）
return module