local Players = game:GetService("Players")
local Visuals = {
	Chams = {},
}

function Visuals.new()
	local self = setmetatable({}, Visuals)
	return self
end

function Visuals.Chams:RefreshChams(MurdererColor, SheriffColor)
	for _, player in Players:GetPlayers() do
		local char = player.Character
		if not char then
			return
		end

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
			game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(player.DisplayName .. " has the knife")
		end

		if player.Backpack:FindFirstChild("Gun") then
			highlight.FillColor = SheriffColor
			highlight.FillTransparency = 0
			highlight.OutlineTransparency = 1
			print("Player: " .. player.DisplayName .. " is the sheriff")
			game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(player.DisplayName .. " has the gun")
		end
	end
end

return Visuals
