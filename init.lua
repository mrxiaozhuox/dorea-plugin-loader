if not ROOT_PATH then
    ROOT_PATH = "."
end

if not PLUGIN_LOADER then
    PLUGIN_LOADER = {}
end

if not LOGGER_IN then
    LOGGER_IN =  {}

    LOGGER_IN.info = function (message)
        print("[INFO] " .. message)
    end

    LOGGER_IN.trace = function (message)
        print("[TRACE] " .. message)
    end

    LOGGER_IN.debug = function (message)
        print("[DEBUG] " .. message)
    end

    LOGGER_IN.warn = function (message)
        print("[WARN] " .. message)
    end

    LOGGER_IN.error = function (message)
        print("[ERROR] " .. message)
    end

end

if not DB_MANAGER then
    DB_MANAGER = {}

    DB_MANAGER.select = function (db_name)
        LOGGER_IN.info("selet to `" .. db_name .. "`")
    end

    DB_MANAGER.set = function (key, value, expire)
        LOGGER_IN.info("set data: " .. key .. ": " .. value .. " [" .. expire .. "]")
    end

    DB_MANAGER.get = function (key)
        LOGGER_IN.info("get data: " .. key)
    end

    DB_MANAGER.delete = function (key)
        LOGGER_IN.info("delete data: " .. key)
    end

end

package.path = ROOT_PATH .. "/library/?.lua;" .. package.path

MANAGER = require("manager")

-- include plugin here

for key, val in pairs(PLUGIN_LOADER) do
    MANAGER.load(key, val)
end

-- end to include

MANAGER.require(ROOT_PATH)