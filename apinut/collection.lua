module("apinut.collection", package.seeall)

__VERSION = "0.1"

local _mt = { __index = apinut.collection}

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
            local qKey = q[key]
            if qKey == nil then
                q[key] = {itm}
            else
                qKey[#qKey + 1] = itm
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
            if qKey == nil then
                return
            end

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
        end,

        size = function(set, key)
            local t = q[key]
            local cnt = 0
            if t then
                for k,v in pairs(t) do
                    cnt = cnt + 1
                end
            end
            return cnt
        end

    }})
    return q
end

local function set()

    local set = {}
    local reverse = {}

    setmetatable(set, { __index = {

        insert = function(set, value)
            if not reverse[value] then
                set[#set + 1] = value
                reverse[value] = #set
            end
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
            end
        end,

        size = function(set, key)
            local cnt = 0
            if set then
                for k,v in pairs(set) do
                    cnt = cnt + 1
                end
            end
            return cnt
        end
    }})
    return set
end

newmap = map
newqueue = queue
newset = set 
