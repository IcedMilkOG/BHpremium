-- KelTec GUI Library - UI Elements (Part 2)
-- Add this to the main library file

-- Toggle Button
function KelTecLib:CreateToggle(section, name, default, callback)
    default = default or false
    callback = callback or function() end
    
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Name = name .. "Toggle"
    ToggleFrame.Size = UDim2.new(1, 0, 0, 35)
    ToggleFrame.BackgroundColor3 = Config.Colors.Background
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Parent = section.Content
    CreateCorner(ToggleFrame, 6)
    CreateStroke(ToggleFrame, Config.Colors.Border)
    
    local ToggleLabel = Instance.new("TextLabel")
    ToggleLabel.Name = "ToggleLabel"
    ToggleLabel.Size = UDim2.new(1, -50, 1, 0)
    ToggleLabel.Position = UDim2.new(0, 10, 0, 0)
    ToggleLabel.BackgroundTransparency = 1
    ToggleLabel.Text = name
    ToggleLabel.TextColor3 = Config.Colors.Text
    ToggleLabel.TextSize = 14
    ToggleLabel.Font = Config.Fonts.Main
    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    ToggleLabel.Parent = ToggleFrame
    
    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Name = "ToggleButton"
    ToggleButton.Size = UDim2.new(0, 40, 0, 20)
    ToggleButton.Position = UDim2.new(1, -45, 0.5, -10)
    ToggleButton.BackgroundColor3 = default and Config.Colors.Success or Config.Colors.Border
    ToggleButton.BorderSizePixel = 0
    ToggleButton.Text = ""
    ToggleButton.Parent = ToggleFrame
    CreateCorner(ToggleButton, 10)
    
    local ToggleIndicator = Instance.new("Frame")
    ToggleIndicator.Name = "ToggleIndicator"
    ToggleIndicator.Size = UDim2.new(0, 16, 0, 16)
    ToggleIndicator.Position = default and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
    ToggleIndicator.BackgroundColor3 = Config.Colors.Text
    ToggleIndicator.BorderSizePixel = 0
    ToggleIndicator.Parent = ToggleButton
    CreateCorner(ToggleIndicator, 8)
    
    local isToggled = default
    
    local function UpdateToggle()
        isToggled = not isToggled
        CreateTween(ToggleButton, {
            BackgroundColor3 = isToggled and Config.Colors.Success or Config.Colors.Border
        }, 0.2)
        CreateTween(ToggleIndicator, {
            Position = isToggled and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
        }, 0.2)
        callback(isToggled)
    end
    
    ToggleButton.MouseButton1Click:Connect(UpdateToggle)
    
    return {
        Frame = ToggleFrame,
        SetValue = function(value)
            if value ~= isToggled then
                UpdateToggle()
            end
        end,
        GetValue = function()
            return isToggled
        end
    }
end

-- Regular Button
function KelTecLib:CreateButton(section, name, callback)
    callback = callback or function() end
    
    local ButtonFrame = Instance.new("TextButton")
    ButtonFrame.Name = name .. "Button"
    ButtonFrame.Size = UDim2.new(1, 0, 0, 35)
    ButtonFrame.BackgroundColor3 = Config.Colors.Accent
    ButtonFrame.BorderSizePixel = 0
    ButtonFrame.Text = name
    ButtonFrame.TextColor3 = Config.Colors.Text
    ButtonFrame.TextSize = 14
    ButtonFrame.Font = Config.Fonts.Main
    ButtonFrame.Parent = section.Content
    CreateCorner(ButtonFrame, 6)
    
    local ButtonGradient = CreateGradient(ButtonFrame, ColorSequence.new{
        ColorSequenceKeypoint.new(0, Config.Colors.Accent),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 100, 200))
    }, 45)
    
    ButtonFrame.MouseEnter:Connect(function()
        CreateTween(ButtonFrame, {BackgroundColor3 = Color3.fromRGB(30, 140, 255)}, 0.2)
    end)
    
    ButtonFrame.MouseLeave:Connect(function()
        CreateTween(ButtonFrame, {BackgroundColor3 = Config.Colors.Accent}, 0.2)
    end)
    
    ButtonFrame.MouseButton1Down:Connect(function()
        CreateTween(ButtonFrame, {Size = UDim2.new(1, -4, 0, 33)}, 0.1)
    end)
    
    ButtonFrame.MouseButton1Up:Connect(function()
        CreateTween(ButtonFrame, {Size = UDim2.new(1, 0, 0, 35)}, 0.1)
    end)
    
    ButtonFrame.MouseButton1Click:Connect(callback)
    
    return ButtonFrame
end

-- Slider
function KelTecLib:CreateSlider(section, name, min, max, default, callback)
    min = min or 0
    max = max or 100
    default = default or min
    callback = callback or function() end
    
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Name = name .. "Slider"
    SliderFrame.Size = UDim2.new(1, 0, 0, 50)
    SliderFrame.BackgroundColor3 = Config.Colors.Background
    SliderFrame.BorderSizePixel = 0
    SliderFrame.Parent = section.Content
    CreateCorner(SliderFrame, 6)
    CreateStroke(SliderFrame, Config.Colors.Border)
    
    local SliderLabel = Instance.new("TextLabel")
    SliderLabel.Name = "SliderLabel"
    SliderLabel.Size = UDim2.new(0.7, 0, 0, 20)
    SliderLabel.Position = UDim2.new(0, 10, 0, 5)
    SliderLabel.BackgroundTransparency = 1
    SliderLabel.Text = name
    SliderLabel.TextColor3 = Config.Colors.Text
    SliderLabel.TextSize = 14
    SliderLabel.Font = Config.Fonts.Main
    SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
    SliderLabel.Parent = SliderFrame
    
    local SliderValue = Instance.new("TextLabel")
    SliderValue.Name = "SliderValue"
    SliderValue.Size = UDim2.new(0.3, -10, 0, 20)
    SliderValue.Position = UDim2.new(0.7, 0, 0, 5)
    SliderValue.BackgroundTransparency = 1
    SliderValue.Text = tostring(default)
    SliderValue.TextColor3 = Config.Colors.Accent
    SliderValue.TextSize = 14
    SliderValue.Font = Config.Fonts.Bold
    SliderValue.TextXAlignment = Enum.TextXAlignment.Right
    SliderValue.Parent = SliderFrame
    
    local SliderTrack = Instance.new("Frame")
    SliderTrack.Name = "SliderTrack"
    SliderTrack.Size = UDim2.new(1, -20, 0, 6)
    SliderTrack.Position = UDim2.new(0, 10, 1, -15)
    SliderTrack.BackgroundColor3 = Config.Colors.Secondary
    SliderTrack.BorderSizePixel = 0
    SliderTrack.Parent = SliderFrame
    CreateCorner(SliderTrack, 3)
    
    local SliderFill = Instance.new("Frame")
    SliderFill.Name = "SliderFill"
    SliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    SliderFill.BackgroundColor3 = Config.Colors.Accent
    SliderFill.BorderSizePixel = 0
    SliderFill.Parent = SliderTrack
    CreateCorner(SliderFill, 3)
    
    local SliderButton = Instance.new("TextButton")
    SliderButton.Name = "SliderButton"
    SliderButton.Size = UDim2.new(0, 16, 0, 16)
    SliderButton.Position = UDim2.new((default - min) / (max - min), -8, 0.5, -8)
    SliderButton.BackgroundColor3 = Config.Colors.Text
    SliderButton.BorderSizePixel = 0
    SliderButton.Text = ""
    SliderButton.Parent = SliderTrack
    CreateCorner(SliderButton, 8)
    CreateStroke(SliderButton, Config.Colors.Accent, 2)
    
    local currentValue = default
    local dragging = false
    
    local function UpdateSlider(inputPos)
        local trackPos = SliderTrack.AbsolutePosition.X
        local trackSize = SliderTrack.AbsoluteSize.X
        local relativePos = math.clamp((inputPos - trackPos) / trackSize, 0, 1)
        
        currentValue = math.floor(min + (relativePos * (max - min)))
        SliderValue.Text = tostring(currentValue)
        
        CreateTween(SliderFill, {Size = UDim2.new(relativePos, 0, 1, 0)}, 0.1)
        CreateTween(SliderButton, {Position = UDim2.new(relativePos, -8, 0.5, -8)}, 0.1)
        
        callback(currentValue)
    end
    
    SliderButton.MouseButton1Down:Connect(function()
        dragging = true
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            UpdateSlider(input.Position.X)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    SliderTrack.MouseButton1Down:Connect(function()
        UpdateSlider(Mouse.X)
    end)
    
    return {
        Frame = SliderFrame,
        SetValue = function(value)
            value = math.clamp(value, min, max)
            currentValue = value
            SliderValue.Text = tostring(value)
            local relativePos = (value - min) / (max - min)
            SliderFill.Size = UDim2.new(relativePos, 0, 1, 0)
            SliderButton.Position = UDim2.new(relativePos, -8, 0.5, -8)
        end,
        GetValue = function()
            return currentValue
        end
    }
end

-- Dropdown Menu
function KelTecLib:CreateDropdown(section, name, options, default, callback)
    options = options or {}
    default = default or (options[1] or "None")
    callback = callback or function() end
    
    local DropdownFrame = Instance.new("Frame")
    DropdownFrame.Name = name .. "Dropdown"
    DropdownFrame.Size = UDim2.new(1, 0, 0, 35)
    DropdownFrame.BackgroundColor3 = Config.Colors.Background
    DropdownFrame.BorderSizePixel = 0
    DropdownFrame.Parent = section.Content
    CreateCorner(DropdownFrame, 6)
    CreateStroke(DropdownFrame, Config.Colors.Border)
    
    local DropdownButton = Instance.new("TextButton")
    DropdownButton.Name = "DropdownButton"
    DropdownButton.Size = UDim2.new(1, 0, 1, 0)
    DropdownButton.BackgroundTransparency = 1
    DropdownButton.Text = name .. ": " .. tostring(default)
    DropdownButton.TextColor3 = Config.Colors.Text
    DropdownButton.TextSize = 14
    DropdownButton.Font = Config.Fonts.Main
    DropdownButton.TextXAlignment = Enum.TextXAlignment.Left
    DropdownButton.Parent = DropdownFrame
    
    local DropdownIcon = Instance.new("TextLabel")
    DropdownIcon.Name = "DropdownIcon"
    DropdownIcon.Size = UDim2.new(0, 20, 1, 0)
    DropdownIcon.Position = UDim2.new(1, -25, 0, 0)
    DropdownIcon.BackgroundTransparency = 1
    DropdownIcon.Text = "▼"
    DropdownIcon.TextColor3 = Config.Colors.TextSecondary
    DropdownIcon.TextSize = 12
    DropdownIcon.Font = Config.Fonts.Main
    DropdownIcon.Parent = DropdownFrame
    
    -- Add padding
    local DropdownPadding = Instance.new("UIPadding")
    DropdownPadding.PaddingLeft = UDim.new(0, 10)
    DropdownPadding.Parent = DropdownButton
    
    local DropdownList = Instance.new("Frame")
    DropdownList.Name = "DropdownList"
    DropdownList.Size = UDim2.new(1, 0, 0, #options * 30)
    DropdownList.Position = UDim2.new(0, 0, 1, 5)
    DropdownList.BackgroundColor3 = Config.Colors.Secondary
    DropdownList.BorderSizePixel = 0
    DropdownList.Visible = false
    DropdownList.ZIndex = 10
    DropdownList.Parent = DropdownFrame
    CreateCorner(DropdownList, 6)
    CreateStroke(DropdownList, Config.Colors.Border)
    
    local DropdownListLayout = Instance.new("UIListLayout")
    DropdownListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    DropdownListLayout.Parent = DropdownList
    
    local currentValue = default
    local isOpen = false
    
    for i, option in ipairs(options) do
        local OptionButton = Instance.new("TextButton")
        OptionButton.Name = "Option" .. i
        OptionButton.Size = UDim2.new(1, 0, 0, 30)
        OptionButton.BackgroundTransparency = 1
        OptionButton.Text = tostring(option)
        OptionButton.TextColor3 = Config.Colors.Text
        OptionButton.TextSize = 13
        OptionButton.Font = Config.Fonts.Main
        OptionButton.TextXAlignment = Enum.TextXAlignment.Left
        OptionButton.Parent = DropdownList
        
        local OptionPadding = Instance.new("UIPadding")
        OptionPadding.PaddingLeft = UDim.new(0, 10)
        OptionPadding.Parent = OptionButton
        
        OptionButton.MouseEnter:Connect(function()
            CreateTween(OptionButton, {BackgroundTransparency = 0.7}, 0.1)
            OptionButton.BackgroundColor3 = Config.Colors.Accent
        end)
        
        OptionButton.MouseLeave:Connect(function()
            CreateTween(OptionButton, {BackgroundTransparency = 1}, 0.1)
        end)
        
        OptionButton.MouseButton1Click:Connect(function()
            currentValue = option
            DropdownButton.Text = name .. ": " .. tostring(option)
            DropdownList.Visible = false
            isOpen = false
            CreateTween(DropdownIcon, {Rotation = 0}, 0.2)
            callback(option)
        end)
    end
    
    DropdownButton.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        DropdownList.Visible = isOpen
        CreateTween(DropdownIcon, {Rotation = isOpen and 180 or 0}, 0.2)
    end)
    
    return {
        Frame = DropdownFrame,
        SetValue = function(value)
            currentValue = value
            DropdownButton.Text = name .. ": " .. tostring(value)
        end,
        GetValue = function()
            return currentValue
        end
    }
end

-- Color Picker
function KelTecLib:CreateColorPicker(section, name, default, callback)
    default = default or Color3.fromRGB(255, 255, 255)
    callback = callback or function() end
    
    local ColorFrame = Instance.new("Frame")
    ColorFrame.Name = name .. "ColorPicker"
    ColorFrame.Size = UDim2.new(1, 0, 0, 35)
    ColorFrame.BackgroundColor3 = Config.Colors.Background
    ColorFrame.BorderSizePixel = 0
    ColorFrame.Parent = section.Content
    CreateCorner(ColorFrame, 6)
    CreateStroke(ColorFrame, Config.Colors.Border)
    
    local ColorLabel = Instance.new("TextLabel")
    ColorLabel.Name = "ColorLabel"
    ColorLabel.Size = UDim2.new(1, -45, 1, 0)
    ColorLabel.Position = UDim2.new(0, 10, 0, 0)
    ColorLabel.BackgroundTransparency = 1
    ColorLabel.Text = name
    ColorLabel.TextColor3 = Config.Colors.Text
    ColorLabel.TextSize = 14
    ColorLabel.Font = Config.Fonts.Main
    ColorLabel.TextXAlignment = Enum.TextXAlignment.Left
    ColorLabel.Parent = ColorFrame
    
    local ColorPreview = Instance.new("TextButton")
    ColorPreview.Name = "ColorPreview"
    ColorPreview.Size = UDim2.new(0, 25, 0, 25)
    ColorPreview.Position = UDim2.new(1, -35, 0.5, -12.5)
    ColorPreview.BackgroundColor3 = default
    ColorPreview.BorderSizePixel = 0
    ColorPreview.Text = ""
    ColorPreview.Parent = ColorFrame
    CreateCorner(ColorPreview, 4)
    CreateStroke(ColorPreview, Config.Colors.Border)
    
    local currentColor = default
    
    ColorPreview.MouseButton1Click:Connect(function()
        -- Simple color picker (cycling through preset colors)
        local colors = {
            Color3.fromRGB(255, 255, 255), -- White
            Color3.fromRGB(255, 0, 0),     -- Red
            Color3.fromRGB(0, 255, 0),     -- Green
            Color3.fromRGB(0, 0, 255),     -- Blue
            Color3.fromRGB(255, 255, 0),   -- Yellow
            Color3.fromRGB(255, 0, 255),   -- Magenta
            Color3.fromRGB(0, 255, 255),   -- Cyan
            Color3.fromRGB(0, 0, 0),       -- Black
        }
        
        local currentIndex = 1
        for i, color in ipairs(colors) do
            if color == currentColor then
                currentIndex = i
                break
            end
        end
        
        local nextIndex = (currentIndex % #colors) + 1
        currentColor = colors[nextIndex]
        
        CreateTween(ColorPreview, {BackgroundColor3 = currentColor}, 0.2)
        callback(currentColor)
    end)
    
    return {
        Frame = ColorFrame,
        SetValue = function(value)
            currentColor = value
            ColorPreview.BackgroundColor3 = value
        end,
        GetValue = function()
            return currentColor
        end
    }
end

-- Paragraph/Text Display
function KelTecLib:CreateParagraph(section, title, text)
    local ParagraphFrame = Instance.new("Frame")
    ParagraphFrame.Name = title .. "Paragraph"
    ParagraphFrame.Size = UDim2.new(1, 0, 0, 0)
    ParagraphFrame.BackgroundColor3 = Config.Colors.Background
    ParagraphFrame.BorderSizePixel = 0
    ParagraphFrame.AutomaticSize = Enum.AutomaticSize.Y
    ParagraphFrame.Parent = section.Content
    CreateCorner(ParagraphFrame, 6)
    CreateStroke(ParagraphFrame, Config.Colors.Border)
    
    local ParagraphTitle = Instance.new("TextLabel")
    ParagraphTitle.Name = "ParagraphTitle"
    ParagraphTitle.Size = UDim2.new(1, -20, 0, 25)
    ParagraphTitle.Position = UDim2.new(0, 10, 0, 8)
    ParagraphTitle.BackgroundTransparency = 1
    ParagraphTitle.Text = title
    ParagraphTitle.TextColor3 = Config.Colors.Text
    ParagraphTitle.TextSize = 15
    ParagraphTitle.Font = Config.Fonts.Bold
    ParagraphTitle.TextXAlignment = Enum.TextXAlignment.Left
    ParagraphTitle.Parent = ParagraphFrame
    
    local ParagraphText = Instance.new("TextLabel")
    ParagraphText.Name = "ParagraphText"
    ParagraphText.Size = UDim2.new(1, -20, 0, 0)
    ParagraphText.Position = UDim2.new(0, 10, 0, 35)
    ParagraphText.BackgroundTransparency = 1
    ParagraphText.Text = text
    ParagraphText.TextColor3 = Config.Colors.TextSecondary
    ParagraphText.TextSize = 13
    ParagraphText.Font = Config.Fonts.Main
    ParagraphText.TextXAlignment = Enum.TextXAlignment.Left
    ParagraphText.TextYAlignment = Enum.TextYAlignment.Top
    ParagraphText.TextWrapped = true
    ParagraphText.AutomaticSize = Enum.AutomaticSize.Y
    ParagraphText.Parent = ParagraphFrame
    
    -- Add padding
    local ParagraphPadding = Instance.new("UIPadding")
    ParagraphPadding.PaddingBottom = UDim.new(0, 10)
    ParagraphPadding.Parent = ParagraphFrame
    
    return {
        Frame = ParagraphFrame,
        SetText = function(newText)
            ParagraphText.Text = newText
        end,
        SetTitle = function(newTitle)
            ParagraphTitle.Text = newTitle
        end
    }
end

-- Helper method to update tab content size
local function UpdateTabContentSize(tab)
    local leftHeight = tab.LeftColumn.AbsoluteContentSize.Y
    local rightHeight = tab.RightColumn.AbsoluteContentSize.Y
    local maxHeight = math.max(leftHeight, rightHeight)
    
    tab.ColumnContainer.Size = UDim2.new(1, 0, 0, maxHeight)
    tab.Content.CanvasSize = UDim2.new(0, 0, 0, maxHeight + 20)
end

-- Auto-update content sizes
RunService.Heartbeat:Connect(function()
    for _, gui in pairs(getgenv().KelTecGuis or {}) do
        for _, tab in pairs(gui.Tabs) do
            UpdateTabContentSize(tab)
        end
    end
end)

-- Store GUI instances globally for cleanup
if not getgenv().KelTecGuis then
    getgenv().KelTecGuis = {}
end
