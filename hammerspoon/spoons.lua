-- http://zzamboni.org/post/getting-started-with-hammerspoon/
-- Installs: /usr/local/bin/hs and, makes: man hs, available
hs.ipc.cliInstall()
-------------------------------------------------------------------------------
-- http://www.hammerspoon.org/Spoons/
--  http://zzamboni.org/post/using-spoons-in-hammerspoon/
--  https://github.com/zzamboni/dot-hammerspoon/blob/master/init.lua
-------------------------------------------------------------------------------
-- https://github.com/Hammerspoon/Spoons/raw/master/Spoons/SpoonInstall.spoon.zip
--  http://www.hammerspoon.org/Spoons/SpoonInstall.html
hs.loadSpoon("SpoonInstall")
-------------------------------------------------------------------------------
-- https://github.com/Hammerspoon/Spoons/raw/master/Spoons/MouseCircle.spoon.zip
--  http://www.hammerspoon.org/Spoons/MouseCircle.html
spoon.SpoonInstall:andUse("MouseCircle",
  {
    disable = false,
    config = {
      color = hs.drawing.color.x11.rebeccapurple
    },
    hotkeys = {
      show = { hyper, "m" }
    }
  }
)
-------------------------------------------------------------------------------
-- https://github.com/Hammerspoon/Spoons/raw/master/Spoons/TextClipboardHistory.spoon.zip
--  http://www.hammerspoon.org/Spoons/TextClipboardHistory.html
spoon.SpoonInstall:andUse("TextClipboardHistory",
  {
    config = {
      show_in_menubar = true,
    },
    hotkeys = {
      toggle_clipboard = { { "cmd", "shift" }, "v" }
    },
    start = true,
  }
)
