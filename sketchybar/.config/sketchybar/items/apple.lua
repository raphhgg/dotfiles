local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

-- No extra padding needed, bar padding_left handles it

local apple = sbar.add("item", {
    icon = {
        font = { family = settings.font.text, size = 14.0 },
        string = icons.apple,
        color = colors.lavender,
        padding_right = 8,
        padding_left = 8,
    },
    label = { drawing = false },
    background = {
        color = colors.bg0,
        border_width = 1,
        height = 26,
        border_color = colors.bg3,
    },
    padding_left = 1,
    padding_right = 1,
    click_script = "$CONFIG_DIR/helpers/menus/bin/menus -s 0"
})

-- Double border for apple using a single item bracket
-- sbar.add("bracket", { apple.name }, {
--     background = {
--         color = colors.transparent,
--         height = 30,
--         border_color = colors.bg1,
--     }
-- })

-- Padding after apple logo
sbar.add("item", { width = 4 })
