local colors = require("profiles.omarchy.colors")
local icons = require("icons")
local settings = require("settings")

sbar.add("item", "omarchy.apple", {
    position = "left",
    icon = {
        string = icons.apple,
        color = colors.fg,
        font = {
            family = settings.font.text,
            style = settings.font.style_map["Regular"],
            size = 14.0,
        },
    },
    label = { drawing = false },
    click_script = "$CONFIG_DIR/helpers/menus/bin/menus -s 0",
    padding_left = 10,
    padding_right = 6,
})
