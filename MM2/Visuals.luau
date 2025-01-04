local Players = game:GetService("Players")
local Visuals = {
	Chams = {}
}

function Visuals.Chams:RefreshChams(MurdererColor, SheriffColor)
    for _, player in Players:GetPlayers() do
		local char = player.Character
		if not char then return end

		print(player.Backpack)
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
			print("Player: " .. player.DisplayName .. " is the one with a knife")
game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("The murderer is: ", player.DisplayName)
		end

		if player.Backpack:FindFirstChild("Gun") then
			highlight.FillColor = SheriffColor
			highlight.FillTransparency = 0
			highlight.OutlineTransparency = 1
			print("Player: " .. player.DisplayName .. " is the sheriff")
		end
	end
end

return Visuals
