local WeightedRandom = require(script.Parent.WeightedRandom)

-- Example with weighted items (Colors in this case)

local random = WeightedRandom.new(true)

random:addItem("Red", 20, Color3.new(1, 0, 0))
random:addItem("Green", 20, Color3.new(0, 1, 0))
random:addItem("Blue", 20, Color3.new(0, 0, 1))

random:addItem("Yellow", 10, Color3.new(1, 1, 0))
random:addItem("Black", 10, Color3.new(0, 0, 0))
random:addItem("Pink", 10, Color3.new(1, 0, 1))

random:addItem("Orange", 5, Color3.new(1, 0.5, 0.1))
random:addItem("Purple", 5, Color3.new(0.5, 0, 1))
random:addItem("Crimson", 5, Color3.new(0.5, 0, 0))

random:addItem("Silver", 2.5, Color3.new(0.8, 0.8, 0.8))
random:addItem("Gold", 1, Color3.new(1, 0.7, 0))
random:addItem("Diamond", 0.5, Color3.new(0, 0.75, 1))

local counter = {}
local iterations = 10_000

-- Let's see how many times each color was picked after 10,000 iterations
	
for _ = 1, iterations do
	local item = random:getRandom()
	counter[item.id] = (counter[item.id] or 0) + 1
end

print(counter)