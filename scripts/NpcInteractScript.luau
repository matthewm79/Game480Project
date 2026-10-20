local part = script.Parent
local text = script.Parent.Parent:WaitForChild("DialogPart"):WaitForChild("BillboardGui"):WaitForChild("TextLabel")
local prompt = part:WaitForChild("ProximityPrompt")
local npc = script.Parent.Parent:WaitForChild("NPC")
local numDialog = 10

local dialog = {
	"Hello, welcome to the game!",
	"Would you like to play?",
	"Alright, lets get started!",
	"First, lets go to the store!",
	"Purchase a block!",
	"Then, lets go to the building area!",
	"Build a house!",
	"8",
	"9",
	"10"
}

prompt.Triggered:Connect(function(player)
	text.BackgroundTransparency = 0.7
	text.TextTransparency = 0
	text.UIStroke.Transparency = 0
	for i = 1, numDialog do
		text.Text = dialog[i]
		wait(0.5)
	end
	text.BackgroundTransparency = 1
	text.TextTransparency = 1
	text.UIStroke.Transparency = 1
end)