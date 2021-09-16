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

return Manager