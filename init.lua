package.path = "./library/?.lua;" .. package.path
package.cpath = "./interface/?.so;" .. package.cpath

local manager = require("manager")

-- include plugin here

manager.load("example", { ["token"] = "DOREA@TEST" })

-- end to include

-- local service_addr = "[DOREA_SERVICE_ADDR]"
local service_addr = "127.0.0.01:3451"


manager.require(service_addr)

function CallEvent(event)
    if event == "onload" then
        return manager.call_onload()
    elseif event == "unload" then
        return manager.call_unload()
    elseif event == "interval" then
        return manager.call_interval()
    end
end

print(v)