local wibox = require("wibox")

cpu_widget_icon = wibox.widget {
    {
        id = "icon",
        image = os.getenv("HOME").."/.config/awesome/themes/default/icons/cpu.png",
        widget = wibox.widget.imagebox,
        resize = false
    },
    layout = wibox.container.margin(cpu_widget_icon, 5, 0, 5, 0),
}
cpu_widget = wibox.widget.textbox()

local function update_cpu_widget()
    local f = io.open("/proc/cpuinfo")
    local line = f:read()
    while line do
        if line:match("cpu MHz") then
            ghz = math.floor(((string.match(line, "%d+") / 1000) * 10^1) + 0.5) / (10^1)
        end
        line = f:read()
    end
    io.close(f)
    cpu_widget:set_text(" " .. ghz .. "Ghz" .. " ")
end
update_cpu_widget()
local cpu_widget_timer = timer({ timeout = 3 })
cpu_widget_timer:connect_signal("timeout", update_cpu_widget)
cpu_widget_timer:start()
