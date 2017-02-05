local wibox = require("wibox")

clock_widget = wibox.widget.textclock()
clock_widget_icon = wibox.widget {
    {
        id = "icon",
        image = os.getenv("HOME").."/.config/awesome/themes/default/icons/clock.png",
        widget = wibox.widget.imagebox,
        resize = false
    },
    layout = wibox.container.margin(clock_widget_icon, 5, 0, 5, 0),
}
