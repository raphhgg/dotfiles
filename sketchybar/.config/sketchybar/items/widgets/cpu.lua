local icons = require("icons")
local colors = require("colors")
local settings = require("settings")
local widget = require("helpers.widget")

-- Execute the event provider binary which provides the event "cpu_update" for
-- the cpu load data, which is fired every 2.0 seconds.
sbar.exec("killall cpu_load >/dev/null; $CONFIG_DIR/helpers/event_providers/cpu_load/bin/cpu_load cpu_update 2.0")

-- Add extra padding before CPU (to separate from WiFi widget on the right)
sbar.add("item", "widgets.cpu.padding_left", {
    position = "right",
    width = settings.group_paddings + 30, -- Extra spacing before CPU
})

-- Create base CPU widget with lavender color
local cpu = widget.new("widgets.cpu", {
    icon = icons.cpu,
    label = "??%",
    update_background_on_theme = true,
    icon_color = colors.lavender,
    label_color = colors.lavender,
})

cpu:subscribe("cpu_update", function(env)
    local load = tonumber(env.total_load)

    -- Color changes based on load: lavender or red only
    local color = colors.lavender
    if load > 70 then
        color = colors.red
    end

    cpu:set({
        label = {
            string = load .. "%",
            color = color,
        },
        icon = {
            color = color,
        },
    })
end)

cpu:subscribe("mouse.clicked", function(env)
    sbar.exec("open -a 'Activity Monitor'")
end)
