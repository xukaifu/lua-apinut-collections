
local function map()
    local map = {}
    local size = 0
    setmetatable(map, { __index = {
        put = function(map, key, val)
            if map[key] == nil then
                size = size+1
            end
            map[key] = val
        end,

        get = function(map, key)
            return map[key]
        end,

        size = function(map)
            return size
        end,

        hasKey = function(map, key)
            return map[key] ~= nil
        end,

        hasVal = function(map, val)
            for k,v in pairs(map) do
                if v == val then return true end
            end
            return false
        end,

        remove = function(map, key)
            local v = map[key]
            if v then
                map[key] = nil
                size = size-1
            end
            return v
        end
    }})
    return map
end

local function queue()
    local q = {}
    setmetatable(q, {__index = {
        push = function (set, key, itm)
            if key then
                local qKey = q[key]
                if qKey == nil then
                    q[key] = {itm}
                else
                    qKey[#qKey + 1] = itm
                end
            end
        end,

        pop = function (set, key)
            local t = q[key]
            if t ~= nil then
                local ret = table.remove (t, 1)
                if t[1] == nil then
                    q[key] = nil
                end
                return ret
            end
        end,

        remove = function(set, key, itm)
            local qKey = q[key]
            if qKey then
                local idx = nil
                for k,v in pairs(qKey) do
                    if v == itm then
                        idx = k
                        break
                    end
                end
                if idx then
                    qKey[idx] = nil
                end
            end
        end,

        size = function(set, key)
            local t = q[key]
            if t then return table.getn(t) end
            return 0
        end

    }})
    return q
end

local function set()

    local set = {}
    local reverse = {}

    setmetatable(set, { __index = {

        add = function(set, value)
            if not reverse[value] then
                set[#set + 1] = value
                reverse[value] = #set
                return true
            end
            return false
        end,

        remove = function(set, value)
            local index = reverse[value]
            if index then
                reverse[value] = nil
                local top = set[#set]
                set[#set] = nil
                if top ~= value then
                    reverse[top] = index
                    set[index] = top
                end
                return true 
            end
            return false
        end,

        has = function(set, val)
            local idx = reverse[val]
            if idx then return true end
            return false
        end,

        size = function(set)
            return table.getn(set)
        end
    }})
    return set
end

module("apinut.collections", package.seeall)
__VERSION = "0.1"
local _mt = { __index = apinut.collections}

newmap = map
newqueue = queue
newset = set 
