local Players = game:GetService("Players")
local Visuals = {
	Chams = {}
}

function Visuals.Chams:RefreshChams(MurdererColor, SheriffColor)
    for _, player in Players:GetPlayers() do
		local char = player.Character

		local highlight

		if not char:FindFirstChild("Highlight") then
			highlight = Instance.new("Highlight")
		else
			highlight = char:FindFirstChild("Highlight")
		end
		highlight.Adornee = char
		highlight.Parent = char
		highlight.FillTransparency = 1
		highlight.OutlineTransparency = 0

		if player.Backpack:FindFirstChild("Knife") then
			highlight.FillColor = MurdererColor
			highlight.FillTransparency = 0
			highlight.OutlineTransparency = 1
			print("Player: " .. player.Name .. " is the one with a knife")
		end

		if player.Backpack:FindFirstChild("Gun") then
			highlight.FillColor = SheriffColor
			highlight.FillTransparency = 0
			highlight.OutlineTransparency = 1
			print("Player: " .. player.Name .. " is the sheriff")
		end
	end
end

return Visuals