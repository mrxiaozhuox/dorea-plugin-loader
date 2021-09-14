package.path = ROOT_PATH .. "/library/?.lua;" .. package.path

local manager = require("manager")

-- include plugin here

manager.load("example", { ["token"] = "DOREA@TEST" })

-- end to include

manager.require(ROOT_PATH)

function CallEvent(event)
    if event == "onload" then
        return manager.call_onload()
    elseif event == "unload" then
        return manager.call_unload()
    elseif event == "interval" then
        return manager.call_interval()
    end
end