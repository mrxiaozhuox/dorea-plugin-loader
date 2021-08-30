local config = dofile("./config/init.lua")

local service_addr = "$[WEB_SERVICE_ADDR]"

config.init(service_addr)