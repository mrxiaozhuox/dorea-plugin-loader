Manager = {}

Manager.plugins = {}
Manager.tables = {}
Manager.timer = {}

function Manager.load(name, option)
    Manager.plugins[name] = option
end

function Manager.require(root_path)

    local tables = {}

    local db_sys_plugins = "["

    for key, val in pairs(Manager.plugins) do

        local temp = dofile(root_path .. "/plugins/" .. key .. "/init.lua")

        tables[key] = temp

        Manager.timer[key] = 0


        db_sys_plugins = db_sys_plugins .. "\"" .. key .. "\"" .. ","

        LOGGER_IN.info("extend plugin loaded: 「 " .. temp.setting.name .. " : " .. temp.setting.version .. " 」")

    end


    -- 插入系统服务数据：插件当前信息
    DB_MANAGER:select("system")
    DB_MANAGER:setex("plugins", string.sub(db_sys_plugins, 0, string.len(db_sys_plugins) - 1) .. "]", 0)


    Manager.tables = tables

end

function Manager.call_onload()

    local result = {}

    for key, val in pairs(Manager.tables) do
        result[key] = val.func.plugin_onload()
    end

    return result
end

function Manager.call_unload()

    local result = {}

    for key, val in pairs(Manager.tables) do
        result[key] = val.func.plugin_unload()
    end

    return result
end

function Manager.call_interval()

    local result = {}

    for key, val in pairs(Manager.tables) do

        if Manager.timer[key] >= val.setting.interval then
            Manager.timer[key] = 1
            result[key] = val.func.plugin_interval()
        else
            Manager.timer[key] = Manager.timer[key] + 1
        end


    end

    return result
end

function Manager.call_command(title, arg_info)

    for key, val in pairs(Manager.tables) do

        local temp = val.setting.custom_command

        if temp[title] ~= nil then

            local target = temp[title]

            local argument
            if arg_info["argument"] == nil then
                argument = ">-1"
            else
                argument = arg_info["argument"]
            end

            local status = false
            local num_now = #argument

            if target["argument"] ~= nil then

                local tar_arg = target["argument"];
                local prefix = string.sub(tar_arg, 1, 1)

                if prefix == ">" or prefix == "<" or prefix == "=" then
                    tar_arg = string.sub(tar_arg,2, -1)
                else
                    prefix = "="
                end
                
                local tar_num = tonumber(tar_arg)

                if tar_num == nil then
                    error("plugin [custom_command] setting error")
                end

                if prefix == "=" then
                    if tar_num == num_now then
                        status = true
                    end
                elseif prefix == ">" then
                    if tar_num < num_now then
                        status = true
                    end
                elseif prefix == "<" then
                    if tar_num > num_now then
                        status = true
                    end
                end

                if status then
                    local state, result = pcall(temp[title]["function"], arg_info)

                    if not state then
                        -- 调用失败，返回空值
                        -- 这里这么写不是故意拖长
                        -- 后续可能会做拓展，所以说先在这里判了
                        return nil
                    end

                    return result
                end
            end
        end
    end
    return nil
end

return Manager
