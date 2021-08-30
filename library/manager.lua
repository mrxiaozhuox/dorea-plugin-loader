Manager = {}

Manager.plugins = {}

function Manager.load(name, option)
    Manager.plugins[name] = option
end

function Manager.require(addr)

    local tables = {}

    for key, val in pairs(Manager.plugins) do
        local temp = dofile("../plugin/" .. key .. "/init.lua")

        temp.db.connect_info = { ["addr"] = addr, ["token"] = val["token"] }

        tables[key] = temp
    end
end

return Manager