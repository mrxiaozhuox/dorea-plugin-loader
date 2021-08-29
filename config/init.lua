package.path = package.path .. ";../library/?.lua"

local manager = require("manager")

-- include plugin here

manager.load("test", { ["token"] = "DOREA@TEST" })

-- end to include

--- load all plugin (require)
manager.require()