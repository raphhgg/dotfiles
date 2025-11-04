local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local widget = require("helpers.widget")

-- Create system widget using widget helper (icon only, no label)
local system = widget.new("widgets.system", {
    icon = icons.cpu,
    label = "",
    update_background_on_theme = false,
    icon_padding_left = 8, -- Equal padding for centering
    icon_padding_right = 8,
})

-- Remove label padding
system:set({
    label = {
        padding_right = 0,
    }
})

-- Click to open Raycast system monitor popup
system:subscribe("mouse.clicked", function()
    sbar.exec(
        'osascript -e \'tell application "System Events" to tell process "Raycast" to perform action "AXPress" of menu bar item 2 of menu bar 2\'')
end)

-- Add bracket (consistent with other widgets)
sbar.add("bracket", "widgets.system.bracket", { system.name }, {
    background = {
        color = colors.transparent,
        border_color = colors.transparent,
    },
})

-- Add padding (consistent with other widgets)
sbar.add("item", "widgets.system.padding", {
    position = "right",
    width = settings.group_paddings,
})

-- Subscribe to theme changes to update colors
system:subscribe("theme_changed", function()
    system:set({
        background = {
            color = colors.bg0,
            border_color = colors.bg3,
        },
    })
end)
