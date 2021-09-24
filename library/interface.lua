local interface = {}

interface["func"] = {}
interface["setting"] = {}

interface["db"] = DB_MANAGER
interface["log"] = LOGGER_IN

interface["tool"] = {
    method_exist = function (name)
        local state, func = pcall(require, name)
        if state then
            return func
        else
            return nil
        end
    end
}

return interface