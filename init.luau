-- author   :   Alex Karma
-- name     :   WeightedRandom.luau
-- version  :   0.1.0

export type WeightedItem<T> = {
	id: string, -- Unique identifier
	weight: number, -- Current weight
	weightInitial: number, -- Starting (minimum) weight
	data: T, -- Any associated data (floor model, etc.)
}

export type WeightedRandom<T> = {
	_items: { WeightedItem<T> },
	_shouldIncrease: boolean,

	addItem: (self: WeightedRandom<T>, id: string, initialWeight: number, data: T) -> (),
	getRandom: (self: WeightedRandom<T>) -> WeightedItem<T>?,
	_increaseAll: (self: WeightedRandom<T>, factor: number) -> (),
	_decrease: (self: WeightedRandom<T>, item: WeightedItem<T>, factor: number) -> (),
}

local WeightedRandom = {}
WeightedRandom.__index = WeightedRandom

--[[
    Create new weighted random instance
    @param increase Boolean (optional) -- Increase weight of all items by 10% per call or not
    @return WeightedRandom
]]
function WeightedRandom.new<T>(increase: boolean?): WeightedRandom<T>
	local self = setmetatable({}, WeightedRandom)
	self._items = {}
	self._shouldIncrease = increase or false
	return self
end

--[[
    Add a new item with its initial weight
    @param id Unique identifier
    @param initialWeight Starting weight
    @param data Any associated data
]]
function WeightedRandom:addItem(id: string, initialWeight: number, data: any)
	table.insert(self._items, {
		id = id,
		weight = initialWeight,
		weightInitial = initialWeight,
		data = data,
	})
end

--[[
    Increase weight for all items by a factor (percentage of initial weight)
    @param factor Percentage of initial weight
]]
function WeightedRandom:_increaseAll(factor: number)
	for _, item in self._items do
		item.weight += item.weightInitial * factor
	end
end

--[[
    Decrease weight of a specific item by multiplying and clamping to initial
    @param item WeightedItem
    @param factor Percentage of initial weight
]]
function WeightedRandom:_decrease(item: WeightedItem<any>, factor: number)
	item.weight = math.max(item.weightInitial, item.weight * factor)
end

--[[
    Get a random item based on current weights
    And optionally modifies weights
    @return nil if there are no items otherwise WeightedItem
]]
function WeightedRandom:getRandom(): WeightedItem<any>?
	if #self._items == 0 then
		return nil
	end

	if self._shouldIncrease then    
		-- Increase chances for all items
		self:_increaseAll(0.1) -- +10% of initial weight per call
	end

	-- Calculate total weight
	local totalWeight = 0
	for _, item in self._items do
		totalWeight += item.weight
	end

	-- Roll a random value
	local roll = math.random() * totalWeight
	local cumulative = 0

	-- Find the winning item
	for _, item in self._items do
		cumulative += item.weight
		if roll < cumulative then
			if self._shouldIncrease then
				-- Decrease its chance significantly
				self:_decrease(item, 0.1) -- Keep at least initial weight
			end
			return item
		end
	end

	return nil
end

return WeightedRandom
