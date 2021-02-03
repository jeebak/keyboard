hyper = {'shift', 'ctrl', 'alt', 'cmd'}

-- https://medium.com/@robhowlett/hammerspoon-the-best-mac-software-youve-never-heard-of-40c2df6db0f8

micMuteStatusMenu = hs.menubar.new()
micMuteStatusLine = nil

function displayMicMuteStatus()
  local currentAudioInput = hs.audiodevice.current(true)
  local currentAudioInputObject = hs.audiodevice.findInputByUID(currentAudioInput.uid)

  muted = currentAudioInputObject:inputMuted()

  if muted then
    micMuteStatusMenu:setIcon(os.getenv("HOME") .. "/.hammerspoon/muted.png")
    micMuteStatusLineColor = {["red"]=1,["blue"]=0,["green"]=0,["alpha"]=0.7}
  else
    micMuteStatusMenu:setIcon(os.getenv("HOME") .. "/.hammerspoon/unmuted.png")
    micMuteStatusLineColor = {["red"]=1,["blue"]=0,["green"]=1,["alpha"]=0.7}
  end

  if micMuteStatusLine then
    micMuteStatusLine:delete()
  end

  max = hs.screen.primaryScreen():fullFrame()
  micMuteStatusLine = hs.drawing.rectangle(hs.geometry.rect(max.x, max.y, max.w, max.h))
  micMuteStatusLine:setStrokeColor(micMuteStatusLineColor)
  micMuteStatusLine:setFillColor(micMuteStatusLineColor)
  micMuteStatusLine:setFill(false)
  micMuteStatusLine:setStrokeWidth(30)
  micMuteStatusLine:show()
end

for i,dev in ipairs(hs.audiodevice.allInputDevices()) do
  dev:watcherCallback(displayMicMuteStatus):watcherStart()
end

function toggleMicMuteStatus()
  local currentAudioInput = hs.audiodevice.current(true)
  local currentAudioInputObject = hs.audiodevice.findInputByUID(currentAudioInput.uid)
  currentAudioInputObject:setInputMuted(not muted)
  displayMicMuteStatus()
end

displayMicMuteStatus()

hs.hotkey.bind(hyper, "m", toggleMicMuteStatus)

micMuteStatusMenu:setClickCallback(toggleMicMuteStatus)

function toggleMicMuteStatusAlert()
  if micMuteStatusAlert then
    micMuteStatusAlert = false
    micMuteStatusLine:delete()
  else
    micMuteStatusAlert = true
    displayMicMuteStatus()
  end
end

-- “Um, wouldn’t it be cool if I could make the big border around my screen disappear again”
-- Ah yes, yes it would:

function clearScreen()
  if micMuteStatusLine then
    micMuteStatusLine:delete()
  end
end
hs.hotkey.bind(hyper, "n", clearScreen)
