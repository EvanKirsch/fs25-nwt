-- NWT_history
--
-- Data object for value at a period save point entry information
--

NWT_history = {}

function NWT_history:new(farmId, dayId, periodId, dayInPeriod, year, category, amount)
    local prototype = {}
    setmetatable(prototype, self)
    self.__index = self

    prototype.farmId = farmId
    prototype.dayId = dayId
    prototype.periodId = periodId
    prototype.dayInPeriod = dayInPeriod
    prototype.year = year
    prototype.category = category
    prototype.amount = amount

    return prototype
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
