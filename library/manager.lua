Manager = {}

Manager.plugins = {}

function Manager.load(name, option)
    Manager.plugins[name] = option
end

function Manager.require()
    for key, val in pairs(Manager.plugins) do
        require(key)
    end
end

return Manager