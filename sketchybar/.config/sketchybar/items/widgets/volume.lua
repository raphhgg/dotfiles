local colors = require("colors")
local icons = require("icons")
local widget = require("helpers.widget")

local popup_width = 250

-- Create base volume widget
local volume = widget.new("widgets.volume", {
	icon = icons.volume._100,
	label = "??%",
	update_background_on_theme = false,
})

local volume_slider = sbar.add("slider", popup_width, {
	position = "popup." .. volume.name .. ".bracket",
	slider = {
		highlight_color = colors.blue,
		background = {
			height = 6,
			corner_radius = 3,
			color = colors.bg2,
		},
		knob = {
			string = "􀀁",
			drawing = true,
		},
	},
	background = { color = colors.bg1, height = 2, y_offset = -20 },
	click_script = 'osascript -e "set volume output volume $PERCENTAGE"',
})

volume:subscribe("volume_change", function(env)
	local volume_value = tonumber(env.INFO)
	local icon = icons.volume._0
	if volume_value > 60 then
		icon = icons.volume._100
	elseif volume_value > 30 then
		icon = icons.volume._66
	elseif volume_value > 10 then
		icon = icons.volume._33
	elseif volume_value > 0 then
		icon = icons.volume._10
	end

	local lead = ""
	if volume_value < 10 then
		lead = "0"
	end

	volume:set({
		icon = { string = icon },
		label = { string = lead .. volume_value .. "%" }
	})
	volume_slider:set({ slider = { percentage = volume_value } })
end)

local function volume_collapse_details()
	local bracket_name = volume.name .. ".bracket"
	local drawing = sbar.query(bracket_name).popup.drawing == "on"
	if not drawing then
		return
	end
	sbar.set(bracket_name, { popup = { drawing = false } })
	sbar.remove("/volume.device\\.*/")
end

local current_audio_device = "None"
local function volume_toggle_details(env)
	if env.BUTTON == "right" then
		sbar.exec("open /System/Library/PreferencePanes/Sound.prefpane")
		return
	end

	local bracket_name = volume.name .. ".bracket"
	local should_draw = sbar.query(bracket_name).popup.drawing == "off"
	if should_draw then
		sbar.set(bracket_name, { popup = { drawing = true } })
		sbar.exec("SwitchAudioSource -t output -c", function(result)
			current_audio_device = result:sub(1, -2)
			sbar.exec("SwitchAudioSource -a -t output", function(available)
				current = current_audio_device
				local color = colors.overlay0
				local counter = 0

				for device in string.gmatch(available, "[^\r\n]+") do
					local color = colors.overlay0
					if current == device then
						color = colors.text
					end
					sbar.add("item", "volume.device." .. counter, {
						position = "popup." .. bracket_name,
						width = popup_width,
						align = "center",
						label = { string = device, color = color },
						click_script = 'SwitchAudioSource -s "'
							.. device
							.. '" && sketchybar --set /volume.device\\.*/ label.color='
							.. colors.overlay0
							.. " --set $NAME label.color="
							.. colors.text,
					})
					counter = counter + 1
				end
			end)
		end)
	else
		volume_collapse_details()
	end
end

local function volume_scroll(env)
	local delta = env.INFO.delta
	if not (env.INFO.modifier == "ctrl") then
		delta = delta * 10.0
	end

	sbar.exec('osascript -e "set volume output volume (output volume of (get volume settings) + ' .. delta .. ')"')
end

volume:subscribe("mouse.clicked", volume_toggle_details)
volume:subscribe("mouse.scrolled", volume_scroll)
volume:subscribe("mouse.exited.global", volume_collapse_details)
