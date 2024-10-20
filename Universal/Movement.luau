local Movement = {}

function Movement:ChangeWalkspeed(player: Player, speed: number)
    local humanoid = player.Character:WaitForChild("Humanoid")
    humanoid.WalkSpeed = speed
end

return Movement