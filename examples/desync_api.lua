-- Server-Side Desync / CSync Script
-- 'X' to Toggle Desync (Freezes server position via Velocity)
-- 'Z' to CSync (Resync/Disable immediately)

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local DesyncAPI = {}
local connection = nil
local stepped_conn = nil

function DesyncAPI.enable()
    if connection then return end
    print("Desync Enabled (Server Position Frozen)")
    
    local char = player.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    -- 1. Heartbeat: Set Huge Velocity to break server replication
    -- The server rejects movement packets when velocity is absurd, 
    -- causing your character to "stick" at the last valid position on the server.
    connection = RunService.Heartbeat:Connect(function()
        if root and root.Parent then
            root.Velocity = Vector3.new(20000, 0, 20000) 
        end
    end)
    
    -- 2. RenderStepped: Correct client-side physics so YOU can move
    stepped_conn = RunService.RenderStepped:Connect(function()
        if root and root.Parent then
            -- Override the huge velocity LOCALLY ensuring smooth movement
            root.Velocity = Vector3.new(0, 0, 0)
        end
    end)
end

function DesyncAPI.disable()
    if connection then
        connection:Disconnect()
        connection = nil
    end
    if stepped_conn then
        stepped_conn:Disconnect()
        stepped_conn = nil
    end
    
    -- CSync: Ensure we are stable
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
    end
    print("Desync Disabled (CSync'd)")
end

function DesyncAPI.toggle()
    if connection then
        DesyncAPI.disable()
    else
        DesyncAPI.enable()
    end
end

-- Binds
local bind_toggle = 0x58 -- X
local bind_csync = 0x5A  -- Z

local last_toggle = false
local last_csync = false

print("Desync API Loaded.")
print("[X] Toggle Desync")
print("[Z] CSync (Disable/Resync)")

spawn(function()
    while true do
        if isrbxactive() then
            -- Toggle (X)
            local pressed_toggle = iskeypressed(bind_toggle)
            if pressed_toggle and not last_toggle then
                DesyncAPI.toggle()
            end
            last_toggle = pressed_toggle
            
            -- CSync (Z)
            local pressed_csync = iskeypressed(bind_csync)
            if pressed_csync and not last_csync then
                if connection then
                    DesyncAPI.disable() -- Force disable/resync
                else
                    print("Already synced.")
                end
            end
            last_csync = pressed_csync
        else
            last_toggle = false
            last_csync = false
        end
        wait(0.05)
    end
end)
