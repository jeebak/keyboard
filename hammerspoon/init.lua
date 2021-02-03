-- local fontName = 'SauceCodePro Nerd Font Mono Light'
local hyper = {'shift', 'ctrl', 'alt', 'cmd'}
local log = hs.logger.new('init.lua', 'debug')

-- HOTKEY: Use Hyper+q to reload Hammerspoon config
hs.hotkey.bind(hyper, 'q', nil, function()
  hs.reload()
end)

keyUpDown = function(modifiers, key)
  -- Un-comment & reload config to log each keystroke that we're triggering
  -- log.d('Sending keystroke:', hs.inspect(modifiers), key)

  hs.eventtap.keyStroke(modifiers, key, 0)
end

-- Subscribe to the necessary events on the given window filter such that the
-- given hotkey is enabled for windows that match the window filter and disabled
-- for windows that don't match the window filter.
--
-- windowFilter - An hs.window.filter object describing the windows for which
--                the hotkey should be enabled.
-- hotkey       - The hs.hotkey object to enable/disable.
--
-- Returns nothing.
enableHotkeyForWindowsMatchingFilter = function(windowFilter, hotkey)
  windowFilter:subscribe(hs.window.filter.windowFocused, function()
    hotkey:enable()
  end)

  windowFilter:subscribe(hs.window.filter.windowUnfocused, function()
    hotkey:disable()
  end)
end

-------------------------------------------------------------------------------
-- /Applications/Hammerspoon.app/Contents/Resources/extensions/hs/expose
-------------------------------------------------------------------------------
-- /Applications/Hammerspoon.app/Contents/Resources/extensions/hs/hints
local hints = require('hs.hints')
hints.hintChars = {
  "A", "S", "D", "F",
  "Q", "W", "E", "R",
  "Z", "X", "C", "V",
  "T", "Y", "B",
  "Y", "H", "N",
  "U", "I", "O", "P",
  "J", "K", "L",
  "M"
}
-- hints.fontName = fontName
hints.fontSize = 24
-- hints.textColor={0.9,0.9,0.9,1}
-- HOTKEY: Use Hyper+f to show hints.windowHints
hs.hotkey.bind(hyper, 'f', hints.windowHints)
-------------------------------------------------------------------------------
-- /Applications/Hammerspoon.app/Contents/Resources/extensions/hs/mjomatic
-- local mjomatic = require('hs.mjomatic')
-------------------------------------------------------------------------------
-- /Applications/Hammerspoon.app/Contents/Resources/extensions/hs/tabs
local tabs = require('hs.tabs')
tabs.enableForApp('Code')
-------------------------------------------------------------------------------
-- /Applications/Hammerspoon.app/Contents/Resources/extensions/hs/window/highlight.lua
local hl = require('hs.window.highlight')
hl.ui.isolateColor = {0,0,0,0.85}       -- overlay color for isolate mode
hl.ui.overlayColor = {0.2,0.05,0,0.30}  -- overlay color
-- hl.ui.flashDuration = 0.3 -- too distracting
-- HOTKEY: Use Hyper+i to hl.toggleIsolate
hs.hotkey.bind(hyper, 'i', hl.toggleIsolate)
-- HOTKEY: Use Hyper+o to toggle hl.ui.overlay
hs.hotkey.bind(hyper, 'o', function() hl.ui.overlay = not hl.ui.overlay end)
hl.start()
-------------------------------------------------------------------------------
-- -- /Applications/Hammerspoon.app/Contents/Resources/extensions/hs/window/switcher.lua
-- require('hs.window.switcher')
-- hs.window.filter.ignoreAlways['Hyper'] = true
-- hs.window.filter.ignoreAlways['Terminal'] = true
-- hs.window.filter.ignoreAlways['iTerm2'] = true
-- hs.window.filter.ignoreAlways['kitty'] = true
-- hs.window.switcher.ui.fontName = fontName
-- hs.window.switcher.ui.highlightColor = {0.8,0.8,1,0.5} -- highlight color for the selected window
-- local switcher = hs.window.switcher.new(hs.window.filter.new():setCurrentSpace(true):setDefaultFilter{}) -- include minimized/hidden windows, current Space only
-- -- HOTKEY: Use Alt+tab to switch window next
-- hs.hotkey.bind('alt', 'tab', function()switcher:next()end)
-- -- HOTKEY: Use Alt+Shift+tab to switch window previous
-- hs.hotkey.bind('alt-shift', 'tab', function()switcher:previous()end)
-------------------------------------------------------------------------------
-- require('keyboard.control-escape')
-- require('keyboard.delete-words')
require('keyboard.grids')
-- require('keyboard.hyper')
-- require('keyboard.markdown')
-- require('keyboard.microphone')
require('keyboard.mic-muter')
require('keyboard.oh-snap')
-- require('keyboard.panes')
require('keyboard.spoons')
require('keyboard.windows')

hs.notify.new({title='Hammerspoon', informativeText='Ready to rock 🤘'}):send()
