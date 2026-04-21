local windowMargin = 24
local minWindowWidth = 500
local minWindowHeight = 320
local screenChangeDelay = 1.0
local lastScreenCount = #hs.screen.allScreens()

hs.ipc.cliInstall()

local function clamp(value, minValue, maxValue)
  if value < minValue then
    return minValue
  end
  if value > maxValue then
    return maxValue
  end
  return value
end

local function shouldManage(win)
  if not win then
    return false
  end

  if not win:isStandard() then
    return false
  end

  local app = win:application()
  if not app then
    return false
  end

  return true
end

local function fitWindowToScreen(win, screen)
  local screenFrame = screen:frame()
  local frame = win:frame()

  local maxWidth = math.max(minWindowWidth, screenFrame.w - (windowMargin * 2))
  local maxHeight = math.max(minWindowHeight, screenFrame.h - (windowMargin * 2))

  local needsResize =
    frame.w > maxWidth or
    frame.h > maxHeight or
    frame.x < screenFrame.x or
    frame.y < screenFrame.y or
    (frame.x + frame.w) > (screenFrame.x + screenFrame.w) or
    (frame.y + frame.h) > (screenFrame.y + screenFrame.h)

  if not needsResize then
    return false
  end

  local newWidth = math.min(frame.w, maxWidth)
  local newHeight = math.min(frame.h, maxHeight)

  local minX = screenFrame.x + windowMargin
  local minY = screenFrame.y + windowMargin
  local maxX = screenFrame.x + screenFrame.w - newWidth - windowMargin
  local maxY = screenFrame.y + screenFrame.h - newHeight - windowMargin

  local newX = clamp(frame.x, minX, maxX)
  local newY = clamp(frame.y, minY, maxY)

  win:setFrame(hs.geometry.rect(newX, newY, newWidth, newHeight), 0)
  return true
end

local function normalizeWindowsToMainScreen()
  local targetScreen = hs.screen.mainScreen()
  if not targetScreen then
    return
  end

  local managedCount = 0
  for _, win in ipairs(hs.window.visibleWindows()) do
    if shouldManage(win) then
      local ok = pcall(function()
        win:moveToScreen(targetScreen, false, true, 0)
        fitWindowToScreen(win, targetScreen)
      end)

      if ok then
        managedCount = managedCount + 1
      end
    end
  end

  hs.alert.show(string.format("Fitted %d windows to %s", managedCount, targetScreen:name() or "main display"))
end

local screenWatcher = hs.screen.watcher.new(function()
  local currentScreenCount = #hs.screen.allScreens()
  if currentScreenCount < lastScreenCount then
    hs.timer.doAfter(screenChangeDelay, normalizeWindowsToMainScreen)
  end
  lastScreenCount = currentScreenCount
end)

screenWatcher:start()

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "return", normalizeWindowsToMainScreen)
