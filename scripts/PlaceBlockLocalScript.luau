local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

local remoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")
local placeBlockEvent = remoteEvents:WaitForChild("PlaceBlock")
local blockTemplate = ReplicatedStorage:WaitForChild("Buildings"):WaitForChild("Block")
local scrollFrame = script.Parent:WaitForChild("SelectorFrame"):WaitForChild("ScrollingFrame")

local button = script.Parent:WaitForChild("Frame"):WaitForChild("TextButton")

local isBuilding = false
local previewBlock = nil
local renderConnection = nil
local clickConnection = nil

local GRID_SIZE = 1

local function snapToGrid(position)
	local x = math.floor(position.X / GRID_SIZE + 0.5) * GRID_SIZE
	local y = math.floor(position.Y / GRID_SIZE + 0.5) * GRID_SIZE
	local z = math.floor(position.Z / GRID_SIZE + 0.5) * GRID_SIZE
	return Vector3.new(x, y, z)
end

local function getNormalVector(normalId)
	if not normalId then return Vector3.new(0, 1, 0) end
	return Vector3.fromNormalId(normalId)
end

local function startBuilding()
	isBuilding = true
	if previewBlock then
		previewBlock:Destroy()
		previewBlock = nil
	end
	previewBlock = blockTemplate:Clone()
	previewBlock.Transparency = 0.5
	previewBlock.CanCollide = false
	previewBlock.Parent = workspace

	mouse.TargetFilter = previewBlock

	renderConnection = RunService.RenderStepped:Connect(function()
		if previewBlock and mouse.Target then
			local surfaceNormal = getNormalVector(mouse.TargetSurface)
			local blockExtent = previewBlock.Size / 2

			local surfacePosition = mouse.Hit.Position + (surfaceNormal * blockExtent)

			local snappedPosition = snapToGrid(surfacePosition)

			previewBlock.CFrame = CFrame.new(snappedPosition)
		end
	end)

	clickConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then return end
		if input.UserInputType == Enum.UserInputType.MouseButton1 and isBuilding and previewBlock then
			placeBlockEvent:FireServer(previewBlock.CFrame, blockTemplate)
		end
	end)
end

local function stopBuilding()
	isBuilding = false

	if renderConnection then
		renderConnection:Disconnect()
		renderConnection = nil
	end

	if clickConnection then
		clickConnection:Disconnect()
		clickConnection = nil
	end

	if previewBlock then
		previewBlock:Destroy()
		previewBlock = nil
	end
end

button.MouseButton1Click:Connect(function()
	if isBuilding then
		stopBuilding()
	else
		startBuilding()
	end
end)

scrollFrame:WaitForChild("Block").MouseButton1Click:Connect(function()
	blockTemplate = ReplicatedStorage:WaitForChild("Buildings"):WaitForChild("Block")
	startBuilding()
end)

scrollFrame:WaitForChild("Rectangle").MouseButton1Click:Connect(function()
	blockTemplate = ReplicatedStorage:WaitForChild("Buildings"):WaitForChild("Rectangle")
	startBuilding()
end)