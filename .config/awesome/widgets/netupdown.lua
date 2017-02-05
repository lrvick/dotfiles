local wibox = require("wibox")
local timer = require("gears.timer")

netup_widget_icon = wibox.widget {
    {
        id = "icon",
        image = os.getenv("HOME").."/.config/awesome/themes/default/icons/netup.png",
        widget = wibox.widget.imagebox,
        resize = false
    },
    layout = wibox.container.margin(netup_widget_icon, 5, 0, 5, 0),
}
netup_widget = wibox.widget.textbox()
netdown_widget_icon = wibox.widget {
    {
        id = "icon",
        image = os.getenv("HOME").."/.config/awesome/themes/default/icons/netdown.png",
        widget = wibox.widget.imagebox,
        resize = false
    },
    layout = wibox.container.margin(netdown_widget_icon, 5, 0, 5, 0),
}
netdown_widget = wibox.widget.textbox()

local total_bytes_down
local total_bytes_up
local update_widgets = function()
    local curr_bytes_down = 0
    local curr_bytes_up = 0
    local net_up = 0
    local net_down = 0
    for line in io.lines('/proc/net/dev') do
        local device, bytes_down, bytes_up = line:match('^%s*([%w]+):%s*(%d+)%s+%d+%s+%d+%s+%d+%s+%d+%s+%d+%s+%d+%s+%d+%s+(%d+)%s')
        if device then
            curr_bytes_down = (curr_bytes_down + bytes_down) / 2
            curr_bytes_up = (curr_bytes_up + bytes_up) / 2
        end
    end
    if (total_bytes_down == nil) then
        total_bytes_down = curr_bytes_down
    end
    if (total_bytes_up == nil) then
        total_bytes_up = curr_bytes_up
    end
    local net_down = math.floor((((curr_bytes_down - total_bytes_down) / 1048576) * 10^2) + 0.5) / (10^2)
    local net_up = math.floor((((curr_bytes_up - total_bytes_up) / 1048576) * 10^2) + 0.5) / (10^2)
    total_bytes_down = curr_bytes_down
    total_bytes_up = curr_bytes_up
    netdown_widget:set_text(" " .. net_down .. "MB/s")
    netup_widget:set_text(" " .. net_up .. "MB/s")
end
update_widgets()
local net_timer = timer{timeout=2}
net_timer:connect_signal("timeout", update_widgets)
net_timer:start()
