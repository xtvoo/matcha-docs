-- Deep Visual Tests for Matcha
-- Probes for advanced Drawing types and internal properties

local function test(name, func)
    print("Testing: " .. name)
    local success, err = pcall(func)
    if not success then
        print("[FAIL] " .. name .. ": " .. tostring(err))
    else
        print("[PASS] " .. name)
    end
end

local function dump_props(obj, name)
    print("--- Dumping Props for " .. name .. " ---")
    -- Try direct iteration if possible (unlikely for userdata)
    for k, v in pairs(obj) do
        print("  [Direct] " .. tostring(k) .. ": " .. tostring(v))
    end
    
    -- Try getmetatable
    local mt = getmetatable(obj)
    if mt then
        print("  [Meta] Metatable found")
        if mt.__index and type(mt.__index) == "table" then
            for k, v in pairs(mt.__index) do
                 print("  [MetaIndex] " .. tostring(k) .. ": " .. tostring(v))
            end
        end
    end
    
    -- Try common hidden properties blindly
    local common_props = {
        "ZIndex", "Transparency", "Visible", "Color", "Size", "Position", 
        "Filled", "Thickness", "From", "To", "Radius", "NumSides", "Text", 
        "Outline", "Center", "Font", "PointA", "PointB", "PointC", "PointD",
        "Data", "Uri", "Rounding", "Opacity"
    }
    
    for _, prop in ipairs(common_props) do
        local success, val = pcall(function() return obj[prop] end)
        if success and val ~= nil then
             print("  [Probe] " .. prop .. ": " .. tostring(val))
        end
    end
end

print("=== Deep Visual Test Start ===")

-- Test "Quad"
test("Drawing.new('Quad')", function()
    local q = Drawing.new("Quad")
    q.Visible = true
    q.PointA = Vector2.new(100, 100)
    q.PointB = Vector2.new(200, 100)
    q.PointC = Vector2.new(200, 200)
    q.PointD = Vector2.new(100, 200)
    q.Color = Color3.fromRGB(0, 0, 255)
    q.Filled = true
    print("Created Blue Quad")
    dump_props(q, "Quad")
    task.delay(5, function() q:Remove() end)
end)

-- Test "Image"
test("Drawing.new('Image')", function()
    local img = Drawing.new("Image")
    -- Try setting some potential properties
    img.Visible = true
    img.Position = Vector2.new(300, 300)
    img.Size = Vector2.new(100, 100)
    -- This often requires Data or Uri
    print("Created Image (Placeholder)")
    dump_props(img, "Image")
    task.delay(5, function() img:Remove() end)
end)

-- Test "Triangle" probing
test("Triangle Probe", function()
    local t = Drawing.new("Triangle")
    dump_props(t, "Triangle")
    t:Remove()
end)

print("=== Deep Visual Test End ===")
