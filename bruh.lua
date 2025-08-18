-- MobileUILibrary.lua
local MobileUILibrary = {}
MobileUILibrary.__index = MobileUILibrary

-- Services
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- Utility function for safe instance creation
local function createInstance(class, properties)
    local instance = Instance.new(class)
    for prop, value in pairs(properties or {}) do
        pcall(function()
            instance[prop] = value
        end)
    end
    return instance
end

-- Create main UI
function MobileUILibrary.new(title)
    local self = setmetatable({}, MobileUILibrary)
    
    -- Main ScreenGui
    self.ScreenGui = createInstance("ScreenGui", {
        Name = title or "MobileUI",
        ResetOnSpawn = false,
        IgnoreGuiInset = true,
        Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui", 10)
    })
    if not self.ScreenGui.Parent then
        warn("Failed to parent ScreenGui to PlayerGui")
        return nil
    end
    
    -- Main Frame with glassmorphism effect
    self.MainFrame = createInstance("Frame", {
        Size = UDim2.new(0.85, 0, 0.65, 0),
        Position = UDim2.new(0.075, 0, 0.175, 0),
        BackgroundColor3 = Color3.fromRGB(20, 20, 20),
        BackgroundTransparency = 0.3,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Parent = self.ScreenGui
    })
    
    -- UICorner and UIGradient for modern look
    createInstance("UICorner", { CornerRadius = UDim.new(0, 15), Parent = self.MainFrame })
    createInstance("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 50, 50)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 20))
        }),
        Rotation = 45,
        Parent = self.MainFrame
    })
    
    -- Shadow effect
    local shadow = createInstance("ImageLabel", {
        Image = "rbxassetid://1316045217", -- Roblox shadow asset
        ImageColor3 = Color3.fromRGB(0, 0, 0),
        ImageTransparency = 0.7,
        Size = UDim2.new(1, 20, 1, 20),
        Position = UDim2.new(0, -10, 0, -10),
        BackgroundTransparency = 1,
        ZIndex = -1,
        Parent = self.MainFrame
    })
    
    -- Title Label
    self.TitleLabel = createInstance("TextLabel", {
        Size = UDim2.new(1, 0, 0.1, 0),
        BackgroundTransparency = 1,
        Text = title or "Mobile UI",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextScaled = true,
        Font = Enum.Font.GothamBlack,
        TextStrokeTransparency = 0.8,
        Parent = self.MainFrame
    })
    
    -- Tab Container
    self.TabContainer = createInstance("Frame", {
        Size = UDim2.new(1, 0, 0.1, 0),
        Position = UDim2.new(0, 0, 0.1, 0),
        BackgroundTransparency = 1,
        Parent = self.MainFrame
    })
    
    self.TabLayout = createInstance("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        Padding = UDim.new(0, 15),
        Parent = self.TabContainer
    })
    
    -- Content Frame
    self.ContentFrame = createInstance("Frame", {
        Size = UDim2.new(1, 0, 0.8, 0),
        Position = UDim2.new(0, 0, 0.2, 0),
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        Parent = self.MainFrame
    })
    
    self.ContentLayout = createInstance("UIListLayout", {
        Padding = UDim.new(0, 15),
        Parent = self.ContentFrame
    })
    
    self.Tabs = {}
    self.CurrentTab = nil
    
    -- Dragging for mobile
    self:EnableDragging()
    
    return self
end

-- Enable dragging for mobile
function MobileUILibrary:EnableDragging()
    local dragging = false
    local dragStart, startPos
    
    self.MainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = self.MainFrame.Position
        end
    end)
    
    self.MainFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement then
            if dragging then
                local delta = input.Position - dragStart
                local newPos = UDim2.new(
                    startPos.X.Scale,
                    math.clamp(startPos.X.Offset + delta.X, -self.MainFrame.AbsoluteSize.X / 2, game:GetService("GuiService"):GetScreenResolution().X - self.MainFrame.AbsoluteSize.X / 2),
                    startPos.Y.Scale,
                    math.clamp(startPos.Y.Offset + delta.Y, -self.MainFrame.AbsoluteSize.Y / 2, game:GetService("GuiService"):GetScreenResolution().Y - self.MainFrame.AbsoluteSize.Y / 2)
                )
                self.MainFrame.Position = newPos
            end
        end
    end)
    
    self.MainFrame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
end

-- Create a new tab
function MobileUILibrary:CreateTab(name)
    if not name then
        warn("Tab name cannot be nil")
        return nil
    end
    
    local tab = {}
    
    -- Tab Button with animation
    tab.Button = createInstance("TextButton", {
        Size = UDim2.new(0, 120, 0, 35),
        BackgroundColor3 = Color3.fromRGB(60, 60, 60),
        Text = name,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextScaled = true,
        Font = Enum.Font.GothamBold,
        Parent = self.TabContainer
    })
    
    createInstance("UICorner", { CornerRadius = UDim.new(0, 8), Parent = tab.Button })
    createInstance("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 80, 80)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 40, 40))
        }),
        Parent = tab.Button
    })
    
    -- Tab Content
    tab.Content = createInstance("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Visible = false,
        Parent = self.ContentFrame
    })
    
    tab.ContentLayout = createInstance("UIListLayout", {
        Padding = UDim.new(0, 15),
        Parent = tab.Content
    })
    
    self.Tabs[name] = tab
    
    -- Tab switching with animation
    tab.Button.MouseButton1Click:Connect(function()
        if self.CurrentTab ~= name then
            self:SwitchTab(name)
            local tween = TweenService:Create(tab.Button, TweenInfo.new(0.3, Enum.EasingStyle.Quad), { Size = UDim2.new(0, 140, 0, 40) })
            tween:Play()
            wait(0.3)
            tween = TweenService:Create(tab.Button, TweenInfo.new(0.2, Enum.EasingStyle.Quad), { Size = UDim2.new(0, 120, 0, 35) })
            tween:Play()
        end
    end)
    
    if not self.CurrentTab then
        self:SwitchTab(name)
    end
    
    return tab
end

-- Switch to a specific tab
function MobileUILibrary:SwitchTab(name)
    if self.Tabs[name] then
        for tabName, tab in pairs(self.Tabs) do
            tab.Content.Visible = (tabName == name)
            local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad)
            TweenService:Create(tab.Button, tweenInfo, {
                BackgroundColor3 = tabName == name and Color3.fromRGB(100, 100, 255) or Color3.fromRGB(60, 60, 60)
            }):Play()
        end
        self.CurrentTab = name
    else
        warn("Tab not found: " .. tostring(name))
    end
end

-- Create a label
function MobileUILibrary:CreateLabel(tab, text)
    if not self.Tabs[tab] then
        warn("Invalid tab for label: " .. tostring(tab))
        return nil
    end
    
    local label = createInstance("TextLabel", {
        Size = UDim2.new(1, 0, 0, 35),
        BackgroundTransparency = 1,
        Text = text or "Label",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextScaled = true,
        Font = Enum.Font.Gotham,
        TextStrokeTransparency = 0.8,
        Parent = self.Tabs[tab].Content
    })
    
    return label
end

-- Create a slider
function MobileUILibrary:CreateSlider(tab, name, min, max, default, callback)
    if not self.Tabs[tab] then
        warn("Invalid tab for slider: " .. tostring(tab))
        return nil
    end
    
    local sliderFrame = createInstance("Frame", {
        Size = UDim2.new(1, 0, 0, 60),
        BackgroundTransparency = 1,
        Parent = self.Tabs[tab].Content
    })
    
    local label = createInstance("TextLabel", {
        Size = UDim2.new(1, 0, 0, 20),
        BackgroundTransparency = 1,
        Text = name,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextScaled = true,
        Font = Enum.Font.Gotham,
        Parent = sliderFrame
    })
    
    local sliderBar = createInstance("Frame", {
        Size = UDim2.new(1, -30, 0, 12),
        Position = UDim2.new(0, 15, 0, 35),
        BackgroundColor3 = Color3.fromRGB(50, 50, 50),
        Parent = sliderFrame
    })
    
    createInstance("UICorner", { CornerRadius = UDim.new(0, 6), Parent = sliderBar })
    
    local fill = createInstance("Frame", {
        Size = UDim2.new((default - min) / (max - min), 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(100, 100, 255),
        Parent = sliderBar
    })
    
    createInstance("UICorner", { CornerRadius = UDim.new(0, 6), Parent = fill })
    createInstance("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(150, 150, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 100, 255))
        }),
        Parent = fill
    })
    
    local valueLabel = createInstance("TextLabel", {
        Size = UDim2.new(0, 50, 0, 20),
        Position = UDim2.new(1, -65, 0, 35),
        BackgroundTransparency = 1,
        Text = tostring(default),
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextScaled = true,
        Font = Enum.Font.Gotham,
        Parent = sliderFrame
    })
    
    local value = default
    local dragging = false
    
    local function updateSlider(input)
        local relativeX = math.clamp((input.Position.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
        value = math.floor(min + (max - min) * relativeX)
        fill.Size = UDim2.new(relativeX, 0, 1, 0)
        valueLabel.Text = tostring(value)
        if callback then
            pcall(callback, value)
        end
    end
    
    sliderBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            updateSlider(input)
            TweenService:Create(sliderBar, TweenInfo.new(0.2), { BackgroundColor3 = Color3.fromRGB(70, 70, 70) }):Play()
        end
    end)
    
    sliderBar.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
            updateSlider(input)
        end
    end)
    
    sliderBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
            TweenService:Create(sliderBar, TweenInfo.new(0.2), { BackgroundColor3 = Color3.fromRGB(50, 50, 50) }):Play()
        end
    end)
    
    return sliderFrame
end

-- Create a dropdown
function MobileUILibrary:CreateDropdown(tab, name, options, callback)
    if not self.Tabs[tab] then
        warn("Invalid tab for dropdown: " .. tostring(tab))
        return nil
    end
    
    local dropdownFrame = createInstance("Frame", {
        Size = UDim2.new(1, 0, 0, 60),
        BackgroundTransparency = 1,
        Parent = self.Tabs[tab].Content
    })
    
    local label = createInstance("TextLabel", {
        Size = UDim2.new(1, 0, 0, 20),
        BackgroundTransparency = 1,
        Text = name,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextScaled = true,
        Font = Enum.Font.Gotham,
        Parent = dropdownFrame
    })
    
    local dropdownButton = createInstance("TextButton", {
        Size = UDim2.new(1, -30, 0, 35),
        Position = UDim2.new(0, 15, 0, 25),
        BackgroundColor3 = Color3.fromRGB(60, 60, 60),
        Text = options[1] or "Select",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextScaled = true,
        Font = Enum.Font.GothamBold,
        Parent = dropdownFrame
    })
    
    createInstance("UICorner", { CornerRadius = UDim.new(0, 8), Parent = dropdownButton })
    createInstance("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 80, 80)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 40, 40))
        }),
        Parent = dropdownButton
    })
    
    local dropdownList = createInstance("Frame", {
        Size = UDim2.new(1, -30, 0, 0),
        Position = UDim2.new(0, 15, 0, 60),
        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
        BackgroundTransparency = 0.2,
        Visible = false,
        ClipsDescendants = true,
        Parent = dropdownFrame
    })
    
    createInstance("UICorner", { CornerRadius = UDim.new(0, 8), Parent = dropdownList })
    local listLayout = createInstance("UIListLayout", { Parent = dropdownList })
    
    local function toggleList()
        dropdownList.Visible = not dropdownList.Visible
        local targetSize = dropdownList.Visible and UDim2.new(1, -30, 0, math.min(#options * 35, 140)) or UDim2.new(1, -30, 0, 0)
        TweenService:Create(dropdownList, TweenInfo.new(0.3, Enum.EasingStyle.Quad), { Size = targetSize }):Play()
    end
    
    dropdownButton.MouseButton1Click:Connect(toggleList)
    
    for _, option in ipairs(options or {}) do
        local optionButton = createInstance("TextButton", {
            Size = UDim2.new(1, 0, 0, 35),
            BackgroundColor3 = Color3.fromRGB(50, 50, 50),
            Text = option,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextScaled = true,
            Font = Enum.Font.Gotham,
            Parent = dropdownList
        })
        
        createInstance("UICorner", { CornerRadius = UDim.new(0, 8), Parent = optionButton })
        
        optionButton.MouseButton1Click:Connect(function()
            dropdownButton.Text = option
            toggleList()
            if callback then
                pcall(callback, option)
            end
        end)
    end
    
    return dropdownFrame
end

-- Create a color picker
function MobileUILibrary:CreateColorPicker(tab, name, defaultColor, callback)
    if not self.Tabs[tab] then
        warn("Invalid tab for color picker: " .. tostring(tab))
        return nil
    end
    
    local colorPickerFrame = createInstance("Frame", {
        Size = UDim2.new(1, 0, 0, 60),
        BackgroundTransparency = 1,
        Parent = self.Tabs[tab].Content
    })
    
    local label = createInstance("TextLabel", {
        Size = UDim2.new(1, 0, 0, 20),
        BackgroundTransparency = 1,
        Text = name,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextScaled = true,
        Font = Enum.Font.Gotham,
        Parent = colorPickerFrame
    })
    
    local colorButton = createInstance("TextButton", {
        Size = UDim2.new(0, 50, 0, 35),
        Position = UDim2.new(0, 15, 0, 25),
        BackgroundColor3 = defaultColor or Color3.fromRGB(255, 255, 255),
        Text = "",
        Parent = colorPickerFrame
    })
    
    createInstance("UICorner", { CornerRadius = UDim.new(0, 8), Parent = colorButton })
    
    local pickerFrame = createInstance("Frame", {
        Size = UDim2.new(0, 180, 0, 180),
        Position = UDim2.new(0, 75, 0, 25),
        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
        BackgroundTransparency = 0.2,
        Visible = false,
        Parent = colorPickerFrame
    })
    
    createInstance("UICorner", { CornerRadius = UDim.new(0, 8), Parent = pickerFrame })
    
    local hueBar = createInstance("ImageLabel", {
        Size = UDim2.new(0, 30, 0, 150),
        Position = UDim2.new(0, 10, 0, 15),
        Image = "rbxassetid://698052001", -- Roblox hue gradient
        Parent = pickerFrame
    })
    
    local saturationValue = createInstance("ImageLabel", {
        Size = UDim2.new(0, 120, 0, 120),
        Position = UDim2.new(0, 45, 0, 15),
        Image = "rbxassetid://698052001", -- Placeholder for saturation/value
        Parent = pickerFrame
    })
    
    local function updateColor(input)
        local hue = math.clamp((input.Position.Y - hueBar.AbsolutePosition.Y) / hueBar.AbsoluteSize.Y, 0, 1)
        local color = Color3.fromHSV(hue, 1, 1)
        colorButton.BackgroundColor3 = color
        if callback then
            pcall(callback, color)
        end
    end
    
    colorButton.MouseButton1Click:Connect(function()
        pickerFrame.Visible = not pickerFrame.Visible
        TweenService:Create(pickerFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), { BackgroundTransparency = pickerFrame.Visible and 0.2 or 1 }):Play()
    end)
    
    hueBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            updateColor(input)
        end
    end)
    
    return colorPickerFrame
end

-- Destroy the UI
function MobileUILibrary:Destroy()
    if self.ScreenGui then
        pcall(function()
            self.ScreenGui:Destroy()
        end)
    end
end

return MobileUILibrary