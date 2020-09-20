-- http://zzamboni.org/post/getting-started-with-hammerspoon/
-- Installs: /usr/local/bin/hs and, makes: man hs, available
hs.ipc.cliInstall()
-------------------------------------------------------------------------------
-- http://www.hammerspoon.org/Spoons/
--  http://zzamboni.org/post/using-spoons-in-hammerspoon/
--  https://github.com/zzamboni/dot-hammerspoon/blob/master/init.lua
-------------------------------------------------------------------------------
-- http://www.hammerspoon.org/Spoons/SpoonInstall.html
hs.loadSpoon("SpoonInstall")
-------------------------------------------------------------------------------
-- http://www.hammerspoon.org/Spoons/HSKeybindings.html
-- HOTKEY: Use Hyper+m to Show MouseCircle
--  spoon.SpoonInstall:andUse("HSKeybindings",
--    {
--      disable = false,
--      hotkeys = {
--        hide = { hyper, "." },
--        show = { hyper, "/" }
--      },
--    }
--  )
-------------------------------------------------------------------------------
-- http://www.hammerspoon.org/Spoons/MicMute.html
-- HOTKEY: Use Hyper+m to toggle MicMute
-- spoon.SpoonInstall:andUse("MicMute",
--   {
--     disable = false,
--     hotkeys = {
--       bindHotkeys = { hyper, "/" }
--     },
--   }
-- )
-------------------------------------------------------------------------------
-- http://www.hammerspoon.org/Spoons/MouseCircle.html
-- HOTKEY: Use Hyper+m to Show MouseCircle
spoon.SpoonInstall:andUse("MouseCircle",
  {
    disable = false,
    config = {
      color = hs.drawing.color.x11.rebeccapurple
    },
    hotkeys = {
      show = { hyper, "m" }
    },
  }
)
-------------------------------------------------------------------------------
-- http://www.hammerspoon.org/Spoons/TextClipboardHistory.html
-- HOTKEY: Use Cmd+Shift+v to Show TextClipboardHistory
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
