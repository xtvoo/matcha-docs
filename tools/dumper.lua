-- Dumper Script for Matcha Environment
-- Saves output to workspace/dumper_output.txt

local content = ""

local function append(str)
    content = content .. str .. "\n"
end

local function dumpTable(tbl, name, indent)
    indent = indent or ""
    append(indent .. name .. ":")
    for k, v in pairs(tbl) do
        local typeStr = type(v)
        if typeStr == "function" then
            append(indent .. "  " .. tostring(k) .. " (" .. typeStr .. ")")
        elseif typeStr == "table" and v ~= tbl and v ~= _G then -- Avoid infinite recursion
             append(indent .. "  " .. tostring(k) .. " (table)")
             -- Uncomment to recurse deeper (careful with huge environments)
             -- dumpTable(v, tostring(k), indent .. "  ")
        else
            append(indent .. "  " .. tostring(k) .. " (" .. typeStr .. ") = " .. tostring(v))
        end
    end
end

append("=== Global Environment Dump ===")
local env = getgenv and getgenv() or getfenv and getfenv() or _G
dumpTable(env, "Environment")

if debug then
    append("\n=== debug Library ===")
    dumpTable(debug, "debug")
end

if Drawing then
    append("\n=== Drawing Library ===")
    dumpTable(Drawing, "Drawing")
end

if bit then
    append("\n=== bit Library ===")
    dumpTable(bit, "bit")
end

-- Check for specific known libraries or globals to expand on
local known_globals = {
    "getrenv", "getgc", "getinstances", "getnilinstances", "getscripts", "getloadedmodules", 
    "getconnections", "firesignal", "fireclickdetector", "firetouchinterest", "fireproximityprompt",
    "hookfunction", "hookmetamethod", "newcclosure", "loadstring", "checkcaller", "islclosure", "dumpstring",
    "decompile", "getscripthash", "getrawmetatable", "setrawmetatable", "setreadonly", "isreadonly", "make_writeable",
    "make_readonly", "is_writeable", "is_readonly", "getnamecallmethod", "setnamecallmethod", "getcallingscript",
    "getscriptclosure", "getscriptfunction", "mouse1click", "keypress", "keyrelease", "mouse1press", "mouse1release",
    "memory_write", "memory_read"
}

append("\n=== Specific Globals Check ===")
for _, name in ipairs(known_globals) do
    if env[name] then
        append("[DOM] " .. name .. " exists")
    else
        append("[MISS] " .. name .. " NOT found")
    end
end

if writefile then
    writefile("matcha_dump.txt", content)
    print("Dump saved to matcha_dump.txt")
else
    print(content)
    print("writefile not supported, output printed to console")
end
