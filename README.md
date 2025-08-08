# WeightedRandom.luau

`WeightedRandom.luau` is a Roblox (Luau) module that allows selecting random items based on their weights, with optional dynamic probability adjustments on each pick.

## Features

* **Add items** with a unique ID, initial weight, and any associated data.
* **Weighted selection** — items with higher weights have a greater chance of being picked.
* **Optional weight growth** — automatically increase the weight of all items each time `getRandom` is called.
* **Probability balancing** — drastically reduce the chance of the selected item to avoid repeats.

## Example

```lua
local WeightedRandom = require(path.to.WeightedRandom)

local randomizer = WeightedRandom.new(true) -- true = enable auto-adjustment
randomizer:addItem("floor1", 1, {name = "First Floor"})
randomizer:addItem("floor2", 1, {name = "Second Floor"})

local picked = randomizer:getRandom()
print("Picked:", picked.id, picked.data.name)
```


## Wally


