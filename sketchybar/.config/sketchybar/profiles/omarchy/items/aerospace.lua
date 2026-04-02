local colors = require("profiles.omarchy.colors")
local settings = require("settings")

local query_workspaces = "aerospace list-workspaces --all --format '%{workspace}'"
local query_focused = "aerospace list-workspaces --focused"

local workspace_items = {}
local left_segment

local function set_workspace_focus(workspace_id)
    for id, item in pairs(workspace_items) do
        local selected = tostring(id) == tostring(workspace_id)
        item:set({
            icon = {
                color = selected and colors.fg or colors.fg_muted,
                highlight = false,
            },
            label = {
                color = selected and colors.fg or colors.fg_muted,
            },
        })
    end
end

sbar.exec(query_workspaces, function(workspaces_raw)
    local workspace_order = {}
    for id in string.gmatch(workspaces_raw, "[^\r\n]+") do
        table.insert(workspace_order, id)
    end

    table.sort(workspace_order, function(a, b)
        local a_num = tonumber(a)
        local b_num = tonumber(b)
        if a_num and b_num then
            return a_num < b_num
        end
        return tostring(a) < tostring(b)
    end)

    for _, id in ipairs(workspace_order) do
        local is_last = id == workspace_order[#workspace_order]
        local item = sbar.add("item", "omarchy.space." .. id, {
            position = "left",
            icon = {
                string = id,
                color = colors.fg_muted,
                font = {
                    family = settings.font.numbers,
                    style = settings.font.style_map["Regular"],
                    size = 13.0,
                },
            },
            label = { drawing = false },
            click_script = "aerospace workspace " .. id,
            padding_left = 6,
            padding_right = is_last and 10 or 6,
        })

        workspace_items[id] = item

        item:subscribe("aerospace_workspace_change", function(env)
            set_workspace_focus(env.FOCUSED_WORKSPACE)
        end)
    end

    local left_items = { "omarchy.apple" }
    for _, id in ipairs(workspace_order) do
        table.insert(left_items, workspace_items[id].name)
    end

    left_segment = sbar.add("bracket", "omarchy.segment.left", left_items, {
        background = {
            drawing = true,
            color = colors.bg,
            border_color = colors.border,
            border_width = 1,
            corner_radius = 10,
            height = 30,
        },
    })

    sbar.exec(query_focused, function(focused_workspace)
        set_workspace_focus(focused_workspace:gsub("%s+", ""))
    end)
end)
