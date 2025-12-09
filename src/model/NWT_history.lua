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

function NWT_history:init(farmId, dayId, periodId, dayInPeriod, year, category, amount)
    self.farmId = farmId
    self.dayId = dayId
    self.periodId = periodId
    self.dayInPeriod = dayInPeriod
    self.year = year
    self.category = category
    self.amount = amount
end

function NWT_history:getCSVHeaders()
    return "dayId" .. "," ..
        "periodId" .. "," ..
        "dayInPeriod" .. "," ..
        "year" .. "," ..
        "category" .. "," ..
        "amount"
end

function NWT_history:toCSV()
    return (self.dayId or "") .. "," ..
        (self.periodId or "") .. "," ..
        (self.dayInPeriod or "") .. "," ..
        (self.year or "") .. "," ..
        (self.category or "") .. "," ..
        (self.amount or "")
end
