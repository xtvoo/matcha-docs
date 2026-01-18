-- Clone Test Script
-- Attempts to create a local visual clone of the character.
-- NOTE: True "Server-side" cloning is usually impossible from the client.
-- This creates a CLIENT-SIDE decoy.

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local char = player.Character

if not char then
    print("No character found!")
    return
end

print("Attempting to clone character...")

-- Step 1: Enable Archivable
char.Archivable = true

-- Step 2: Clone
local clone = char:Clone()

if clone then
    clone.Parent = workspace
    clone.Name = player.Name .. "_Decoy"
    
    -- Simplify the clone (Anchor it, make it ghostly)
    local root = clone:FindFirstChild("HumanoidRootPart")
    if root then
        root.CFrame = char.PrimaryPart.CFrame * CFrame.new(5, 0, 0) -- Spawn 5 studs away
    end
    
    for _, part in pairs(clone:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Anchored = true
            part.CanCollide = false
            part.Transparency = 0.5
            part.Color = Color3.fromRGB(100, 100, 255) -- Blue ghost
        elseif part:IsA("Script") or part:IsA("LocalScript") then
            part:Destroy() -- Remove scripts
        end
    end
    
    print("Clone created successfully (Local Only)")
else
    print("Failed to clone character (Clone() returned nil)")
end
