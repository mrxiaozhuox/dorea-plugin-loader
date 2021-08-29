Manager = {}

Manager.plugins = {}

function Manager.load(name, option)
    Manager.plugins[name] = option
end

function Manager.require()
    print("HI!")
    for key, val in pairs(Manager.plugins) do
        print(key, val)
    end
end

return Manager