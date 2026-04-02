local colors = require("profiles.omarchy.colors")
local settings = require("settings")

sbar.default({
    updates = "when_shown",
    icon = {
        color = colors.fg,
        padding_left = 6,
        padding_right = 6,
        font = {
            family = settings.font.text,
            style = settings.font.style_map["Regular"],
            size = 13.0,
        },
    },
    label = {
        color = colors.fg,
        padding_left = 4,
        padding_right = 4,
        font = {
            family = settings.font.numbers,
            style = settings.font.style_map["Regular"],
            size = 13.0,
        },
    },
    background = {
        drawing = false,
    },
    popup = {
        background = {
            drawing = false,
        },
    },
    padding_left = 1,
    padding_right = 1,
    scroll_texts = false,
})
