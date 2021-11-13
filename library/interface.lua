local interface = {}

interface["func"] = {}
interface["setting"] = {}

interface["db"] = DB_MANAGER
interface["log"] = LOGGER_IN

interface["tool"] = {
    
    -- 检查某个函数是否存在（或被实现）
    method_exist = function (name)
        local state, func = pcall(require, name)
        if state then
            return func
        else
            return nil
        end
    end,

    -- 打印 table 数据
    dump = function (object)
        if type(object) == 'table' then
            local s = '{ '
            for k,v in pairs(object) do
               if type(k) ~= 'number' then k = '"'..k..'"' end
               s = s .. '['..k..'] = ' .. interface.tool.dump(v) .. ','
            end
            return s .. '} '
         else
            return tostring(object)
         end
    end

}

return interface