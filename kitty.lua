-- open kitty with alt+space
return function()
  hs.hotkey.bind('alt', 'Space', function()
    local appName = 'kitty'
    local app = hs.application.get(appName)
    if not(app) then
      hs.application.open(appName)
      hs.timer.usleep(500000)
      local a = hs.application.frontmostApplication()
      local w = a:focusedWindow()
      a:hide()
      w:focus()
    elseif app:isFrontmost() then
      app:hide()
    else
      hs.application.open(appName)
    end
  end)
end
