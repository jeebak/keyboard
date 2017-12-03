-------------------------------------------------------------------------------
-- /Applications/Hammerspoon.app/Contents/Resources/extensions/hs/grid
local grid = require('hs.grid');

hs.window.animationDuration = 0

-- See grids-bindings-defaults.lua
gridLayoutMode = hs.hotkey.modal.new({}, 'F17')

gridLayoutMode.entered = function()
  gridLayoutMode.statusMessage:show()
end

gridLayoutMode.exited = function()
  gridLayoutMode.statusMessage:hide()
end

-- Bind the given key to call the given function and exit GridLayout mode
function gridLayoutMode.bindWithAutomaticExit(mode, modifiers, key, fn)
  mode:bind(modifiers, key, function()
    mode:exit()
    fn()
  end)
end

gridLayoutMode:bindWithAutomaticExit({}, 'escape', function()
  gridLayoutMode:exit()
end)

local status, gridMappings = pcall(require, 'keyboard.grids-bindings')

if not status then
  gridMappings = require('keyboard.grids-bindings-defaults')
end

local modifiers = gridMappings.modifiers
local showHelp  = gridMappings.showHelp
local trigger   = gridMappings.trigger
local mappings  = gridMappings.mappings

function getModifiersStr(modifiers)
  local modMap = { shift = '⇧', ctrl = '⌃', alt = '⌥', cmd = '⌘' }
  local retVal = ''

  for i, v in ipairs(modifiers) do
    retVal = retVal .. modMap[v]
  end

  return retVal
end

local msgStr = getModifiersStr(modifiers)
msgStr = 'Grid Layout Mode (' .. msgStr .. (string.len(msgStr) > 0 and '+' or '') .. trigger .. ')'

for i, mapping in ipairs(mappings) do
  local modifiers, trigger, _grid = table.unpack(mapping)
  local hotKeyStr = getModifiersStr(modifiers)

  if showHelp == true then
    if string.len(hotKeyStr) > 0 then
      msgStr = msgStr .. (string.format('\n%15s+%s => %s', hotKeyStr, trigger, _grid))
    else
      msgStr = msgStr .. (string.format('\n%11s => %s', trigger, _grid))
    end
  end

  gridLayoutMode:bindWithAutomaticExit(modifiers, trigger, function()
    grid.setMargins('0x0').setGrid(_grid).show()
  end)
end

local message = require('keyboard.status-message')
gridLayoutMode.statusMessage = message.new(msgStr)

-- Use Hyper+trigger to toggle GridLayout Mode
hs.hotkey.bind(modifiers, trigger, function()
  gridLayoutMode:enter()
end)
gridLayoutMode:bind(modifiers, trigger, function()
  gridLayoutMode:exit()
end)
