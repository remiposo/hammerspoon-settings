-- switch eisuu and kana with cmd
local function switchWithCmd()
  local keyWithCmd = false
  local leftCmd    = 0x37
  local rightCmd   = 0x36
  local eisuu      = 0x66
  local kana       = 0x68

  hs.eventtap.new({hs.eventtap.event.types.keyDown, hs.eventtap.event.types.flagsChanged}, function (event)
    local t = event:getType()
    local f = event:getFlags()
    local c = event:getKeyCode()

    if t == hs.eventtap.event.types.keyDown then
      if f['cmd'] then
        keyWithCmd = true
      end
    elseif t == hs.eventtap.event.types.flagsChanged then
      if f['cmd'] then return end
      if not(keyWithCmd) then
        if c == leftCmd then
          hs.eventtap.keyStroke({}, eisuu, 5000)
        elseif c == rightCmd then
          hs.eventtap.keyStroke({}, kana, 5000)
        end
      end
      keyWithCmd = false
    end
  end):start()
end

-- enter esc after ctrl+[
local function switchWithEsc()
  local leftBracket = 0x21
  local eisuu      = 0x66

  hs.eventtap.new({hs.eventtap.event.types.keyDown}, function (event)
    local f = event:getFlags()
    local c = event:getKeyCode()

    if f['ctrl'] and c == leftBracket then
      hs.eventtap.keyStroke({}, eisuu, 5000)
    end
  end):start()
end

return function()
  switchWithCmd()
  switchWithEsc()
end
