-- Desync API: Client Freeze / Server Move
-- 'X' to Toggle.
-- 1. Creates a Visual Decoy (Ghost).
-- 2. Locks Camera to Ghost (Client "Freezes").
-- 3. Rapidly teleports Real Character (Server "Moves"/"Voids").
-- 4. Restores Real Character to Ghost position on Disable.

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local player = Players.LocalPlayer
local camera = Workspace.CurrentCamera

local DesyncAPI = {}
local active = false
local loop_conn = nil
local visual_clone = nil
local start_pos = nil

function DesyncAPI.enable()
    if active then return end
    
    local char = player.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChild("Humanoid")
    if not root or not hum then return end
    
    active = true
    print("Desync Enabled: Client Frozen, Server Moving.")
    
    -- 1. Save Position
    start_pos = root.Position
    
    -- 2. Create Visual Ghost (Client Side Freeze visual)
    local ghostFolder = Instance.new("Folder")
    ghostFolder.Name = "Desync_Decoy"
    ghostFolder.Parent = Workspace
    visual_clone = ghostFolder
    
    -- Create dummy part for Camera Focus
    local camPart = Instance.new("Part")
    camPart.Name = "CamPart"
    camPart.Size = Vector3.new(1,1,1)
    camPart.Transparency = 1
    camPart.Anchored = true
    camPart.CanCollide = false
    camPart.Position = root.Position
    camPart.Parent = ghostFolder
    
    -- Build Visual Model
    pcall(function()
        for _, p in pairs(char:GetChildren()) do
            if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then
                local part = Instance.new("Part")
                part.Name = p.Name
                part.Size = p.Size
                part.Position = p.Position
                pcall(function() part.Rotation = p.Rotation end)
                part.Anchored = true
                part.CanCollide = false
                part.Transparency = 0.5
                part.Color = Color3.fromRGB(100, 255, 100) -- Green = Safe/Frozen
                part.Material = Enum.Material.Neon
                part.Parent = ghostFolder
            end
        end
    end)
    
    -- 3. Lock Camera to Ghost
    camera.CameraSubject = camPart
    
    -- 4. Server Move Loop (Void Desync Logic)
    loop_conn = RunService.Heartbeat:Connect(function()
        if root and root.Parent then
            -- Randomize Position locally (replicates to server)
            -- We assume CFrame/Position is available.
            local randX = math.random(-50, 50)
            local randY = math.random(-50, 50)
            local randZ = math.random(-50, 50)
            
            local target = Vector3.new(start_pos.X + randX, start_pos.Y + randY, start_pos.Z + randZ)
            root.Velocity = Vector3.new(0,0,0) -- stability
            root.Position = target
        end
    end)
end

function DesyncAPI.disable()
    if not active then return end
    active = false
    
    if loop_conn then
        loop_conn:Disconnect()
        loop_conn = nil
    end
    
    -- Restore Character
    local char = player.Character
    if char then
        local root = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChild("Humanoid")
        
        -- Teleport back to start
        if root and start_pos then
            root.Velocity = Vector3.new(0,0,0)
            root.Position = start_pos
        end
        
        -- Restore Camera
        if hum then
            camera.CameraSubject = hum
        end
    end
    
    -- Cleanup Ghost
    if visual_clone then
        pcall(function() visual_clone:Destroy() end)
        visual_clone = nil
    end
    
    print("Desync Disabled.")
end

function DesyncAPI.toggle()
    if active then
        DesyncAPI.disable()
    else
        DesyncAPI.enable()
    end
end

-- Binds
local bind_toggle = 0x58 -- X
local last_toggle = false

print("Desync Client-Freeze/Server-Move Loaded.")
print("[X] Toggle")

spawn(function()
    while true do
        if isrbxactive() then
            local pressed = iskeypressed(bind_toggle)
            if pressed and not last_toggle then
                DesyncAPI.toggle()
            end
            last_toggle = pressed
        else
            last_toggle = false
        end
        wait(0.05)
    end
end)
