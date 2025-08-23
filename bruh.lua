--[[
    KelTec GUI Library - Complete Version
    Version: 1.0.0
    Author: KelTec Team
    
    A modern, feature-rich GUI library for Roblox
]]

local KelTecLib = {}

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")

-- Variables
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

-- Library Configuration
local Config = {
    WindowSize = {X = 600, Y = 500},
    Colors = {
        Primary = Color3.fromRGB(30, 30, 30),
        Secondary = Color3.fromRGB(40, 40, 40),
        Accent = Color3.fromRGB(0, 122, 255),
        Background = Color3.fromRGB(20, 20, 20),
        Text = Color3.fromRGB(255, 255, 255),
        TextSecondary = Color3.fromRGB(180, 180, 180),
        Border = Color3.fromRGB(60, 60, 60),
        Success = Color3.fromRGB(52, 199, 89),
        Warning = Color3.fromRGB(255, 149, 0),
        Error = Color3.fromRGB(255, 69, 58)
    },
    Fonts = {
        Main = Enum.Font.Gotham,
        Bold = Enum.Font.GothamBold
    },
    Animations = {
        Speed = 0.3,
        Style = Enum.EasingStyle.Quad,
        Direction = Enum.EasingDirection.Out
    }
}

-- Utility Functions
local function CreateTween(object, properties, duration, style, direction)
    duration = duration or Config.Animations.Speed
    style = style or Config.Animations.Style
    direction = direction or Config.Animations.Direction
    
    local tween = TweenService:Create(object, TweenInfo.new(duration, style, direction), properties)
    tween:Play()
    return tween
end

local function CreateCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 6)
    corner.Parent = parent
    return corner
end

local function CreateStroke(parent, color, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or Config.Colors.Border
    stroke.Thickness = thickness or 1
    stroke.Parent = parent
    return stroke
end

local function CreateGradient(parent, colors, rotation)
    local gradient = Instance.new("UIGradient")
    gradient.Color = colors or ColorSequence.new{
        ColorSequenceKeypoint.new(0, Config.Colors.Primary),
        ColorSequenceKeypoint.new(1, Config.Colors.Secondary)
    }
    gradient.Rotation = rotation or 0
    gradient.Parent = parent
    return gradient
end

-- Loading Screen
function KelTecLib.ShowLoader(title, duration)
    duration = duration or 3
    
    local LoaderGui = Instance.new("ScreenGui")
    LoaderGui.Name = "KelTecLoader"
    LoaderGui.Parent = CoreGui
    LoaderGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    local Background = Instance.new("Frame")
    Background.Name = "Background"
    Background.Size = UDim2.new(1, 0, 1, 0)
    Background.BackgroundColor3 = Config.Colors.Background
    Background.BorderSizePixel = 0
    Background.Parent = LoaderGui
    
    local LoadingFrame = Instance.new("Frame")
    LoadingFrame.Name = "LoadingFrame"
    LoadingFrame.Size = UDim2.new(0, 400, 0, 200)
    LoadingFrame.Position = UDim2.new(0.5, -200, 0.5, -100)
    LoadingFrame.BackgroundColor3 = Config.Colors.Primary
    LoadingFrame.BorderSizePixel = 0
    LoadingFrame.Parent = Background
    CreateCorner(LoadingFrame, 12)
    CreateStroke(LoadingFrame, Config.Colors.Border, 2)
    
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(1, -40, 0, 50)
    Title.Position = UDim2.new(0, 20, 0, 30)
    Title.BackgroundTransparency = 1
    Title.Text = title or "KelTec GUI Library"
    Title.TextColor3 = Config.Colors.Text
    Title.TextSize = 24
    Title.Font = Config.Fonts.Bold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = LoadingFrame
    
    local ProgressBar = Instance.new("Frame")
    ProgressBar.Name = "ProgressBar"
    ProgressBar.Size = UDim2.new(1, -40, 0, 6)
    ProgressBar.Position = UDim2.new(0, 20, 0, 120)
    ProgressBar.BackgroundColor3 = Config.Colors.Secondary
    ProgressBar.BorderSizePixel = 0
    ProgressBar.Parent = LoadingFrame
    CreateCorner(ProgressBar, 3)
    
    local ProgressFill = Instance.new("Frame")
    ProgressFill.Name = "ProgressFill"
    ProgressFill.Size = UDim2.new(0, 0, 1, 0)
    ProgressFill.BackgroundColor3 = Config.Colors.Accent
    ProgressFill.BorderSizePixel = 0
    ProgressFill.Parent = ProgressBar
    CreateCorner(ProgressFill, 3)
    CreateGradient(ProgressFill, ColorSequence.new{
        ColorSequenceKeypoint.new(0, Config.Colors.Accent),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 200, 255))
    }, 45)
    
    local StatusText = Instance.new("TextLabel")
    StatusText.Name = "StatusText"
    StatusText.Size = UDim2.new(1, -40, 0, 30)
    StatusText.Position = UDim2.new(0, 20, 0, 140)
    StatusText.BackgroundTransparency = 1
    StatusText.Text = "Loading components..."
    StatusText.TextColor3 = Config.Colors.TextSecondary
    StatusText.TextSize = 14
    StatusText.Font = Config.Fonts.Main
    StatusText.TextXAlignment = Enum.TextXAlignment.Left
    StatusText.Parent = LoadingFrame
    
    -- Animate loading
    local loadingSteps = {
        "Initializing library...",
        "Loading components...",
        "Setting up interface...",
        "Finalizing setup...",
        "Ready!"
    }
    
    spawn(function()
        for i, step in ipairs(loadingSteps) do
            StatusText.Text = step
            CreateTween(ProgressFill, {Size = UDim2.new(i/#loadingSteps, 0, 1, 0)}, 0.5)
            wait(duration / #loadingSteps)
        end
        
        wait(0.5)
        CreateTween(LoaderGui, {BackgroundTransparency = 1}, 0.5)
        CreateTween(LoadingFrame, {
            BackgroundTransparency = 1,
            Position = UDim2.new(0.5, -200, 0.5, -150)
        }, 0.5)
        
        for _, child in pairs(LoadingFrame:GetChildren()) do
            if child:IsA("GuiObject") then
                CreateTween(child, {BackgroundTransparency = 1}, 0.5)
                if child:IsA("TextLabel") then
                    CreateTween(child, {TextTransparency = 1}, 0.5)
                end
            end
        end
        
        wait(0.6)
        LoaderGui:Destroy()
    end)
end

-- Main GUI Class
local GUI = {}
GUI.__index = GUI

-- Constructor
function KelTecLib.new(config)
    local self = setmetatable({}, GUI)
    
    -- Configuration
    config = config or {}
    self.WindowSize = config.WindowSize or Config.WindowSize
    self.Title = config.Title or "KelTec GUI"
    self.ToggleKey = config.ToggleKey or Enum.KeyCode.RightShift
    self.Tabs = {}
    self.Elements = {}
    self.Visible = true
    
    -- Create Main GUI
    self:CreateMainGui()
    self:SetupToggle()
    
    return self
end

function GUI:CreateMainGui()
    -- Main ScreenGui
    self.Gui = Instance.new("ScreenGui")
    self.Gui.Name = "KelTecGui"
    self.Gui.Parent = CoreGui
    self.Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    self.Gui.ResetOnSpawn = false
    
    -- Main Window
    self.MainFrame = Instance.new("Frame")
    self.MainFrame.Name = "MainFrame"
    self.MainFrame.Size = UDim2.new(0, self.WindowSize.X, 0, self.WindowSize.Y)
    self.MainFrame.Position = UDim2.new(0.5, -self.WindowSize.X/2, 0.5, -self.WindowSize.Y/2)
    self.MainFrame.BackgroundColor3 = Config.Colors.Primary
    self.MainFrame.BorderSizePixel = 0
    self.MainFrame.Active = true
    self.MainFrame.Draggable = true
    self.MainFrame.Parent = self.Gui
    CreateCorner(self.MainFrame, 12)
    CreateStroke(self.MainFrame, Config.Colors.Border, 2)
    
    -- Title Bar
    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.Size = UDim2.new(1, 0, 0, 50)
    TitleBar.BackgroundColor3 = Config.Colors.Secondary
    TitleBar.BorderSizePixel = 0
    TitleBar.Parent = self.MainFrame
    CreateCorner(TitleBar, 12)
    CreateStroke(TitleBar, Config.Colors.Border)
    
    -- Fix corner for title bar
    local TitleBarCornerFix = Instance.new("Frame")
    TitleBarCornerFix.Size = UDim2.new(1, 0, 0, 12)
    TitleBarCornerFix.Position = UDim2.new(0, 0, 1, -12)
    TitleBarCornerFix.BackgroundColor3 = Config.Colors.Secondary
    TitleBarCornerFix.BorderSizePixel = 0
    TitleBarCornerFix.Parent = TitleBar
    
    -- Title Text
    local TitleText = Instance.new("TextLabel")
    TitleText.Name = "TitleText"
    TitleText.Size = UDim2.new(1, -100, 1, 0)
    TitleText.Position = UDim2.new(0, 20, 0, 0)
    TitleText.BackgroundTransparency = 1
    TitleText.Text = self.Title
    TitleText.TextColor3 = Config.Colors.Text
    TitleText.TextSize = 18
    TitleText.Font = Config.Fonts.Bold
    TitleText.TextXAlignment = Enum.TextXAlignment.Left
    TitleText.Parent = TitleBar
    
    -- Close Button
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -40, 0.5, -15)
    CloseButton.BackgroundColor3 = Config.Colors.Error
    CloseButton.BorderSizePixel = 0
    CloseButton.Text = "×"
    CloseButton.TextColor3 = Config.Colors.Text
    CloseButton.TextSize = 18
    CloseButton.Font = Config.Fonts.Bold
    CloseButton.Parent = TitleBar
    CreateCorner(CloseButton, 6)
    
    CloseButton.MouseButton1Click:Connect(function()
        self:Toggle()
    end)
    
    -- Tab Container
    self.TabContainer = Instance.new("Frame")
    self.TabContainer.Name = "TabContainer"
    self.TabContainer.Size = UDim2.new(0, 150, 1, -60)
    self.TabContainer.Position = UDim2.new(0, 10, 0, 60)
    self.TabContainer.BackgroundColor3 = Config.Colors.Secondary
    self.TabContainer.BorderSizePixel = 0
    self.TabContainer.Parent = self.MainFrame
    CreateCorner(self.TabContainer, 8)
    CreateStroke(self.TabContainer, Config.Colors.Border)
    
    -- Tab List
    self.TabList = Instance.new("ScrollingFrame")
    self.TabList.Name = "TabList"
    self.TabList.Size = UDim2.new(1, -10, 1, -10)
    self.TabList.Position = UDim2.new(0, 5, 0, 5)
    self.TabList.BackgroundTransparency = 1
    self.TabList.BorderSizePixel = 0
    self.TabList.ScrollBarThickness = 4
    self.TabList.ScrollBarImageColor3 = Config.Colors.Accent
    self.TabList.CanvasSize = UDim2.new(0, 0, 0, 0)
    self.TabList.Parent = self.TabContainer
    
    local TabListLayout = Instance.new("UIListLayout")
    TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabListLayout.Padding = UDim.new(0, 5)
    TabListLayout.Parent = self.TabList
    
    -- Content Container
    self.ContentContainer = Instance.new("Frame")
    self.ContentContainer.Name = "ContentContainer"
    self.ContentContainer.Size = UDim2.new(1, -180, 1, -60)
    self.ContentContainer.Position = UDim2.new(0, 170, 0, 60)
    self.ContentContainer.BackgroundTransparency = 1
    self.ContentContainer.Parent = self.MainFrame
end

function GUI:SetupToggle()
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == self.ToggleKey then
            self:Toggle()
        end
    end)
end

function GUI:Toggle()
    self.Visible = not self.Visible
    CreateTween(self.MainFrame, {
        Position = self.Visible and UDim2.new(0.5, -self.WindowSize.X/2, 0.5, -self.WindowSize.Y/2) or UDim2.new(0.5, -self.WindowSize.X/2, 1, 50)
    }, 0.4, Enum.EasingStyle.Back)
end

function GUI:CreateTab(name, icon)
    local tab = {
        Name = name,
        Icon = icon,
        Sections = {},
        Active = false
    }
    
    -- Tab Button
    local TabButton = Instance.new("TextButton")
    TabButton.Name = name .. "Tab"
    TabButton.Size = UDim2.new(1, 0, 0, 35)
    TabButton.BackgroundColor3 = Config.Colors.Primary
    TabButton.BorderSizePixel = 0
    TabButton.Text = (icon and icon .. " " or "") .. name
    TabButton.TextColor3 = Config.Colors.TextSecondary
    TabButton.TextSize = 14
    TabButton.Font = Config.Fonts.Main
    TabButton.Parent = self.TabList
    CreateCorner(TabButton, 6)
    
    -- Tab Content
    local TabContent = Instance.new("ScrollingFrame")
    TabContent.Name = name .. "Content"
    TabContent.Size = UDim2.new(1, 0, 1, 0)
    TabContent.BackgroundTransparency = 1
    TabContent.BorderSizePixel = 0
    TabContent.ScrollBarThickness = 4
    TabContent.ScrollBarImageColor3 = Config.Colors.Accent
    TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabContent.Visible = false
    TabContent.Parent = self.ContentContainer
    
    -- Two Column Container
    local ColumnContainer = Instance.new("Frame")
    ColumnContainer.Name = "ColumnContainer"
    ColumnContainer.Size = UDim2.new(1, 0, 0, 0)
    ColumnContainer.BackgroundTransparency = 1
    ColumnContainer.AutomaticSize = Enum.AutomaticSize.Y
    ColumnContainer.Parent = TabContent
    
    -- Left Column
    local LeftColumn = Instance.new("Frame")
    LeftColumn.Name = "LeftColumn"
    LeftColumn.Size = UDim2.new(0.48, 0, 0, 0)
    LeftColumn.Position = UDim2.new(0, 0, 0, 0)
    LeftColumn.BackgroundTransparency = 1
    LeftColumn.AutomaticSize = Enum.AutomaticSize.Y
    LeftColumn.Parent = ColumnContainer
    
    local LeftLayout = Instance.new("UIListLayout")
    LeftLayout.SortOrder = Enum.SortOrder.LayoutOrder
    LeftLayout.Padding = UDim.new(0, 10)
    LeftLayout.Parent = LeftColumn
    
    -- Right Column
    local RightColumn = Instance.new("Frame")
    RightColumn.Name = "RightColumn"
    RightColumn.Size = UDim2.new(0.48, 0, 0, 0)
    RightColumn.Position = UDim2.new(0.52, 0, 0, 0)
    RightColumn.BackgroundTransparency = 1
    RightColumn.AutomaticSize = Enum.AutomaticSize.Y
    RightColumn.Parent = ColumnContainer
    
    local RightLayout = Instance.new("UIListLayout")
    RightLayout.SortOrder = Enum.SortOrder.LayoutOrder
    RightLayout.Padding = UDim.new(0, 10)
    RightLayout.Parent = RightColumn
    
    tab.Button = TabButton
    tab.Content = TabContent
    tab.LeftColumn = LeftColumn
    tab.RightColumn = RightColumn
    tab.ColumnContainer = ColumnContainer
    
    -- Tab Click Event
    TabButton.MouseButton1Click:Connect(function()
        self:SelectTab(tab)
    end)
    
    -- Hover Effects
    TabButton.MouseEnter:Connect(function()
        if not tab.Active then
            CreateTween(TabButton, {BackgroundColor3 = Config.Colors.Secondary}, 0.2)
        end
    end)
    
    TabButton.MouseLeave:Connect(function()
        if not tab.Active then
            CreateTween(TabButton, {BackgroundColor3 = Config.Colors.Primary}, 0.2)
        end
    end)
    
    table.insert(self.Tabs, tab)
    
    -- Auto-select first tab
    if #self.Tabs == 1 then
        self:SelectTab(tab)
    end
    
    -- Update tab list size
    self.TabList.CanvasSize = UDim2.new(0, 0, 0, #self.Tabs * 40)
    
    return tab
end

function GUI:SelectTab(selectedTab)
    for _, tab in pairs(self.Tabs) do
        tab.Active = false
        tab.Content.Visible = false
        CreateTween(tab.Button, {
            BackgroundColor3 = Config.Colors.Primary,
            TextColor3 = Config.Colors.TextSecondary
        }, 0.2)
    end
    
    selectedTab.Active = true
    selectedTab.Content.Visible = true
    CreateTween(selectedTab.Button, {
        BackgroundColor3 = Config.Colors.Accent,
        TextColor3 = Config.Colors.Text
    }, 0.2)
end

function GUI:CreateSection(tab, name, column)
    column = column or "left"
    local targetColumn = column == "left" and tab.LeftColumn or tab.RightColumn
    
    local section = {
        Name = name,
        Elements = {},
        Container = targetColumn
    }
    
    -- Section Frame
    local SectionFrame = Instance.new("Frame")
    SectionFrame.Name = name .. "Section"
    SectionFrame.Size = UDim2.new(1, 0, 0, 0)
    SectionFrame.BackgroundColor3 = Config.Colors.Secondary
    SectionFrame.BorderSizePixel = 0
    SectionFrame.AutomaticSize = Enum.AutomaticSize.Y
    SectionFrame.Parent = targetColumn
    CreateCorner(SectionFrame, 8)
    CreateStroke(SectionFrame, Config.Colors.Border)
    
    -- Section Header
    local SectionHeader = Instance.new("TextLabel")
    SectionHeader.Name = "SectionHeader"
    SectionHeader.Size = UDim2.new(1, -20, 0, 35)
    SectionHeader.Position = UDim2.new(0, 10, 0, 5)
    SectionHeader.BackgroundTransparency = 1
    SectionHeader.Text = name
    SectionHeader.TextColor3 = Config.Colors.Text
    SectionHeader.TextSize = 16
    SectionHeader.Font = Config.Fonts.Bold
    SectionHeader.TextXAlignment = Enum.TextXAlignment.Left
    SectionHeader.Parent = SectionFrame
    
    -- Section Content
    local SectionContent = Instance.new("Frame")
    SectionContent.Name = "SectionContent"
    SectionContent.Size = UDim2.new(1, -20, 0, 0)
    SectionContent.Position = UDim2.new(0, 10, 0, 40)
    SectionContent.BackgroundTransparency = 1
    SectionContent.AutomaticSize = Enum.AutomaticSize.Y
    SectionContent.Parent = SectionFrame
    
    local SectionLayout = Instance.new("UIListLayout")
    SectionLayout.SortOrder = Enum.SortOrder.LayoutOrder
    SectionLayout.Padding = UDim.new(0, 8)
    SectionLayout.Parent = SectionContent
    
    -- Add padding to section frame
    local SectionPadding = Instance.new("UIPadding")
    SectionPadding.PaddingBottom = UDim.new(0, 10)
    SectionPadding.Parent = SectionFrame
    
    section.Frame = SectionFrame
    section.Content = SectionContent
    
    table.insert(tab.Sections, section)
    
    return section
end

-- UI ELEMENT METHODS --

-- Toggle Button
function GUI:CreateToggle(section, name, default, callback)
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
function GUI:CreateButton(section, name, callback)
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
    
    ButtonFrame.MouseEnter:Connect(function()
        CreateTween(ButtonFrame, {BackgroundColor3 = Color3.fromRGB(30, 140, 255)}, 0.2)
    end)
    
    ButtonFrame.MouseLeave:Connect(function()
        CreateTween(ButtonFrame, {BackgroundColor3 = Config.Colors.Accent}, 0.2)
    end)
    
    ButtonFrame.MouseButton1Click:Connect(callback)
    
    return ButtonFrame
end

-- Slider
function GUI:CreateSlider(section, name, min, max, default, callback)
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
function GUI:CreateDropdown(section, name, options, default, callback)
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
    DropdownButton.Size = UDim2.new(1, -30, 1, 0)
    DropdownButton.BackgroundTransparency = 1
    DropdownButton.Text = name .. ": " .. tostring(default)
    DropdownButton.TextColor3 = Config.Colors.Text
    DropdownButton.TextSize = 14
    DropdownButton.Font = Config.Fonts.Main
    DropdownButton.TextXAlignment = Enum.TextXAlignment.Left
    DropdownButton.Parent = DropdownFrame
    
    local DropdownPadding = Instance.new("UIPadding")
    DropdownPadding.PaddingLeft = UDim.new(0, 10)
    DropdownPadding.Parent = DropdownButton
    
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
function GUI:CreateColorPicker(section, name, default, callback)
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
        local colors = {
            Color3.fromRGB(255, 255, 255),
            Color3.fromRGB(255, 0, 0),
            Color3.fromRGB(0, 255, 0),
            Color3.fromRGB(0, 0, 255),
            Color3.fromRGB(255, 255, 0),
            Color3.fromRGB(255, 0, 255),
            Color3.fromRGB(0, 255, 255),
            Color3.fromRGB(0, 0, 0),
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

-- Paragraph
function GUI:CreateParagraph(section, title, text)
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

return KelTecLib
