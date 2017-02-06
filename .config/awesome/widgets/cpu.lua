local wibox = require("wibox")
local icon = wibox.widget {
    {
        id = "icon",
        image = os.getenv("HOME").."/.config/awesome/themes/default/icons/cpu.png",
        widget = wibox.widget.imagebox,
        resize = false
    },
    layout = wibox.container.margin(icon, 5, 0, 5, 0),
}
local widget = wibox.widget.textbox()
local function update_widget()
    local f = io.open("/proc/cpuinfo")
    local line = f:read()
    while line do
        if line:match("cpu MHz") then
            ghz = math.floor(((string.match(line, "%d+") / 1000) * 10^1) + 0.5) / (10^1)
        end
        line = f:read()
    end
    io.close(f)
    widget:set_text(" " .. ghz .. "Ghz" .. " ")
end
update_widget()
local widget_timer = timer({ timeout = 3 })
widget_timer:connect_signal("timeout", update_widget)
widget_timer:start()
return { widget = widget, icon = icon }
