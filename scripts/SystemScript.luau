local lighting = game:GetService("Lighting")
local DAY_TIME = 12
local NIGHT_TIME = 0

function spawnHorde(numWaves)
	--[[while num waves left is not 0 then spawn a wave at a time and wait until
	a limited number of enemies are left in each wave before spawning another wave of enemies
	]]
end


function startDay()
	local curTime = lighting.ClockTime
	while curTime ~= DAY_TIME do
		curTime = curTime + 0.01
		lighting.ClockTime = curTime
		task.wait(0.0002)
		if curTime >= DAY_TIME then
			curTime = DAY_TIME
			lighting.ClockTime = curTime
		end
	end
	
	
	
	
end

function startNight()
	local curTime = lighting.ClockTime
	while curTime ~= NIGHT_TIME do
		curTime = curTime - 0.01
		lighting.ClockTime = curTime
		task.wait(0.0002)
		if curTime <= NIGHT_TIME then
			curTime = NIGHT_TIME
			lighting.ClockTime = curTime
			print("30")
		end
		
	end
	
	
end

wait(5)
startNight()
print("40")
wait(2)
startDay()
print("END")