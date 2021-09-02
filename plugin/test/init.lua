-- local module = require("dorea_interface")
local module = { ["func"] = {}, ["setting"] = {} }

-- 加载时事件
module.func.plugin_onload = function (status)
    return "Helllo Dorea"
end

-- 卸载时事件
module.func.plugin_unload = function (status)
    return "Helllo Dorea"
end

-- 定时任务事件
module.setting.interval = 60 * 60 * 12
module.func.plugin_interval = function ()
    -- module.db.reapply()
end

-- 自定义命令集
module.setting.custom_command = {
    ["target"] = { }
}

module.func.command_target = function (info)
    return "Hello Target"
end

-- 数据库直接操作
-- 数据库操作的范围取决于用户对插件token授权等级
-- 一般来说：都只允许插件操作 `_plugin_{插件名}` 的专用库 或 不允许操作任何库
-- 这里的 demo 请删除（它无法正常运行，db下的数据只能在事件函数中调用，因为此时它还没有被初始化。）
-- if module.db.try("_plugin_test") then
--     local db = module.db.load("_plugin_test")
--     print(db.execute("info keys"))
-- end

-- 将最终模块返回（交给插件调度器调度）
return module