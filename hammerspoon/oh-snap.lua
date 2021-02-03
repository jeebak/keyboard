local grid_mod1 = {"shift", "ctrl", "alt"}
local grid_mod2 = {"shift", "ctrl", "cmd"}
local grid_mappings = {
  --  3 Rows                3 Columns
  --  +-----------------+   +-----+-----+-----+
  --  |        7        |   |     |     |     |
  --  +-----------------+   |     |     |     |
  --  |        8        |   |  y  |  h  |  n  |
  --  +-----------------+   |     |     |     |
  --  |        9        |   |     |     |     |
  --  +-----------------+   +-----+-----+-----+
  {grid_mod1, "7", "1x3", {x=0, y=0, w=1, h=1}},
  {grid_mod1, "8", "1x3", {x=0, y=1, w=1, h=1}},
  {grid_mod1, "9", "1x3", {x=0, y=2, w=1, h=1}},
  {grid_mod1, "y", "3x1", {x=0, y=0, w=1, h=1}},
  {grid_mod1, "h", "3x1", {x=1, y=0, w=1, h=1}},
  {grid_mod1, "n", "3x1", {x=2, y=0, w=1, h=1}},

  --  2 Rows                2 Columns
  --  +-----------------+   +--------+--------+
  --  |        i        |   |        |        |
  --  |                 |   |        |        |
  --  +-----------------+   |   j    |   l    |
  --  |        k        |   |        |        |
  --  |                 |   |        |        |
  --  +-----------------+   +--------+--------+
  {grid_mod1, "i", "1x2", {x=0, y=0, w=1, h=1}},
  {grid_mod1, "k", "1x2", {x=0, y=1, w=1, h=1}},
  {grid_mod1, "j", "2x1", {x=0, y=0, w=1, h=1}},
  {grid_mod1, "l", "2x1", {x=1, y=0, w=1, h=1}},

  --  4 Corners
  --  +--------+--------+
  --  |   u    |   o    |
  --  |        |        |
  --  +--------+--------+
  --  |   m    |   .    |
  --  |        |        |
  --  +--------+--------+
  {grid_mod1, "u", "2x2", {x=0, y=0, w=1, h=1}},
  {grid_mod1, "o", "2x2", {x=1, y=0, w=1, h=1}},
  {grid_mod1, "m", "2x2", {x=0, y=1, w=1, h=1}},
  {grid_mod1, ".", "2x2", {x=1, y=1, w=1, h=1}},

  --  Center
  --  +-----------------+
  --  |                 |
  --  |  +-----------+  |
  --  |  |     ,     |  |
  --  |  +-----------+  |
  --  |                 |
  --  +-----------------+
  {grid_mod1, ",", "9x9", {x=2, y=1, w=5, h=7}},

  --  3 Columns (Top/Bottom)
  --  +-----+-----+-----+
  --  |  j  |  k  |  l  |
  --  |     |     |     |
  --  +-----+-----+-----+
  --  |  m  |  ,  |  .  |
  --  |     |     |     |
  --  +-----+-----+-----+
  {grid_mod2, "j", "3x2", {x=0, y=0, w=1, h=1}},
  {grid_mod2, "k", "3x2", {x=1, y=0, w=1, h=1}},
  {grid_mod2, "l", "3x2", {x=2, y=0, w=1, h=1}},
  {grid_mod2, "m", "3x2", {x=0, y=1, w=1, h=1}},
  {grid_mod2, ",", "3x2", {x=1, y=1, w=1, h=1}},
  {grid_mod2, ".", "3x2", {x=2, y=1, w=1, h=1}},

  --  4 Columns
  --  +----+---+---+----+
  --  |    |   |   |    |
  --  |    |   |   |    |
  --  | u  | i | o | p  |
  --  |    |   |   |    |
  --  |    |   |   |    |
  --  +----+---+---+----+
  {grid_mod2, "u", "4x1", {x=0, y=0, w=1, h=1}},
  {grid_mod2, "i", "4x1", {x=1, y=0, w=1, h=1}},
  {grid_mod2, "o", "4x1", {x=2, y=0, w=1, h=1}},
  {grid_mod2, "p", "4x1", {x=3, y=0, w=1, h=1}},
}

for _, grid_mapping in ipairs(grid_mappings) do
  local _modifier, _trigger, _grid, _cell = table.unpack(grid_mapping)

  hs.hotkey.bind(_modifier, _trigger, function()
    local _win = hs.window.focusedWindow()
    hs.grid
      .setMargins("0x0")
      .setGrid(_grid)
      .set(_win, _cell, _win:screen())
      .snap(_win)
  end)
end

-- Maximize Window
hs.hotkey.bind(grid_mod1, ";", function()
  local win = hs.window.focusedWindow()
  hs.grid.maximizeWindow(win)
end)

-- Lock Screen
hs.hotkey.bind(grid_mod1, "tab", function()
  hs.caffeinate.lockScreen()
end)

-- Open "Finder"
hs.hotkey.bind(grid_mod1, "p", function()
  return hs.osascript.applescript([[
    tell application "Finder"
      activate
      if (count windows) is 0 then make new Finder window
    end tell
  ]])
end)

-- Current Width and Position Snapped Up/Down

-- https://stackoverflow.com/questions/46818712/using-hammerspoon-and-the-spaces-module-to-move-window-to-new-space
function moveWindowOneSpace(direction)
  local keyCode = direction == "left" and 123 or 124

  return hs.osascript.applescript([[
    tell application "System Events"
        keystroke (key code ]] .. keyCode .. [[ using control down)
    end tell
  ]])
end

--[[
hs.hotkey.bind(dyper, "8", function()
  moveWindowOneSpace("left")
end)

hs.hotkey.bind(dyper, "9", function()
  moveWindowOneSpace("right")
end)
]]--
