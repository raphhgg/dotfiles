-- Require the sketchybar module
sbar = require("sketchybar")

-- Set the bar name, if you are using another bar instance than sketchybar
-- sbar.set_bar_name("bottom_bar")

-- Bundle the entire initial configuration into a single message to sketchybar
sbar.begin_config()
local function read_profile_from_file()
    local home = os.getenv("HOME")
    if not home then
        return nil
    end

    local path = home .. "/.config/sketchybar/.profile"
    local handle = io.open(path, "r")
    if not handle then
        return nil
    end

    local value = handle:read("*l")
    handle:close()
    if not value then
        return nil
    end

    value = value:gsub("%s+", "")
    if value == "" then
        return nil
    end

    return value
end

local profile = os.getenv("SKETCHYBAR_PROFILE") or read_profile_from_file() or "default"

if profile == "omarchy" then
    require("profiles.omarchy.init")
else
    require("profiles.default.init")
end
sbar.end_config()

-- Run the event loop of the sketchybar module (without this there will be no
-- callback functions executed in the lua module)
sbar.event_loop()
