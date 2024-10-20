local Players = game:GetService("Players")
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

--#region Cheat Modules

local Visuals = loadstring(game:HttpGet("https://raw.githubusercontent.com/Alyx775c/AlyxHub/refs/heads/main/MM2/Visuals.luau"))
local Chams = Visuals.Chams

local Movement = loadstring(game:HttpGet("https://raw.githubusercontent.com/Alyx775c/AlyxHub/refs/heads/main/Universal/Movement.luau"))

--#endregion

local GameplayEvents = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes"):FindFirstChild("Gameplay")

local Window = Rayfield:CreateWindow({
	Name = "Alyx Hub : Rayfield Edition",
	LoadingTitle = "",
	LoadingSubtitle = "by alyx775c",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = "AlyxHub", -- Create a custom folder for your hub/game
		FileName = "Big Hub",
	},
	Discord = {
		Enabled = false,
		Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
		RememberJoins = true, -- Set this to false to make them join the discord every time they load it up
	},
	KeySystem = true, -- Set this to true to use our key system
	KeySettings = {
		Title = "",
		Subtitle = "Key System",
		Note = "",
		FileName = "AlyxHubMM2key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
		SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
		GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
		Key = { "AlyxHub__723jjhyCnyxnAL" }, -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
	},
})

local MM2Events = {
	["RoundStart"] = GameplayEvents:FindFirstChild("RoundStart"),
	["KnifeKill"] = GameplayEvents:FindFirstChild("KnifeKill"),
	["GunKill"] = GameplayEvents:FindFirstChild("GunKill"),
}

local MainTab = Window:CreateTab("🏠 Home", nil)
local VisualTab = Window:CreateTab("👁️ Visuals", nil)
local MovementTab = Window:CreateTab("🏃‍♂️ Movement", nil)

local LocalPlayer = Players.LocalPlayer

--#region Visuals
local SheriffColor = VisualTab:CreateColorPicker({
	Name = "Sheriff Color",
	Color = Color3.fromRGB(0, 0, 255),
	Flag = "SheriffColor",
})

local MurdererColor = VisualTab:CreateColorPicker({
	Name = "Murderer Color",
	Color = Color3.fromRGB(255, 0, 0),
	Flag = "MurdererColor",
})

local DetectGunDrop = function()
	for _, v in workspace:GetDescendants() do
		if v.Name == "GunDrop" then
			return v
		end
	end

	return nil
end
function GunChams()
	local GunDropped = DetectGunDrop()

	if GunDropped and not GunDropped:FindFirstChild("Highlight") then
		local highlight = Instance.new("Highlight")
		highlight.Parent = GunDropped
		highlight.FillColor = Color3.fromRGB(255, 255, 0)
		highlight.OutlineTransparency = 1
	end
end
local ChamsButton = VisualTab:CreateToggle({
	Name = "Chams",
	CurrentValue = false,
	Flag = "ChamsFlag",
	Callback = function(val)
		local knifeEvent = MM2Events["KnifeKill"].Event:Connect(GunChams)
		local gunEvent = MM2Events["GunKill"].Event:Connect(GunChams)

		if val then
			Chams:RefreshChams(MurdererColor.Color, SheriffColor.Color)
			knifeEvent = MM2Events["KnifeKill"].Event:Connect(GunChams)
			gunEvent = MM2Events["GunKill"].Event:Connect(GunChams)
		else
			knifeEvent:Disconnect()
			gunEvent:Disconnect()

			for _, plr in Players:GetPlayers() do
				if plr.Character:FindFirstChild("Highlight") then
					plr.Character:FindFirstChild("Highlight"):Destroy()
				end
			end
		end
	end,
})
--#endregion

--#region Movement
MovementTab:CreateSlider({
	Name = "Walkspeed",
	Range = {12, 100},
	Increment = 1,
	Suffix = "",
	CurrentValue = 10,
	Flag = "WalkspeedSlider",
	Callback = function(Value)
		Movement:ChangeWalkspeed(LocalPlayer, Value)
	end,
 })
--#endregion

--#region Events
MM2Events["RoundStart"].OnClientEvent:Connect(function()
	if ChamsButton.CurrentValue then
		Chams:RefreshChams(MurdererColor.Color, SheriffColor.Color)
	end
end)
--#endregion