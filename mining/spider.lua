local mainTunnelLength = 100 -- The length of the main tunnel
local branchLength = 10 -- The length of each side branch
local branchSpacing = 3 -- The distance between each branch
local function checkFuel()
	-- The fuel limit to refuel at.
	local fuelLimit = 10

	-- Check if the fuel level is below the limit
	if turtle.getFuelLevel() <= fuelLimit then
		print("Fuel is low. Refueling...")
		-- Select the first slot (where the fuel is)
		turtle.select(1)
		-- Refuel with all the items in the selected slot
		if turtle.refuel() then
			print("Refueled successfully.")
		else
			print("Failed to refuel. Out of fuel.")
			-- End the program if refueling fails
			return false
		end
		-- Select the second slot to continue mining
		turtle.select(2)
	end
	return true
end

-- Function to check if the inventory is full
local function isInventoryFull()
	-- Check each slot from 2 to 16
	for i = 2, 16 do
		-- If any slot is empty, the inventory is not full
		if turtle.getItemCount(i) == 0 then
			return false
		end
	end
	-- If all slots are full, return true
	return true
end

-- Function to drop off items in a chest
local function dropOffItems()
	print("Inventory is full. Returning to drop off items.")
	-- Turn around to face the chest
	turtle.turnLeft()
	turtle.turnLeft()

	-- Go back to the starting point
	for i = 1, mainTunnelLength do
		turtle.forward()
	end

	-- Drop off all items except the fuel
	for i = 2, 16 do
		turtle.select(i)
		turtle.drop()
	end

	-- Turn around to face the tunnel again
	turtle.turnLeft()
	turtle.turnLeft()

	-- Go back to the mining position
	for i = 1, mainTunnelLength do
		turtle.forward()
	end
end

-- Function to dig forward, checking for obstacles
local function digForward()
	-- Check for an obstacle in front
	while turtle.detect() do
		-- Dig the obstacle
		turtle.dig()
		-- Wait a moment for the block to break
		os.sleep(0.5)
	end
	-- Move forward
	turtle.forward()
end

-- Function to dig a branch
local function digBranch()
	for i = 1, branchLength do
		checkFuel()
		if isInventoryFull() then
			dropOffItems()
		end
		digForward()
	end
	-- Return to the main tunnel
	turtle.turnLeft()
	turtle.turnLeft()
	for i = 1, branchLength do
		turtle.forward()
	end
	turtle.turnLeft()
	turtle.turnLeft()
end

--[[
  Main Program
]]

print("Starting spider mining program...")

-- Main loop for the main tunnel
for i = 1, mainTunnelLength do
	-- Check fuel and inventory
	if not checkFuel() then
		break
	end
	if isInventoryFull() then
		dropOffItems()
	end

	-- Dig forward
	digForward()

	-- Check if it's time to dig a branch
	if i % branchSpacing == 0 then
		-- Dig a branch to the left
		turtle.turnLeft()
		digBranch()
		turtle.turnLeft()

		-- Dig a branch to the right
		turtle.turnRight()
		turtle.turnRight()
		digBranch()
		turtle.turnRight()
	end
end

print("Spider mining complete.")
