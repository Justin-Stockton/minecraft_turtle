local spider = {}

function spider.mine()
	local turtle = require("turtle")
	local block = require("block")
	local inventory = require("inventory")

	if not turtle.forward() then
		return false
	end

	if not block.isAir() then
		turtle.digDown()
		turtle.digUp()
		turtle.dig()
	end

	if not inventory.isFull() then
		turtle.suckDown()
		turtle.suckUp()
		turtle.suck()
	end

	return true
end
