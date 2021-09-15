package.path = ROOT_PATH .. "/library/?.lua;" .. package.path

local manager = require("manager")

-- include plugin here

manager.load("example", { })

-- end to include

manager.require(ROOT_PATH)