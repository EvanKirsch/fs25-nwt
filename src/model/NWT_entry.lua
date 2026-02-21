-- NWT_entry
--
-- Data object for table entry information
--

NWT_entry = {}

function NWT_entry:new(farmId, title, category, subCategory, details, amount)
    local prototype = {}
    setmetatable(prototype, self)
    self.__index = self

    prototype.farmId = farmId
    prototype.entryTitle = title
    prototype.category = category
    prototype.subCategory = subCategory
    prototype.details = details
    prototype.entryAmount = amount

    return prototype
end

function NWT_entry:getCSVHeaders()
    return "tile" .. "," ..
        "category" .. "," ..
        "subCategory" .. "," ..
        "details" .. "," ..
        "amount"
end

function NWT_entry:toCSV() -- putting in quotes to escape possible commas
    return "\"" .. (self.entryTitle or "") .. "\"" .. "," ..
        "\"" .. (self.category or "") .. "\"" .. "," ..
        "\"" .. (self.subCategory or "") .. "\"" .. "," ..
        "\"" .. (self.details or "") .. "\"" .. "," ..
        (self.entryAmount or "")
end
