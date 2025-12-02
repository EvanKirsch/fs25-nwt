-- NWT_history
--
-- Data object for value at a period save point entry information
--

NWT_history = {}

local NWT_history_mt = Class(NWT_history, Object)

InitObjectClass(NWT_history, "NWT_history")

function NWT_history.new(isServer, isClient, customMt)
    local self = Object.new(isServer, isClient, customMt or NWT_history_mt)

    return self
end

function NWT_history:init(farmId, dayId, category, amount)
    self.farmId = farmId
    self.dayId = dayId
    self.category = category
    self.amount = amount
end
