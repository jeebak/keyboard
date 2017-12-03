-- Default keybindings for Grids Mode
--
-- To customize the key bindings for Grids Mode, create a copy of this file,
-- save it as `grids-bindings.lua`, and edit the table below to configure your
-- preferred shortcuts.

local hyper = {'shift', 'ctrl', 'alt', 'cmd'}
-- HOTKEY: Use Hyper+g to trigger Grids Mode
return {
  modifiers = hyper,
  showHelp  = true,
  trigger   = 'g',
  mappings  = {
    { {},     'j',  '9x4' },
    { {},     'k',  '9x3' },
    { {},     'l',  '8x4' },
    { {},     ';',  '8x3' },

    { hyper,  'j',  '9x4' },
    { hyper,  'k',  '9x3' },
    { hyper,  'l',  '8x4' },
    { hyper,  ';',  '8x3' },
  }
}
