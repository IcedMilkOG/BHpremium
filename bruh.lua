--[[
  BigHookUI (bighook | kel.tec)
  -------------------------------------------------------
  Human-written Luau ModuleScript UI library
  - Tabs (Top/Bottom/Left/Right)
  - 3 columns per tab
  - Section boxes
  - Toggle / Slider / Dropdown / ColorPicker (rainbow + speed)
  - Draggable floating button (mobile touch friendly)
  - Background modes: "pixel_gradient" (low opacity) and "stars" (animated)
  - No exploit-specific features. Safe for Roblox Studio + Mobile.
  Author: kel.tec (bighook)
  License: MIT
--]]

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer

local BigHookUI = {}
BigHookUI.__index = BigHookUI

-- Theme
local Theme = {
    Base       = Color3.fromRGB(7, 20, 27),
    LightBase  = Color3.fromRGB(12, 40, 46),
    Accent     = Color3.fromRGB(0, 198, 160),
    AccentDim  = Color3.fromRGB(0, 150, 120),
    Text       = Color3.fromRGB(230, 240, 245),
    SubText    = Color3.fromRGB(170, 190, 196),
    Section    = Color3.fromRGB(12, 30, 34),
    SectionBorder = Color3.fromRGB(24, 60, 66),
}

-- small helpers
local function mk(class, props, children)
    local obj = Instance.new(class)
    if props then for k,v in pairs(props) do obj[k] = v end end
    if children then for _,c in ipairs(children) do c.Parent = obj end end
    return obj
end

local function makeCorner(radius)
    return mk("UICorner", { CornerRadius = UDim.new(0, radius) })
end

local function makeStroke(thickness, color, transparency)
    return mk("UIStroke", { Thickness = thickness or 1, Color = color or Theme.SectionBorder, Transparency = transparency or 0 })
end

-- Pixel background generation (grid of small frames)
local function createPixelGradientFrame(parent, sizePxX, sizePxY, opacity, paletteFn)
    -- sizePxX, sizePxY: number of pixel columns/rows
    -- paletteFn: function(xFrac,yFrac) -> Color3
    local container = mk("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        AnchorPoint = Vector2.new(0, 0)
    }, {})
    container.ClipsDescendants = true
    container.Parent = parent

    -- create grid
    local cellW = parent.AbsoluteSize.X / sizePxX
    local cellH = parent.AbsoluteSize.Y / sizePxY

    -- We'll create using UIListLayouts would be messy due to resizing; instead create absolute-positioned cells and update on resize
    local cells = {}

    local function rebuild()
        -- remove existing
        for _,c in ipairs(cells) do if c and c.Parent then c:Destroy() end end
        cells = {}
        local abs = parent.AbsoluteSize
        local cw = (abs.X / sizePxX)
        local ch = (abs.Y / sizePxY)
        for y=0, sizePxY-1 do
            for x=0, sizePxX-1 do
                local xf = (x / (sizePxX-1))
                local yf = (y / (sizePxY-1))
                local color = paletteFn(xf, yf)
                local cell = mk("Frame", {
                    BackgroundColor3 = color,
                    BorderSizePixel = 0,
                    Size = UDim2.new(0, math.max(1, math.floor(cw+0.5)), 0, math.max(1, math.floor(ch+0.5))),
                    Position = UDim2.new(0, math.floor(x * cw), 0, math.floor(y * ch)),
                    BackgroundTransparency = math.clamp(1 - (opacity or 0.2), 0, 1)
                }, {})
                cell.Parent = container
                cells[#cells+1] = cell
            end
        end
    end

    -- initial build (may be zero size until parent AbsoluteSize available)
    if parent.AbsoluteSize.X > 0 then
        rebuild()
    end

    -- keep in sync when resized
    parent:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() rebuild() end)

    return container, function() for _,c in ipairs(cells) do if c and c.Parent then c:Destroy() end end end
end

-- Stars background: animated small frames moving slowly (parallax)
local function createStarsFrame(parent, numStars, speedRange, color, alpha)
    local container = mk("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
    }, {})
    container.Parent = parent

    local stars = {}
    local rand = Random.new(tick() % 2^31)

    local function spawnStar()
        local size = rand:NextNumber(1, 3)
        local x = rand:NextNumber(0, parent.AbsoluteSize.X)
        local y = rand:NextNumber(0, parent.AbsoluteSize.Y)
        local star = mk("Frame", {
            BackgroundColor3 = color or Color3.new(1,1,1),
            Size = UDim2.new(0, size, 0, size),
            Position = UDim2.new(0, x, 0, y),
            BorderSizePixel = 0,
            BackgroundTransparency = alpha or 0.85,
        }, {})
        makeCorner(1).Parent = star
        star.Parent = container
        return star
    end

    local function init()
        for i=1,numStars do
            local s = spawnStar()
            stars[#stars+1] = {inst=s, speed=rand:NextNumber(speedRange[1], speedRange[2])}
        end
    end

    local animConn
    animConn = RunService.RenderStepped:Connect(function(dt)
        if not parent or not parent.Parent then
            animConn:Disconnect()
            return
        end
        for i=#stars,1,-1 do
            local rec = stars[i]
            if not rec.inst or not rec.inst.Parent then
                table.remove(stars, i)
            else
                local pos = rec.inst.Position
                local newX = pos.X.Offset + dt * rec.speed
                if newX > parent.AbsoluteSize.X then
                    -- recycle left
                    newX = -5
                    rec.inst.Position = UDim2.new(0, newX, 0, math.random(0,parent.AbsoluteSize.Y))
                else
                    rec.inst.Position = UDim2.new(0, newX, 0, pos.Y.Offset)
                end
            end
        end
    end)

    parent:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
        -- respawn stars
        for _,rec in ipairs(stars) do if rec.inst and rec.inst.Parent then rec.inst:Destroy() end end
        stars = {}
        init()
    end)

    init()
    return container, function() animConn:Disconnect(); container:Destroy() end
end

-- Core constructor
function BigHookUI.new(opts)
    opts = opts or {}
    local self = setmetatable({}, BigHookUI)
    self._tabs = {}
    self._rainbowConnections = {}
    self._backgroundCleanup = nil

    local title = opts.title or "bighook | kel.tec"
    local tabPlacement = string.lower(opts.tabPlacement or "top") -- top/bottom/left/right

    -- ScreenGui
    local gui = mk("ScreenGui", { Name = "BigHookUI", ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling, IgnoreGuiInset = true }, {})
    gui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    self.Gui = gui

    -- Root window
    local root = mk("Frame", {
        Name = "Window",
        Size = UDim2.new(0, 900, 0, 520),
        Position = UDim2.new(0.5, -450, 0.5, -260),
        BackgroundColor3 = Theme.Base,
        BorderSizePixel = 0,
    }, {})
    root.Parent = gui
    makeCorner(8).Parent = root
    makeStroke(1, Theme.SectionBorder, 0.2).Parent = root

    -- Title bar
    local titleBar = mk("Frame", { Size = UDim2.new(1,0,0,40), BackgroundColor3 = Theme.LightBase, BorderSizePixel = 0 }, {})
    titleBar.Parent = root
    makeCorner(8).Parent = titleBar
    makeStroke(1, Theme.SectionBorder, 0.15).Parent = titleBar

    local titleLbl = mk("TextLabel", {
        Text = title,
        BackgroundTransparency = 1,
        TextColor3 = Theme.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 16,
        Size = UDim2.new(1,-140,1,0),
        Position = UDim2.new(0,12,0,0),
        TextXAlignment = Enum.TextXAlignment.Left
    }, {})
    titleLbl.Parent = titleBar

    -- container for rail & content
    local rail = mk("Frame", { BackgroundTransparency = 1, BorderSizePixel = 0 }, {})
    local content = mk("Frame", { BackgroundTransparency = 1, BorderSizePixel = 0 }, {})
    rail.Parent = root; content.Parent = root

    -- configure placement
    local railSize = 48
    if tabPlacement == "top" then
        rail.Size = UDim2.new(1, -24, 0, railSize)
        rail.Position = UDim2.new(0, 12, 0, 40)
        content.Position = UDim2.new(0, 12, 0, 40 + railSize + 12)
        content.Size = UDim2.new(1, -24, 1, -(40 + railSize + 24))
    elseif tabPlacement == "bottom" then
        content.Position = UDim2.new(0, 12, 0, 40)
        content.Size = UDim2.new(1, -24, 1, -(40 + railSize + 24))
        rail.Size = UDim2.new(1, -24, 0, railSize)
        rail.Position = UDim2.new(0, 12, 1, -railSize - 12)
    elseif tabPlacement == "left" then
        rail.Size = UDim2.new(0, 140, 1, -(40 + 24))
        rail.Position = UDim2.new(0, 12, 0, 40 + 12)
        content.Position = UDim2.new(0, 12 + 140 + 12, 0, 40 + 12)
        content.Size = UDim2.new(1, -(12 + 140 + 24), 1, -(40 + 24))
    else -- right
        rail.Size = UDim2.new(0, 140, 1, -(40 + 24))
        rail.Position = UDim2.new(1, -140 - 12, 0, 40 + 12)
        content.Position = UDim2.new(0, 12, 0, 40 + 12)
        content.Size = UDim2.new(1, -(12 + 140 + 24), 1, -(40 + 24))
    end

    -- rail layout
    local railLayout = mk("UIListLayout", { FillDirection = (tabPlacement=="left" or tabPlacement=="right") and Enum.FillDirection.Vertical or Enum.FillDirection.Horizontal, Padding = UDim.new(0, 8) }, {})
    railLayout.Parent = rail

    -- floating toggle button (draggable)
    local floater = mk("TextButton", {
        Name = "Floater",
        Text = "≡",
        Font = Enum.Font.GothamBlack,
        TextSize = 18,
        Size = UDim2.new(0, 46, 0, 46),
        Position = UDim2.new(0, 12, 0, 12),
        BackgroundColor3 = Theme.Accent,
        TextColor3 = Theme.Text,
        BorderSizePixel = 0,
        AutoButtonColor = false
    }, {})
    floater.Parent = gui
    makeCorner(24).Parent = floater
    makeStroke(1, Theme.SectionBorder, 0.2).Parent = floater

    local dragging, dragStart, startPos
    floater.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = floater.Position
        end
    end)
    floater.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if not dragging then return end
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            local delta = input.Position - dragStart
            floater.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    floater.MouseButton1Click:Connect(function()
        root.Visible = not root.Visible
    end)

    -- drag window by title bar (touch-friendly)
    do
        local winDrag, ws, startP
        titleBar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                winDrag = true
                ws = input.Position
                startP = root.Position
            end
        end)
        titleBar.InputEnded:Connect(function(input)
            winDrag = false
        end)
        UserInputService.InputChanged:Connect(function(input)
            if not winDrag then return end
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                local d = input.Position - ws
                root.Position = UDim2.new(startP.X.Scale, startP.X.Offset + d.X, startP.Y.Scale, startP.Y.Offset + d.Y)
            end
        end)
    end

    -- store
    self.Gui = gui
    self.Root = root
    self.Rail = rail
    self.Content = content
    self.TitleLabel = titleLbl
    self.Floater = floater
    self.TabPlacement = tabPlacement

    return self
end

-- Create a tab with 3 columns
function BigHookUI:CreateTab(name)
    name = tostring(name or "Tab")
    local btn = mk("TextButton", {
        Text = name,
        BackgroundColor3 = Theme.LightBase,
        TextColor3 = Theme.Text,
        Font = Enum.Font.GothamSemibold,
        TextSize = 14,
        BorderSizePixel = 0,
        Size = (self.TabPlacement == "top" or self.TabPlacement == "bottom") and UDim2.new(0,160,1,0) or UDim2.new(1,0,0,40),
        AutoButtonColor = false
    }, {})
    btn.Parent = self.Rail
    makeCorner(6).Parent = btn
    makeStroke(1, Theme.SectionBorder, 0.12).Parent = btn

    local page = mk("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, 0), Visible = false }, {})
    page.Parent = self.Content

    -- create three columns
    local columns = {}
    for i=1,3 do
        local col = mk("Frame", {
            BackgroundTransparency = 1,
            Size = UDim2.new(1/3, -10, 1, 0),
        }, {})
        col.Parent = page
        if i > 1 then col.Position = UDim2.new((i-1)/3 + 0.01, 0, 0, 0) end

        local layout = mk("UIListLayout", { FillDirection = Enum.FillDirection.Vertical, Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder }, {})
        layout.Parent = col
        columns[i] = col
    end

    local tab = { Button = btn, Page = page, Columns = columns, Sections = {} }
    table.insert(self._tabs, tab)

    local function select()
        for _,t in ipairs(self._tabs) do
            t.Page.Visible = (t == tab)
            t.Button.BackgroundColor3 = (t == tab) and Theme.AccentDim or Theme.LightBase
        end
    end
    btn.MouseButton1Click:Connect(select)
    if #self._tabs == 1 then select() end

    -- Section helper
    function tab:AddSection(title, column)
        local colIndex = math.clamp(tonumber(column) or 1, 1, 3)
        local parent = columns[colIndex]

        local section = mk("Frame", {
            BackgroundColor3 = Theme.Section,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y
        }, {})
        section.Parent = parent
        makeCorner(8).Parent = section
        makeStroke(1, Theme.SectionBorder, 0.24).Parent = section

        local header = mk("TextLabel", {
            Text = tostring(title or "section"),
            BackgroundTransparency = 1,
            TextColor3 = Theme.SubText,
            Font = Enum.Font.GothamBold,
            TextSize = 14,
            Size = UDim2.new(1, -12, 0, 24),
            Position = UDim2.new(0, 8, 0, 6),
            TextXAlignment = Enum.TextXAlignment.Left
        }, {})
        header.Parent = section

        local padding = mk("UIPadding", { PaddingTop = UDim.new(0, 32), PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8), PaddingBottom = UDim.new(0, 8) }, {})
        padding.Parent = section

        local list = mk("UIListLayout", { FillDirection = Enum.FillDirection.Vertical, Padding = UDim.new(0, 6) }, {})
        list.Parent = section

        local s = { _parent = section }

        -- Toggle widget
        function s:Toggle(opts)
            opts = opts or {}
            local state = opts.default and true or false

            local row = mk("Frame", { Size = UDim2.new(1,0,0,28), BackgroundTransparency = 1 }, {})
            row.Parent = section

            local label = mk("TextLabel", {
                Text = tostring(opts.text or "toggle"),
                BackgroundTransparency = 1,
                TextColor3 = Theme.Text,
                Font = Enum.Font.Gotham,
                TextSize = 14,
                Size = UDim2.new(1, -36, 1, 0),
                TextXAlignment = Enum.TextXAlignment.Left
            }, {})
            label.Parent = row

            local btn = mk("TextButton", {
                Size = UDim2.new(0, 26, 0, 20),
                Position = UDim2.new(1, -30, 0.5, -10),
                BackgroundColor3 = state and Theme.Accent or Theme.LightBase,
                BorderSizePixel = 0,
                AutoButtonColor = false,
                Text = ""
            }, {})
            makeCorner(6).Parent = btn
            makeStroke(1, Theme.SectionBorder, 0.15).Parent = btn
            btn.Parent = row

            local function set(v)
                state = not not v
                btn.BackgroundColor3 = state and Theme.Accent or Theme.LightBase
                if opts.callback then task.spawn(opts.callback, state) end
            end

            btn.MouseButton1Click:Connect(function() set(not state) end)
            -- touch whole row
            row.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.Touch then set(not state) end end)

            set(state)
            return { Set = set, Get = function() return state end }
        end

        -- Slider widget
        function s:Slider(opts)
            opts = opts or {}
            local min = tonumber(opts.min) or 0
            local max = tonumber(opts.max) or 100
            local step = opts.step or 1
            local val = math.clamp(tonumber(opts.default) or min, min, max)

            local row = mk("Frame", { Size = UDim2.new(1, 0, 0, 46), BackgroundTransparency = 1 }, {})
            row.Parent = section

            local label = mk("TextLabel", {
                Text = tostring(opts.text or "slider") .. " - " .. tostring(val),
                BackgroundTransparency = 1, TextColor3 = Theme.Text,
                Font = Enum.Font.Gotham, TextSize = 14, Size = UDim2.new(1,0,0,18),
                TextXAlignment = Enum.TextXAlignment.Left
            }, {})
            label.Parent = row

            local bar = mk("Frame", {
                Size = UDim2.new(1,0,0,18),
                Position = UDim2.new(0,0,0,22),
                BackgroundColor3 = Theme.LightBase,
                BorderSizePixel = 0
            }, {})
            makeCorner(6).Parent = bar
            makeStroke(1, Theme.SectionBorder, 0.12).Parent = bar
            bar.Parent = row

            local fill = mk("Frame", { Size = UDim2.new((val-min)/(max-min),0,1,0), BackgroundColor3 = Theme.Accent, BorderSizePixel = 0 }, {})
            makeCorner(6).Parent = fill
            fill.Parent = bar

            local dragging = false
            local function set(v)
                v = math.floor(((v - min) / (max - min)) * ((max - min) / step) + 0.5) * step + min
                v = math.clamp(v, min, max)
                val = v
                label.Text = tostring(opts.text or "slider") .. " - " .. tostring(val)
                fill.Size = UDim2.new((val - min) / (max - min), 0, 1, 0)
                if opts.callback then task.spawn(opts.callback, val) end
            end

            local function fromX(x)
                local ap = bar.AbsolutePosition.X
                local aw = bar.AbsoluteSize.X
                local ratio = math.clamp((x - ap) / aw, 0, 1)
                set(min + ratio * (max - min))
            end

            bar.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    fromX(input.Position.X)
                end
            end)
            bar.InputEnded:Connect(function()
                dragging = false
            end)
            UserInputService.InputChanged:Connect(function(input)
                if not dragging then return end
                if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                    fromX(input.Position.X)
                end
            end)

            set(val)
            return { Set = set, Get = function() return val end }
        end

        -- Dropdown widget
        function s:Dropdown(opts)
            opts = opts or {}
            local values = opts.values or {}
            local current = opts.default or values[1] or ""

            local row = mk("Frame", { Size = UDim2.new(1,0,0,34), BackgroundTransparency = 1 }, {})
            row.Parent = section

            local btn = mk("TextButton", {
                Text = (opts.text or "select") .. " - " .. tostring(current),
                BackgroundColor3 = Theme.LightBase, BorderSizePixel = 0,
                TextColor3 = Theme.Text, Font = Enum.Font.Gotham, TextSize = 14, AutoButtonColor = false
            }, {})
            makeCorner(6).Parent = btn
            btn.Parent = row

            local list = mk("Frame", { Visible = false, BackgroundColor3 = Theme.Section, BorderSizePixel = 0, Size = UDim2.new(1,0,0,0) }, {})
            makeCorner(6).Parent = list
            list.Parent = row

            local vlist = mk("UIListLayout", { Padding = UDim.new(0,2) }, {})
            vlist.Parent = list

            local function refreshList()
                for i,child in ipairs(list:GetChildren()) do
                    if child:IsA("TextButton") then child:Destroy() end
                end
                local tot = #values
                list.Size = UDim2.new(1, 0, 0, math.min(6, tot) * 26 + 8)
                for _,v in ipairs(values) do
                    local item = mk("TextButton", {
                        Text = tostring(v), BackgroundColor3 = Theme.LightBase, BorderSizePixel = 0,
                        TextColor3 = Theme.Text, Font = Enum.Font.Gotham, TextSize = 14, AutoButtonColor = false, Size = UDim2.new(1,0,0,26)
                    }, {})
                    makeCorner(6).Parent = item
                    item.Parent = list
                    item.MouseButton1Click:Connect(function()
                        current = v
                        btn.Text = (opts.text or "select") .. " - " .. tostring(current)
                        list.Visible = false
                        if opts.callback then task.spawn(opts.callback, current) end
                    end)
                end
            end

            btn.MouseButton1Click:Connect(function() list.Visible = not list.Visible end)
            row.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.Touch then list.Visible = not list.Visible end end)

            refreshList()
            return { Set = function(v) current = v; btn.Text = (opts.text or "select") .. " - " .. tostring(current) end, Get = function() return current end }
        end

        -- Color picker with rainbow option
        function s:ColorPicker(opts)
            opts = opts or {}
            local current = opts.default or Color3.fromRGB(0, 198, 160)
            local rainbow = opts.rainbow or false
            local speed = opts.speed or 8
            local hue = 0
            local conn

            local row = mk("Frame", { Size = UDim2.new(1,0,0,64), BackgroundTransparency = 1 }, {})
            row.Parent = section

            local label = mk("TextLabel", { Text = tostring(opts.text or "color"), BackgroundTransparency = 1, TextColor3 = Theme.Text, Font = Enum.Font.Gotham, TextSize = 14, Size = UDim2.new(1,0,0,18), TextXAlignment = Enum.TextXAlignment.Left }, {})
            label.Parent = row

            local swatch = mk("TextButton", { Size = UDim2.new(0,44,0,28), Position = UDim2.new(0,0,0,26), BackgroundColor3 = current, BorderSizePixel = 0, AutoButtonColor = false }, {})
            makeCorner(8).Parent = swatch
            swatch.Parent = row

            local rainbowBtn = mk("TextButton", { Text = "rainbow", Size = UDim2.new(0,70,0,28), Position = UDim2.new(0,52,0,26), BackgroundColor3 = rainbow and Theme.Accent or Theme.LightBase, BorderSizePixel = 0, AutoButtonColor = false, Font = Enum.Font.Gotham, TextSize = 12, TextColor3 = Theme.Text }, {})
            makeCorner(6).Parent = rainbowBtn
            rainbowBtn.Parent = row

            local speedBar = mk("Frame", { Size = UDim2.new(1, -136, 0, 28), Position = UDim2.new(0, 136, 0, 26), BackgroundColor3 = Theme.LightBase, BorderSizePixel = 0 }, {})
            makeCorner(6).Parent = speedBar
            speedBar.Parent = row
            local speedFill = mk("Frame", { Size = UDim2.new(math.clamp(speed/50,0,1),0,1,0), BackgroundColor3 = Theme.Accent, BorderSizePixel = 0 }, {})
            makeCorner(6).Parent = speedFill
            speedFill.Parent = speedBar

            local function setColor(c)
                current = c
                swatch.BackgroundColor3 = current
                if opts.callback then task.spawn(opts.callback, current) end
            end

            local function stopRainbow()
                if conn then conn:Disconnect(); conn = nil end
            end

            local function startRainbow()
                stopRainbow()
                conn = RunService.RenderStepped:Connect(function(dt)
                    hue = (hue + dt * (speed * 0.06)) % 1
                    setColor(Color3.fromHSV(hue, 1, 1))
                end)
                table.insert(self._rainbowConnections, conn)
            end

            rainbowBtn.MouseButton1Click:Connect(function()
                rainbow = not rainbow
                rainbowBtn.BackgroundColor3 = rainbow and Theme.Accent or Theme.LightBase
                if rainbow then startRainbow() else stopRainbow() end
            end)

            -- speed bar input
            local dragging = false
            speedBar.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                    local x = input.Position.X
                    local ap = speedBar.AbsolutePosition.X
                    local aw = speedBar.AbsoluteSize.X
                    local ratio = math.clamp((x - ap)/aw, 0, 1)
                    speed = math.clamp(math.floor(ratio * 50), 1, 50)
                    speedFill.Size = UDim2.new(speed/50, 0, 1, 0)
                end
            end)
            UserInputService.InputChanged:Connect(function(input)
                if not dragging then return end
                if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement then
                    local x = input.Position.X
                    local ap = speedBar.AbsolutePosition.X
                    local aw = speedBar.AbsoluteSize.X
                    local ratio = math.clamp((x - ap)/aw, 0, 1)
                    speed = math.clamp(math.floor(ratio * 50), 1, 50)
                    speedFill.Size = UDim2.new(speed/50, 0, 1, 0)
                end
            end)
            UserInputService.InputEnded:Connect(function(input)
                dragging = false
            end)

            -- clicking swatch opens Roblox's ColorPicker (if desired) or we can implement a simple HSV palette
            swatch.MouseButton1Click:Connect(function()
                -- Basic quick palette: cycle a few presets for convenience (keeps code simple)
                local presets = {
                    Color3.fromRGB(0,198,160),
                    Color3.fromRGB(255,100,100),
                    Color3.fromRGB(80,160,255),
                    Color3.fromRGB(255,210,80),
                    Color3.fromRGB(200,120,255)
                }
                local idx = 1
                for i,v in ipairs(presets) do if v == current then idx = i; break end end
                local nextc = presets[(idx % #presets) + 1]
                setColor(nextc)
            end)

            if rainbow then startRainbow() end
            return {
                SetColor = setColor,
                GetColor = function() return current end,
                SetRainbow = function(b) if b then startRainbow() else stopRainbow() end end,
                GetRainbow = function() return rainbow end,
                SetSpeed = function(v) speed = v; speedFill.Size = UDim2.new(speed/50,0,1,0) end,
                GetSpeed = function() return speed end
            }
        end

        -- return section object
        tab.Sections[#tab.Sections+1] = s
        return s
    end

    return tab
end

-- Background customization API
-- mode: "none" | "pixel_gradient" | "stars"
-- opts depends on mode
function BigHookUI:SetBackgroundMode(mode, opts)
    opts = opts or {}
    -- cleanup previous
    if self._backgroundCleanup then
        pcall(self._backgroundCleanup)
        self._backgroundCleanup = nil
    end

    local bgParent = self.Root
    if mode == "pixel_gradient" then
        local cols = opts.columns or 36
        local rows = opts.rows or 18
        local opacity = opts.opacity or 0.14
        -- palette function: take two given colors and blend
        local a = opts.colorA or Color3.fromRGB(20,30,60)
        local b = opts.colorB or Color3.fromRGB(10,140,200)
        local function palette(xf, yf)
            -- simple bilinear blend
            local t = (xf + (1 - yf)) / 2
            return Color3.new(a.R * (1-t) + b.R * t, a.G * (1-t) + b.G * t, a.B * (1-t) + b.B * t)
        end
        local container, cleanup = createPixelGradientFrame(bgParent, cols, rows, opacity, palette)
        self._backgroundCleanup = cleanup
        container.ZIndex = 0
    elseif mode == "stars" then
        local count = opts.count or 60
        local speedRange = opts.speedRange or {10, 40}
        local color = opts.color or Color3.new(1,1,1)
        local alpha = opts.alpha or 0.9
        local container, cleanup = createStarsFrame(bgParent, count, speedRange, color, alpha)
        self._backgroundCleanup = cleanup
        container.ZIndex = 0
    else
        -- none (transparent)
    end
end

-- Allow changing the floating button text (e.g., icon)
function BigHookUI:SetFloatingText(txt)
    if not self.Floater then return end
    self.Floater.Text = tostring(txt or self.Floater.Text)
end

-- Clean up
function BigHookUI:Destroy()
    for _,c in ipairs(self._rainbowConnections) do pcall(function() c:Disconnect() end) end
    if self._backgroundCleanup then pcall(self._backgroundCleanup) end
    if self.Gui and self.Gui.Parent then self.Gui:Destroy() end
end

return BigHookUI
