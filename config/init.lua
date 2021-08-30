package.path = package.path .. ";../library/?.lua"

local manager = require("manager")

local plugin = {}

-- include plugin here

manager.load("test", { ["token"] = "DOREA@TEST" })

-- end to include

--- load all plugin (require)
function plugin.init(addr)
    manager.require(addr)
end