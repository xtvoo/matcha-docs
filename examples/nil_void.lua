-- Nil Void Script for Matcha
-- Toggles Character Parent to ReplicatedStorage ('N').
-- (Setting Parent to nil is blocked by this executor, so we hide in RepStorage).
-- This effectively makes the character invisible/non-existent to scripts scanning Workspace.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

local NilVoid = {}
local active = false
local char_ref = nil
local saved_parent = workspace

function NilVoid.enable()
    if active then return end
    
    local char = player.Character
    if not char then 
        warn("No character to Nil!")
        return 
    end
    
    -- Save reference
    char_ref = char
    saved_parent = char.Parent or workspace
    
    -- Parent to ReplicatedStorage (Hide from Workspace)
    -- We use pcall just in case
    local success, err = pcall(function()
        char.Parent = ReplicatedStorage
    end)
    
    if success then
        active = true
        print("Nil Void Enabled: Character hidden in ReplicatedStorage.")
    else
        warn("Failed to set Parent: " .. tostring(err))
    end
end

function NilVoid.disable()
    if not active then return end
    
    if char_ref then
        -- Restore to Workspace
        local success, err = pcall(function()
            char_ref.Parent = saved_parent
        end)
        
        if success then
            print("Nil Void Disabled: Character restored to Workspace.")
        else
            warn("Failed to restore Parent: " .. tostring(err))
            -- Try workspace directly if saved_parent was weird
            pcall(function() char_ref.Parent = workspace end)
        end
    else
        warn("Character reference lost! (You might need to respawn)")
    end
    
    active = false
    char_ref = nil
end

function NilVoid.toggle()
    if active then
        NilVoid.disable()
    else
        NilVoid.enable()
    end
end

-- Bind to N
local bind = 0x4E -- N
local last = false

print("Nil Void Loaded. Press 'N' to toggle.")

spawn(function()
    while true do
        if isrbxactive() then
            local pressed = iskeypressed(bind)
            if pressed and not last then
                NilVoid.toggle()
            end
            last = pressed
        else
            last = false
        end
        wait(0.05)
    end
end)
