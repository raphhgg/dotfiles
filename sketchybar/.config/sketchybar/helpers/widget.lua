local colors = require("colors")
local settings = require("settings")

local widget = {}

-- Widget defaults - customize these to change all widgets
widget.defaults = {
    icon_padding_left = 12,
    icon_padding_right = 8,
    label_padding_right = 12,
    icon_color = colors.lavender,
    label_color = colors.lavender,
}

-- Create a base widget item with standard styling
function widget.new(name, opts)
    opts = opts or {}

    local item = sbar.add("item", name, {
        position = "right",
        icon = {
            string = opts.icon or "",
            padding_left = opts.icon_padding_left or widget.defaults.icon_padding_left,
            padding_right = opts.icon_padding_right or widget.defaults.icon_padding_right,
            color = opts.icon_color or widget.defaults.icon_color,
            font = {
                style = settings.font.style_map["Regular"],
                size = 15.0,
            },
        },
        label = {
            string = opts.label or "",
            color = opts.label_color or widget.defaults.label_color,
            padding_right = opts.label_padding_right or widget.defaults.label_padding_right,
            font = {
                family = settings.font.numbers,
                size = 13.0,
            },
        },
        padding_left = 1,
        padding_right = 1,
        background = {
            color = colors.bg0,
            border_width = 1,
            height = 26,
            border_color = colors.bg3,
        },
        update_freq = opts.update_freq,
        popup = opts.popup,
    })

    -- Add bracket
    sbar.add("bracket", name .. ".bracket", { item.name }, {
        background = {
            color = colors.transparent,
            border_color = colors.transparent,
        },
    })

    -- Add padding
    sbar.add("item", name .. ".padding", {
        position = "right",
        width = settings.group_paddings,
    })

    -- Add theme change handler (with optional background update)
    local update_background = opts.update_background_on_theme ~= false
    item:subscribe("theme_changed", function()
        local theme_update = {
            icon = { color = opts.icon_color or widget.defaults.icon_color },
            label = { color = opts.label_color or widget.defaults.label_color },
        }

        if update_background then
            theme_update.background = {
                color = colors.bg0,
                border_color = colors.bg3,
            }
        end

        item:set(theme_update)
    end)

    return item
end

return widget
