local wibox = require("wibox")
local watch = require("awful.widget.watch")

battery_widget_icon = wibox.widget {
    {
        id = "icon",
        image = os.getenv("HOME").."/.config/awesome/themes/default/icons/battery.png",
        widget = wibox.widget.imagebox,
        resize = false
    },
    layout = wibox.container.margin(battery_widget_icon, 5, 0, 5, 0),
}
battery_widget = wibox.widget.textbox()
watch(
    "acpi", 10,
    function(widget, stdout, stderr, exitreason, exitcode)
        local batteryType
        local _, status, charge_str, time = string.match(stdout, '(.+): (%a+), (%d?%d%d)%%,? ?.*')
        local charge = tonumber(charge_str)
        battery_widget:set_text(" "..charge.."%")
    end
)
