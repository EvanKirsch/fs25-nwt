-- NWT_valueAtPeriod
--
-- Data object for value at a period save point entry information
--

NWT_valueAtPeriod = {}
local NWT_valueAtPeriod_mt = Class(NWT_valueAtPeriod, Object)

InitObjectClass(NWT_valueAtPeriod, "NWT_valueAtPeriod")

function NWT_valueAtPeriod.new(isServer, isClient, customMt)
    local self = Object.new(isServer, isClient, customMt or NWT_valueAtPeriod_mt)

    return self
end

function NWT_valueAtPeriod:init(farmId, periodId, category, amount)
    self.farmId = farmId
    self.periodId = periodId
    self.category = category
    self.amount = amount
end
