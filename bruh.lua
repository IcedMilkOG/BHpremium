-- MobileUILibrary.lua
local MobileUILibrary = {}
MobileUILibrary.__index = MobileUILibrary

-- Services
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- Create main UI
function MobileUILibrary.new(title)
    local self = setmetatable({}, MobileUILibrary)
    
    -- Main ScreenGui
    self.ScreenGui = Instance.new("ScreenGui")
    self.ScreenGui.Name = title or "MobileUI"
    self.ScreenGui.ResetOnSpawn = false
    self.ScreenGui.IgnoreGuiInset = true
    self.ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    -- Main Frame
    self.MainFrame = Instance.new("Frame")
    self.MainFrame.Size = UDim2.new(0.9, 0, 0.7, 0)
    self.MainFrame.Position = UDim2.new(0.05, 0, 0.15, 0)
    self.MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    self.MainFrame.BorderSizePixel = 0
    self.MainFrame.ClipsDescendants = true
    self.MainFrame.Parent = self.ScreenGui
    
    -- UI Corner for smooth edges
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = self.MainFrame
    
    -- Title Label
    self.TitleLabel = Instance.new("TextLabel")
    self.TitleLabel.Size = UDim2.new(1, 0, 0.1, 0)
    self.TitleLabel.Position = UDim2.new(0, 0, 0, 0)
    self.TitleLabel.BackgroundTransparency = 1
    self.TitleLabel.Text = title or "Mobile UI"
    self.TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    self.TitleLabel.TextScaled = true
    self.TitleLabel.Font = Enum.Font.GothamBold
    self.TitleLabel.Parent = self.MainFrame
    
    -- Tab Container
    self.TabContainer = Instance.new("Frame")
    self.TabContainer.Size = UDim2.new(1, 0, 0.1, 0)
    self.TabContainer.Position = UDim2.new(0, 0, 0.1, 0)
    self.TabContainer.BackgroundTransparency = 1
    self.TabContainer.Parent = self.MainFrame
    
    self.TabLayout = Instance.new("UIListLayout")
    self.TabLayout.FillDirection = Enum.FillDirection.Horizontal
    self.TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    self.TabLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    self.TabLayout.Padding = UDim.new(0, 10)
    self.TabLayout.Parent = self.TabContainer
    
    -- Content Frame
    self.ContentFrame = Instance.new("Frame")
    self.ContentFrame.Size = UDim2.new(1, 0, 0.8, 0)
    self.ContentFrame.Position = UDim2.new(0, 0, 0.2, 0)
    self.ContentFrame.BackgroundTransparency = 1
    self.ContentFrame.ClipsDescendants = true
    self.ContentFrame.Parent = self.MainFrame
    
    self.ContentLayout = Instance.new("UIListLayout")
    self.ContentLayout.Padding = UDim.new(0, 10)
    self.ContentLayout.Parent = self.ContentFrame
    
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
                    startPos.X.Offset + delta.X,
                    startPos.Y.Scale,
                    startPos.Y.Offset + delta.Y
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
    local tab = {}
    
    -- Tab Button
    tab.Button = Instance.new("TextButton")
    tab.Button.Size = UDim2.new(0, 100, 0, 30)
    tab.Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    tab.Button.Text = name
    tab.Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    tab.Button.TextScaled = true
    tab.Button.Font = Enum.Font.Gotham
    tab.Button.Parent = self.TabContainer
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 5)
    corner.Parent = tab.Button
    
    -- Tab Content
    tab.Content = Instance.new("Frame")
    tab.Content.Size = UDim2.new(1, 0, 1, 0)
    tab.Content.BackgroundTransparency = 1
    tab.Content.Visible = false
    tab.Content.Parent = self.ContentFrame
    
    tab.ContentLayout = Instance.new("UIListLayout")
    tab.ContentLayout.Padding = UDim.new(0, 10)
    tab.ContentLayout.Parent = tab.Content
    
    self.Tabs[name] = tab
    
    -- Tab switching
    tab.Button.MouseButton1Click:Connect(function()
        self:SwitchTab(name)
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
            tab.Button.BackgroundColor3 = tabName == name and Color3.fromRGB(70, 70, 70) or Color3.fromRGB(50, 50, 50)
        end
        self.CurrentTab = name
    end
end

-- Create a label
function MobileUILibrary:CreateLabel(tab, text)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 30)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextScaled = true
    label.Font = Enum.Font.Gotham
    label.Parent = self.Tabs[tab].Content
    
    return label
end

-- Create a slider
function MobileUILibrary:CreateSlider(tab, name, min, max, default, callback)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(1, 0, 0, 50)
    sliderFrame.BackgroundTransparency = 1
    sliderFrame.Parent = self.Tabs[tab].Content
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 20)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextScaled = true
    label.Font = Enum.Font.Gotham
    label.Parent = sliderFrame
    
    local sliderBar = Instance.new("Frame")
    sliderBar.Size = UDim2.new(1, -20, 0, 10)
    sliderBar.Position = UDim2.new(0, 10, 0, 30)
    sliderBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    sliderBar.Parent = sliderFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 5)
    corner.Parent = sliderBar
    
    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
    fill.Parent = sliderBar
    
    local cornerFill = Instance.new("UICorner")
    cornerFill.CornerRadius = UDim.new(0, 5)
    cornerFill.Parent = fill
    
    local value = default
    local dragging = false
    
    local function updateSlider(input)
        local relativeX = math.clamp((input.Position.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
        value = min + (max - min) * relativeX
        fill.Size = UDim2.new(relativeX, 0, 1, 0)
        if callback then
            callback(value)
        end
    end
    
    sliderBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            updateSlider(input)
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
        end
    end)
    
    return sliderFrame
end

-- Create a dropdown
function MobileUILibrary:CreateDropdown(tab, name, options, callback)
    local dropdownFrame = Instance.new("Frame")
    dropdownFrame.Size = UDim2.new(1, 0, 0, 50)
    dropdownFrame.BackgroundTransparency = 1
    dropdownFrame.Parent = self.Tabs[tab].Content
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 20)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextScaled = true
    label.Font = Enum.Font.Gotham
    label.Parent = dropdownFrame
    
    local dropdownButton = Instance.new("TextButton")
    dropdownButton.Size = UDim2.new(1, -20, 0, 30)
    dropdownButton.Position = UDim2.new(0, 10, 0, 20)
    dropdownButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    dropdownButton.Text = options[1] or "Select"
    dropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    dropdownButton.TextScaled = true
    dropdownButton.Font = Enum.Font.Gotham
    dropdownButton.Parent = dropdownFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 5)
    corner.Parent = dropdownButton
    
    local dropdownList = Instance.new("Frame")
    dropdownList.Size = UDim2.new(1, -20, 0, 0)
    dropdownList.Position = UDim2.new(0, 10, 0, 50)
    dropdownList.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    dropdownList.Visible = false
    dropdownList.ClipsDescendants = true
    dropdownList.Parent = dropdownFrame
    
    local listLayout = Instance.new("UIListLayout")
    listLayout.Parent = dropdownList
    
    local function toggleList()
        dropdownList.Visible = not dropdownList.Visible
        dropdownList.Size = dropdownList.Visible and UDim2.new(1, -20, 0, #options * 30) or UDim2.new(1, -20, 0, 0)
    end
    
    dropdownButton.MouseButton1Click:Connect(toggleList)
    
    for _, option in ipairs(options) do
        local optionButton = Instance.new("TextButton")
        optionButton.Size = UDim2.new(1, 0, 0, 30)
        optionButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        optionButton.Text = option
        optionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        optionButton.TextScaled = true
        optionButton.Font = Enum.Font.Gotham
        optionButton.Parent = dropdownList
        
        optionButton.MouseButton1Click:Connect(function()
            dropdownButton.Text = option
            toggleList()
            if callback then
                callback(option)
            end
        end)
    end
    
    return dropdownFrame
end

-- Create a color picker
function MobileUILibrary:CreateColorPicker(tab, name, defaultColor, callback)
    local colorPickerFrame = Instance.new("Frame")
    colorPickerFrame.Size = UDim2.new(1, 0, 0, 50)
    colorPickerFrame.BackgroundTransparency = 1
    colorPickerFrame.Parent = self.Tabs[tab].Content
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 20)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextScaled = true
    label.Font = Enum.Font.Gotham
    label.Parent = colorPickerFrame
    
    local colorButton = Instance.new("TextButton")
    colorButton.Size = UDim2.new(0, 40, 0, 30)
    colorButton.Position = UDim2.new(0, 10, 0, 20)
    colorButton.BackgroundColor3 = defaultColor or Color3.fromRGB(255, 255, 255)
    colorButton.Text = ""
    colorButton.Parent = colorPickerFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 5)
    corner.Parent = colorButton
    
    local pickerFrame = Instance.new("Frame")
    pickerFrame.Size = UDim2.new(0, 150, 0, 150)
    pickerFrame.Position = UDim2.new(0, 60, 0, 20)
    pickerFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    pickerFrame.Visible = false
    pickerFrame.Parent = colorPickerFrame
    
    local cornerPicker = Instance.new("UICorner")
    cornerPicker.CornerRadius = UDim.new(0, 5)
    cornerPicker.Parent = pickerFrame
    
    local hueBar = Instance.new("ImageLabel")
    hueBar.Size = UDim2.new(0, 20, 1, 0)
    hueBar.Position = UDim2.new(0, 5, 0, 5)
    hueBar.Image = "rbxassetid://698052001" -- Roblox hue gradient
    hueBar.Parent = pickerFrame
    
    local saturationValue = Instance.new("ImageLabel")
    saturationValue.Size = UDim2.new(0, 100, 0, 100)
    saturationValue.Position = UDim2.new(0, 30, 0, 5)
    saturationValue.Image = "rbxassetid://698052001" -- Placeholder for saturation/value
    saturationValue.Parent = pickerFrame
    
    local function updateColor()
        -- Simplified color picking (hue only for mobile simplicity)
        local color = Color3.fromHSV(math.random(), 1, 1) -- Placeholder
        colorButton.BackgroundColor3 = color
        if callback then
            callback(color)
        end
    end
    
    colorButton.MouseButton1Click:Connect(function()
        pickerFrame.Visible = not pickerFrame.Visible
    end)
    
    hueBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            updateColor()
        end
    end)
    
    return colorPickerFrame
end

-- Destroy the UI
function MobileUILibrary:Destroy()
    if self.ScreenGui then
        self.ScreenGui:Destroy()
    end
end

return MobileUILibrary