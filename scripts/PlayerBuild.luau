local ReplicatedStorage = game:GetService("ReplicatedStorage")
local remoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")

local placeBlockEvent = remoteEvents:WaitForChild("PlaceBlock")

--local blockTemplate = ReplicatedStorage:WaitForChild("Buildings"):WaitForChild("Block")

placeBlockEvent.OnServerEvent:Connect(function(player, targetCFrame, blockTemplate)
	if typeof(targetCFrame) ~= "CFrame" then return end

	local newBlock = blockTemplate:Clone()
	newBlock.CFrame = targetCFrame
	newBlock.CanCollide = true
	newBlock.Transparency = 0
	newBlock.Parent = workspace
end)