package.path = "../src/?.lua;"..package.path

local collections = require("apinut.collections")

local tk = {}
local tv = {}
local tn = {}
local q1 = {}
local q2 = {}

-- map --
local map = collections.newmap()
map:put("k1", "v1")
map:put("k2", "v2")
map:put("k3", "v3")
assert(map:get("k1") == "v1")
assert(map:size() == 3)

map:put(tk, tv)
assert(map:size() == 4)
assert(map:get(tk) == tv)

assert(map:hasKey(tk))
assert(map:hasVal(tv))
assert(not map:hasKey(tn))
assert(not map:hasVal(tn))

assert(map:remove("k1")=="v1")
assert(not map:hasKey("k1"))
assert(map:size() == 3)

assert(not map:remove(tn))
assert(map:size() == 3)

assert(map:remove(tk)==tv)
assert(map:size() == 2)

---- set ----
local set = collections.newset()
set:add("v1")
set:add("v2")
set:add("v3")
set:add("v3")
assert(set:size()==3)
assert(set:has("v3"))
assert(not set:has(tv))

set:add(tv)
assert(set:size()==4)
assert(set:has(tv))

set:remove("v3")
assert(set:size()==3)
assert(not set:has("v3"))

set:remove(tn)
assert(set:size()==3)

set:remove(tv)
assert(set:size()==2)
assert(not set:has(tv))

---- queue ----
local queue = collections.newqueue()
queue:push(q1, "v1")
queue:push(q1, q1)
queue:push(q1, "v1")

queue:push(q2, "v1")
queue:push(q2, q1)
queue:push(q2, "v1")

queue:push("q3", "v1")
queue:push("q3", q1)
queue:push("q3", "v1")

assert(queue:size(q1)==3)
assert(queue:pop(q1) == "v1")
assert(queue:pop(q1) == q1)
assert(queue:size(q1) == 1)

queue:push(q1, nil)
assert(queue:size(q1) == 1)


