Manager = {}

Manager.plugins = {}
Manager.tables = {}
Manager.timer = {}

function Manager.load(name, option)
    Manager.plugins[name] = option
end

function Manager.require(root_path)

    local tables = {}

    for key, val in pairs(Manager.plugins) do

        local temp = dofile(root_path .. "/plugins/" .. key .. "/init.lua")

        tables[key] = temp

        Manager.timer[key] = 0

        LOGGER_IN.info("extend plugin loaded: 「 " .. temp.setting.name .. " : " .. temp.setting.version .. " 」")

    end

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

function Manager.call_command(title, argument)
    for key, val in pairs(Manager.tables) do

        local temp = val.setting.custom_command

        if temp[title] ~= nil then

            local target = temp[title]

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
                    local state, result = pcall(temp[title]["function"], {})

                    if not state then
                        -- 调用失败，返回空值
                        return nil
                    end

                end

            end

        end

    end
end

return Manager