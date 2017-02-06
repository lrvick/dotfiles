---------------------------
-- Default awesome theme --
---------------------------

theme = {}

theme.font          = "sans 8"

theme.wallpaper_cmd = { "nitrogen --restore" }

theme.bg_normal     = "#111111"
theme.bg_focus      = "#222222"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#444444"

theme.fg_normal     = "#aaaaaa"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.border_width  = "1"
theme.border_normal = "#222222"
theme.border_focus  = "#444444"
theme.border_marked = "#91231c"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Display the taglist squares
theme.taglist_squares_sel   = os.getenv("HOME").."/.config/awesome/themes/default/taglist/squarefw.png"
theme.taglist_squares_unsel = os.getenv("HOME").."/.config/awesome/themes/default/taglist/squarew.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = os.getenv("HOME").."/.config/awesome/themes/default/submenu.png"
theme.menu_height = 15
theme.menu_width  = 100

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = os.getenv("HOME").."/.config/awesome/themes/default/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = os.getenv("HOME").."/.config/awesome/themes/default/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = os.getenv("HOME").."/.config/awesome/themes/default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = os.getenv("HOME").."/.config/awesome/themes/default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = os.getenv("HOME").."/.config/awesome/themes/default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = os.getenv("HOME").."/.config/awesome/themes/default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = os.getenv("HOME").."/.config/awesome/themes/default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = os.getenv("HOME").."/.config/awesome/themes/default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = os.getenv("HOME").."/.config/awesome/themes/default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = os.getenv("HOME").."/.config/awesome/themes/default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = os.getenv("HOME").."/.config/awesome/themes/default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = os.getenv("HOME").."/.config/awesome/themes/default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = os.getenv("HOME").."/.config/awesome/themes/default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = os.getenv("HOME").."/.config/awesome/themes/default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = os.getenv("HOME").."/.config/awesome/themes/default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = os.getenv("HOME").."/.config/awesome/themes/default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = os.getenv("HOME").."/.config/awesome/themes/default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = os.getenv("HOME").."/.config/awesome/themes/default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = os.getenv("HOME").."/.config/awesome/themes/default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = os.getenv("HOME").."/.config/awesome/themes/default/titlebar/maximized_focus_active.png"

-- You can use your own layout icons like this:
theme.layout_fairh = os.getenv("HOME").."/.config/awesome/themes/default/layouts/fairhw.png"
theme.layout_fairv = os.getenv("HOME").."/.config/awesome/themes/default/layouts/fairvw.png"
theme.layout_floating  = os.getenv("HOME").."/.config/awesome/themes/default/layouts/floatingw.png"
theme.layout_magnifier = os.getenv("HOME").."/.config/awesome/themes/default/layouts/magnifierw.png"
theme.layout_max = os.getenv("HOME").."/.config/awesome/themes/default/layouts/maxw.png"
theme.layout_fullscreen = os.getenv("HOME").."/.config/awesome/themes/default/layouts/fullscreenw.png"
theme.layout_tilebottom = os.getenv("HOME").."/.config/awesome/themes/default/layouts/tilebottomw.png"
theme.layout_tileleft   = os.getenv("HOME").."/.config/awesome/themes/default/layouts/tileleftw.png"
theme.layout_tile = os.getenv("HOME").."/.config/awesome/themes/default/layouts/tilew.png"
theme.layout_tiletop = os.getenv("HOME").."/.config/awesome/themes/default/layouts/tiletopw.png"
theme.layout_spiral  = os.getenv("HOME").."/.config/awesome/themes/default/layouts/spiralw.png"
theme.layout_dwindle = os.getenv("HOME").."/.config/awesome/themes/default/layouts/dwindlew.png"
theme.layout_cornernw = os.getenv("HOME").."/.config/awesome/themes/default/layouts/cornernww.png"
theme.layout_cornerne = os.getenv("HOME").."/.config/awesome/themes/default/layouts/cornernew.png"
theme.layout_cornersw = os.getenv("HOME").."/.config/awesome/themes/default/layouts/cornersww.png"
theme.layout_cornerse = os.getenv("HOME").."/.config/awesome/themes/default/layouts/cornersew.png"

theme.awesome_icon = os.getenv("HOME").."/.config/awesome/icons/awesome16.png"

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
