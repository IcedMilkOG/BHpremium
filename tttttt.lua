
-- ciazware_ui_library.lua
local library = {
    version = "1.0",
    configuration = {
        frames = {
            MainBackFrameColor = Color3.fromRGB(138, 138, 138),
            BorderColor = Color3.fromRGB(50, 50, 50),
            InlineBorderColor = Color3.fromRGB(10, 10, 10),
        },
        elements = {
            BorderColor = Color3.fromRGB(50, 50, 50),
            InlineBorderColor = Color3.fromRGB(10, 10, 10),
        },
        text = {
            Color = Color3.fromRGB(255, 255, 255),
            Font = Enum.Font.Code,
        },
        miscellaneous = {
            BackgroundGlowColor = Color3.fromRGB(255, 255, 255),
            TabHighlightColor = Color3.fromRGB(30, 30, 30),
            DisplayFpsAndPing = true,
            UIToggleKey = Enum.KeyCode.RightAlt,
        },
    },
}

-- Services and utilities
local game, Instance, Color3, UDim2, Rect, Vector2 = game, Instance, Color3, UDim2, Rect, Vector2
local CoreGui, TweenService, TextService, UserInputService, RunService = game:GetService("CoreGui"), game:GetService("TweenService"), game:GetService("TextService"), game:GetService("UserInputService"), game:GetService("RunService")

-- Wait for game to load
if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- Protect GUI
local function protect_gui(Gui, Parent)
    if syn then
        syn.protect_gui(Gui)
        Gui.Parent = Parent
    elseif gethui then
        Gui.Parent = gethui()
    else
        Gui.Parent = Parent
    end
end

-- Utility functions
local patches = {}
function patches.FixTextSize(Object, FixSize)
    local TextSize = TextService:GetTextSize(
        Object.Text, Object.TextSize, Object.Font, Vector2.new(workspace.CurrentCamera.ViewportSize.X, Object.AbsoluteSize.Y)
    ).X
    Object.Size = UDim2.new(0, TextSize + FixSize, 0, Object.Size.Y.Offset)
end

function patches.FadeObject(Object, Speed, Value, Custom)
    local Property = Custom and "BackgroundColor3" or "BackgroundTransparency"
    local TweenInfo = TweenInfo.new(Speed, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
    local Tween = TweenService:Create(Object, TweenInfo, { [Property] = Value })
    Tween:Play()
end

-- Configuration
local configuration = library.configuration
local frames = configuration.frames
local FrameBorderColor, FrameInlineBorderColor, MainBackFrameColor = frames.BorderColor, frames.InlineBorderColor, frames.MainBackFrameColor
local elements = configuration.elements
local ElementBorderColor, ElementsInlineBorderColor = elements.BorderColor, elements.InlineBorderColor
local text = configuration.text
local TextColor, TextFont = text.Color, text.Font
local BackgroundGlowColor, TabHighlightColor, DisplayFpsAndPing, UIToggleKey = configuration.miscellaneous.BackgroundGlowColor, configuration.miscellaneous.TabHighlightColor, configuration.miscellaneous.DisplayFpsAndPing, configuration.miscellaneous.UIToggleKey

-- UI creation function
function library.new(name)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
    ScreenGui.ResetOnSpawn = false
    protect_gui(ScreenGui, CoreGui)

    if not name then -- Key system UI
        local BackFrame = Instance.new("Frame")
        BackFrame.Name = "BackFrame"
        BackFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        BackFrame.BorderColor3 = Color3.fromRGB(20, 20, 20)
        BackFrame.BorderSizePixel = 2
        BackFrame.Position = UDim2.new(0.098, 0, 0.083, 0)
        BackFrame.Size = UDim2.new(0, 350, 0, 300)
        BackFrame.Draggable = true
        BackFrame.Selectable = true
        BackFrame.Active = true
        BackFrame.Parent = ScreenGui

        local BackFrame_UIStroke = Instance.new("UIStroke")
        BackFrame_UIStroke.Name = "BackFrame_UIStroke"
        BackFrame_UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        BackFrame_UIStroke.Color = MainBackFrameColor
        BackFrame_UIStroke.LineJoinMode = Enum.LineJoinMode.Miter
        BackFrame_UIStroke.Thickness = 1
        BackFrame_UIStroke.Transparency = 0
        BackFrame_UIStroke.Enabled = true
        BackFrame_UIStroke.Parent = BackFrame

        local MainFrame = Instance.new("Frame")
        MainFrame.Name = "MainFrame"
        MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        MainFrame.BorderColor3 = FrameBorderColor
        MainFrame.BorderSizePixel = 2
        MainFrame.Position = UDim2.new(0.0286, 0, 0.0667, 0)
        MainFrame.Size = UDim2.new(0, 330, 0, 280)
        MainFrame.Parent = BackFrame

        local MainFrame_UIStroke = Instance.new("UIStroke")
        MainFrame_UIStroke.Name = "MainFrame_UIStroke"
        MainFrame_UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        MainFrame_UIStroke.Color = FrameInlineBorderColor
        MainFrame_UIStroke.LineJoinMode = Enum.LineJoinMode.Miter
        MainFrame_UIStroke.Thickness = 1
        MainFrame_UIStroke.Transparency = 0
        MainFrame_UIStroke.Enabled = true
        MainFrame_UIStroke.Parent = MainFrame

        local Shadow = Instance.new("ImageLabel")
        Shadow.Name = "Shadow"
        Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
        Shadow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Shadow.BackgroundTransparency = 1
        Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
        Shadow.Size = UDim2.new(1, 45, 1, 45)
        Shadow.ZIndex = 0
        Shadow.Image = "rbxassetid://2654849154"
        Shadow.ImageRectOffset = Vector2.new(2, 2)
        Shadow.ImageRectSize = Vector2.new(252, 252)
        Shadow.ImageTransparency = 0.4
        Shadow.ScaleType = Enum.ScaleType.Slice
        Shadow.SliceCenter = Rect.new(64, 64, 192, 192)
        Shadow.SliceScale = 0.31
        Shadow.ImageColor3 = BackgroundGlowColor
        Shadow.Parent = BackFrame

        local KeyLabel = Instance.new("TextLabel")
        KeyLabel.Name = "KeyLabel"
        KeyLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        KeyLabel.BackgroundTransparency = 1
        KeyLabel.Position = UDim2.new(0.5, -100, 0.2, 0)
        KeyLabel.Size = UDim2.new(0, 200, 0, 36)
        KeyLabel.Font = TextFont
        KeyLabel.Text = "  Keltec ROST\n\n"
        KeyLabel.TextColor3 = TextColor
        KeyLabel.TextSize = 25
        KeyLabel.TextXAlignment = Enum.TextXAlignment.Center
        KeyLabel.RichText = true
        KeyLabel.Parent = MainFrame
        patches.FixTextSize(KeyLabel, 20)

        local TextBox = Instance.new("TextBox")
        TextBox.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        TextBox.BorderColor3 = ElementBorderColor
        TextBox.BorderSizePixel = 2
        TextBox.Position = UDim2.new(0.1, 0, 0.3, 0)
        TextBox.Size = UDim2.new(0, 280, 0, 30)
        TextBox.Font = TextFont
        TextBox.Text = ""
        TextBox.TextColor3 = TextColor
        TextBox.TextSize = 14
        TextBox.Active = true
        TextBox.ZIndex = 2
        TextBox.Parent = MainFrame

        local TextBox_UIStroke = Instance.new("UIStroke")
        TextBox_UIStroke.Name = "TextBox_UIStroke"
        TextBox_UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        TextBox_UIStroke.Color = ElementsInlineBorderColor
        TextBox_UIStroke.LineJoinMode = Enum.LineJoinMode.Miter
        TextBox_UIStroke.Thickness = 1
        TextBox_UIStroke.Transparency = 0
        TextBox_UIStroke.Enabled = true
        TextBox_UIStroke.Parent = TextBox

        local GetKeyButton = Instance.new("TextButton")
        GetKeyButton.Name = "GetKeyButton"
        GetKeyButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        GetKeyButton.BorderColor3 = ElementBorderColor
        GetKeyButton.BorderSizePixel = 2
        GetKeyButton.Position = UDim2.new(0.1, 0, 0.5, 0)
        GetKeyButton.Size = UDim2.new(0, 130, 0, 30)
        GetKeyButton.Font = TextFont
        GetKeyButton.Text = "Get Key"
        GetKeyButton.TextColor3 = TextColor
        GetKeyButton.TextSize = 14
        GetKeyButton.Active = true
        GetKeyButton.ZIndex = 2
        GetKeyButton.Parent = MainFrame

        local GetKeyButton_UIStroke = Instance.new("UIStroke")
        GetKeyButton_UIStroke.Name = "GetKeyButton_UIStroke"
        GetKeyButton_UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        GetKeyButton_UIStroke.Color = ElementsInlineBorderColor
        GetKeyButton_UIStroke.LineJoinMode = Enum.LineJoinMode.Miter
        GetKeyButton_UIStroke.Thickness = 1
        GetKeyButton_UIStroke.Transparency = 0
        GetKeyButton_UIStroke.Enabled = true
        GetKeyButton_UIStroke.Parent = GetKeyButton

        local CheckKeyButton = Instance.new("TextButton")
        CheckKeyButton.Name = "CheckKeyButton"
        CheckKeyButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        CheckKeyButton.BorderColor3 = ElementBorderColor
        CheckKeyButton.BorderSizePixel = 2
        CheckKeyButton.Position = UDim2.new(0.53, 0, 0.5, 0)
        CheckKeyButton.Size = UDim2.new(0, 130, 0, 30)
        CheckKeyButton.Font = TextFont
        CheckKeyButton.Text = "Check Key"
        CheckKeyButton.TextColor3 = TextColor
        CheckKeyButton.TextSize = 14
        CheckKeyButton.Active = true
        CheckKeyButton.ZIndex = 2
        CheckKeyButton.Parent = MainFrame

        local CheckKeyButton_UIStroke = Instance.new("UIStroke")
        CheckKeyButton_UIStroke.Name = "CheckKeyButton_UIStroke"
        CheckKeyButton_UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        CheckKeyButton_UIStroke.Color = ElementsInlineBorderColor
        CheckKeyButton_UIStroke.LineJoinMode = Enum.LineJoinMode.Miter
        CheckKeyButton_UIStroke.Thickness = 1
        CheckKeyButton_UIStroke.Transparency = 0
        CheckKeyButton_UIStroke.Enabled = true
        CheckKeyButton_UIStroke.Parent = CheckKeyButton

        return {
            ScreenGui = ScreenGui,
            TextBox = TextBox,
            GetKeyButton = GetKeyButton,
            CheckKeyButton = CheckKeyButton
        }
    else -- Main UI
        local IsToolTipActive = false
        local ActiveToolTip, ActiveTab, MenuOpen = nil, nil, true
        local function UpdateToolTipPosition()
            if IsToolTipActive and ActiveToolTip then
                ActiveToolTip.Position = UDim2.new(0, UserInputService:GetMouseLocation().X - ActiveToolTip.AbsoluteSize.Y - ActiveToolTip.AbsoluteSize.X, 0, UserInputService:GetMouseLocation().Y - 10)
            end
        end

        local MenuToggleButton = Instance.new("TextButton")
        MenuToggleButton.Name = "MenuToggleButton"
        MenuToggleButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        MenuToggleButton.BorderColor3 = Color3.fromRGB(50, 50, 50)
        MenuToggleButton.BorderSizePixel = 2
        MenuToggleButton.Position = UDim2.new(0, 5, 0, 0)
        MenuToggleButton.Size = UDim2.new(0, 30, 0, 30)
        MenuToggleButton.Font = TextFont
        MenuToggleButton.Text = "Menu"
        MenuToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        MenuToggleButton.TextSize = 11
        MenuToggleButton.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        MenuToggleButton.TextStrokeTransparency = 0.7
        MenuToggleButton.Active = true
        MenuToggleButton.ZIndex = 2
        MenuToggleButton.Parent = ScreenGui

        local MenuToggleButton_UIStroke = Instance.new("UIStroke")
        MenuToggleButton_UIStroke.Name = "MenuToggleButton_UIStroke"
        MenuToggleButton_UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        MenuToggleButton_UIStroke.Color = Color3.fromRGB(40, 40, 40)
        MenuToggleButton_UIStroke.LineJoinMode = Enum.LineJoinMode.Miter
        MenuToggleButton_UIStroke.Thickness = 1
        MenuToggleButton_UIStroke.Transparency = 0
        MenuToggleButton_UIStroke.Enabled = true
        MenuToggleButton_UIStroke.Parent = MenuToggleButton

        local BackFrame = Instance.new("Frame")
        BackFrame.Name = "BackFrame"
        BackFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        BackFrame.BorderColor3 = Color3.fromRGB(20, 20, 20)
        BackFrame.BorderSizePixel = 2
        BackFrame.Position = UDim2.new(0.0981308445, 0, 0.0834355801, 0)
        BackFrame.Size = UDim2.new(0, 350, 0, 300)
        BackFrame.Draggable = true
        BackFrame.Selectable = true
        BackFrame.Active = true
        BackFrame.Parent = ScreenGui

        local BackFrame_UIStroke = Instance.new("UIStroke")
        BackFrame_UIStroke.Name = "BackFrame_UIStroke"
        BackFrame_UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        BackFrame_UIStroke.Color = Color3.fromRGB(60, 60, 60)
        BackFrame_UIStroke.LineJoinMode = Enum.LineJoinMode.Miter
        BackFrame_UIStroke.Thickness = 2
        BackFrame_UIStroke.Transparency = 0
        BackFrame_UIStroke.Enabled = true
        BackFrame_UIStroke.Parent = BackFrame

        local MainFrame = Instance.new("Frame")
        MainFrame.Name = "MainFrame"
        MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        MainFrame.BorderColor3 = FrameBorderColor
        MainFrame.BorderSizePixel = 2
        MainFrame.Position = UDim2.new(0.0199490078, 0, 0.0434355661, 0)
        MainFrame.Size = UDim2.new(0, 328, 0, 268)
        MainFrame.Parent = BackFrame

        local MainFrame_UIStroke = Instance.new("UIStroke")
        MainFrame_UIStroke.Name = "MainFrame_UIStroke"
        MainFrame_UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        MainFrame_UIStroke.Color = FrameInlineBorderColor
        MainFrame_UIStroke.LineJoinMode = Enum.LineJoinMode.Miter
        MainFrame_UIStroke.Thickness = 1
        MainFrame_UIStroke.Transparency = 0
        MainFrame_UIStroke.Enabled = true
        MainFrame_UIStroke.Parent = MainFrame

        local SectionsFrame = Instance.new("Frame")
        SectionsFrame.Name = "SectionsFrame"
        SectionsFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        SectionsFrame.BackgroundTransparency = 1
        SectionsFrame.Position = UDim2.new(0.024999965, 0, 0.0514184386, 20)
        SectionsFrame.Size = UDim2.new(0, 304, 0, 220)
        SectionsFrame.Parent = MainFrame

        local TabsHolderFrame = Instance.new("Frame")
        TabsHolderFrame.Name = "TabsHolderFrame"
        TabsHolderFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        TabsHolderFrame.BorderColor3 = FrameBorderColor
        TabsHolderFrame.BorderSizePixel = 2
        TabsHolderFrame.Position = UDim2.new(0.0250000004, 0, 0.0209999997, 0)
        TabsHolderFrame.Size = UDim2.new(0, 303, 0, 32)
        TabsHolderFrame.Parent = MainFrame

        local TabsHolderFrame_UIStroke = Instance.new("UIStroke")
        TabsHolderFrame_UIStroke.Name = "TabsHolderFrame_UIStroke"
        TabsHolderFrame_UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        TabsHolderFrame_UIStroke.Color = FrameInlineBorderColor
        TabsHolderFrame_UIStroke.LineJoinMode = Enum.LineJoinMode.Miter
        TabsHolderFrame_UIStroke.Thickness = 1
        TabsHolderFrame_UIStroke.Transparency = 0
        TabsHolderFrame_UIStroke.Enabled = true
        TabsHolderFrame_UIStroke.Parent = TabsHolderFrame

        local TabsFrame = Instance.new("Frame")
        TabsFrame.Name = "TabsFrame"
        TabsFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabsFrame.BackgroundTransparency = 1
        TabsFrame.Position = UDim2.new(0.0177865606, 0, 0.20, 0)
        TabsFrame.Size = UDim2.new(0, 288, 0, 20)
        TabsFrame.Parent = TabsHolderFrame

        local TabsFrame_UIListLayout = Instance.new("UIListLayout")
        TabsFrame_UIListLayout.Name = "TabsFrame_UIListLayout"
        TabsFrame_UIListLayout.FillDirection = Enum.FillDirection.Horizontal
        TabsFrame_UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        TabsFrame_UIListLayout.Padding = UDim.new(0, 3)
        TabsFrame_UIListLayout.Parent = TabsFrame

        local Shadow = Instance.new("ImageLabel")
        Shadow.Name = "Shadow"
        Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
        Shadow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Shadow.BackgroundTransparency = 1
        Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
        Shadow.Size = UDim2.new(1, 45, 1, 45)
        Shadow.ZIndex = 0
        Shadow.Image = "rbxassetid://2654849154"
        Shadow.ImageRectOffset = Vector2.new(2, 2)
        Shadow.ImageRectSize = Vector2.new(252, 252)
        Shadow.ImageTransparency = 0.4
        Shadow.ScaleType = Enum.ScaleType.Slice
        Shadow.SliceCenter = Rect.new(64, 64, 192, 192)
        Shadow.SliceScale = 0.31
        Shadow.ImageColor3 = BackgroundGlowColor
        Shadow.Parent = BackFrame

        local KelLabel = Instance.new("TextLabel")
        KelLabel.Name = "KelLabel"
        KelLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        KelLabel.BackgroundTransparency = 1
        KelLabel.Position = UDim2.new(0.02, 0, -0.02, 0)
        KelLabel.Size = UDim2.new(0, 20, 0, 20)
        KelLabel.Font = TextFont
        KelLabel.LineHeight = 0.74
        KelLabel.Text = "ros"
        KelLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        KelLabel.TextSize = 12
        KelLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        KelLabel.TextStrokeTransparency = 0.5
        KelLabel.TextXAlignment = Enum.TextXAlignment.Left
        KelLabel.Parent = BackFrame

        local TecLabel = Instance.new("TextLabel")
        TecLabel.Name = "TecLabel"
        TecLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TecLabel.BackgroundTransparency = 1
        TecLabel.Position = UDim2.new(0.02, 20, -0.02, 0)
        TecLabel.Size = UDim2.new(0, 22, 0, 20)
        TecLabel.Font = Enum.Font.SourceSansBold
        TecLabel.LineHeight = 0.74
        TecLabel.Text = "tec"
        TecLabel.TextColor3 = Color3.fromRGB(100, 150, 255)
        TecLabel.TextSize = 15
        TecLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        TecLabel.TextStrokeTransparency = 0.5
        TecLabel.TextXAlignment = Enum.TextXAlignment.Left
        TecLabel.Parent = BackFrame

        local DiscordLabel = Instance.new("TextLabel")
        DiscordLabel.Name = "DiscordLabel"
        DiscordLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        DiscordLabel.BackgroundTransparency = 1
        DiscordLabel.Position = UDim2.new(0.02, 41, -0.02, 0)
        DiscordLabel.Size = UDim2.new(0, 200, 0, 20)
        DiscordLabel.Font = TextFont
        DiscordLabel.LineHeight = 0.74
        DiscordLabel.Text = " | discord.gg/SBYNkbQmNR"
        DiscordLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        DiscordLabel.TextSize = 12
        DiscordLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        DiscordLabel.TextStrokeTransparency = 0.5
        DiscordLabel.TextXAlignment = Enum.TextXAlignment.Left
        DiscordLabel.Parent = BackFrame

        local FpsAndPingLabel = Instance.new("TextLabel")
        FpsAndPingLabel.Name = "FpsAndPingLabel"
        FpsAndPingLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        FpsAndPingLabel.BackgroundTransparency = 1
        FpsAndPingLabel.Position = UDim2.new(1, -150, -0.02, 0)
        FpsAndPingLabel.Size = UDim2.new(0, 145, 0, 20)
        FpsAndPingLabel.Font = Enum.Font.Code
        FpsAndPingLabel.LineHeight = 0.74
        FpsAndPingLabel.Text = ""
        FpsAndPingLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        FpsAndPingLabel.TextSize = 10
        FpsAndPingLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        FpsAndPingLabel.TextStrokeTransparency = 0.5
        FpsAndPingLabel.TextXAlignment = Enum.TextXAlignment.Right
        FpsAndPingLabel.Visible = DisplayFpsAndPing
        FpsAndPingLabel.Parent = BackFrame

        local function animateFpsSmoothRainbow()
            local hue = 180
            while FpsAndPingLabel and FpsAndPingLabel.Parent do
                local function createRainbowColor(hue)
                    hue = hue % 360
                    local c = 1
                    local x = 1 - math.abs((hue / 60) % 2 - 1)
                    local m = 0
                    local r, g, b
                    if hue < 60 then
                        r, g, b = c, x, 0
                    elseif hue < 120 then
                        r, g, b = x, c, 0
                    elseif hue < 180 then
                        r, g, b = 0, c, x
                    elseif hue < 240 then
                        r, g, b = 0, x, c
                    elseif hue < 300 then
                        r, g, b = x, 0, c
                    else
                        r, g, b = c, 0, x
                    end
                    return Color3.fromRGB(math.floor((r + m) * 255), math.floor((g + m) * 255), math.floor((b + m) * 255))
                end
                FpsAndPingLabel.TextColor3 = createRainbowColor(hue)
                hue = (hue + 4) % 360
                wait(0.025)
            end
        end
        coroutine.resume(coroutine.create(animateFpsSmoothRainbow))

        local FpsAndPingLoop, FpsAmount = nil, 0
        FpsAndPingLoop = RunService.Heartbeat:Connect(function(Step)
            FpsAmount = (1 / Step)
        end)
        coroutine.resume(coroutine.create(function()
            while task.wait(1) do
                FpsAndPingLabel.Text = string.format("\t  fps - %d, ping - %d", FpsAmount, tonumber(string.split(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString(), ".")[1]))
                patches.FixTextSize(FpsAndPingLabel, -4)
            end
        end))

        UserInputService.InputBegan:Connect(function(Key)
            if UserInputService:GetFocusedTextBox() then return end
            if Key and Key.KeyCode == UIToggleKey then
                MenuOpen = not MenuOpen
                BackFrame.Visible = MenuOpen
                MainFrame.Visible = MenuOpen
            end
        end)

        MenuToggleButton.MouseButton1Click:Connect(function()
            MenuOpen = not MenuOpen
            BackFrame.Visible = MenuOpen
            MainFrame.Visible = MenuOpen
            MenuToggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            wait(0.1)
            MenuToggleButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        end)

        local internalfunctions = {}
        function internalfunctions.HandleToolTip(Object, Text)
            local ToolTip = Instance.new("TextLabel")
            ToolTip.Name = "ToolTip"
            ToolTip.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            ToolTip.BorderColor3 = ElementBorderColor
            ToolTip.BorderSizePixel = 2
            ToolTip.Position = UDim2.new(0.490150571, 0, 0.63190186, 0)
            ToolTip.Size = UDim2.new(0, 123, 0, 17)
            ToolTip.Font = TextFont
            ToolTip.Text = Text
            ToolTip.TextColor3 = TextColor
            ToolTip.TextSize = 12
            ToolTip.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
            ToolTip.Visible = false
            ToolTip.ZIndex = 3
            ToolTip.Parent = ScreenGui

            local ToolTip_UIStroke = Instance.new("UIStroke")
            ToolTip_UIStroke.Name = "ToolTip_UIStroke"
            ToolTip_UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            ToolTip_UIStroke.Color = ElementsInlineBorderColor
            ToolTip_UIStroke.LineJoinMode = Enum.LineJoinMode.Miter
            ToolTip_UIStroke.Thickness = 1
            ToolTip_UIStroke.Transparency = 0
            ToolTip_UIStroke.Enabled = true
            ToolTip_UIStroke.Parent = ToolTip
            patches.FixTextSize(ToolTip, 5)

            local function OnToolTipMouseEnter()
                ToolTip.Visible = true
                IsToolTipActive = true
                ActiveToolTip = ToolTip
                RunService:BindToRenderStep("ciazware_tooltip_loop", 1, UpdateToolTipPosition)
            end
            Object.MouseEnter:Connect(OnToolTipMouseEnter)

            local function OnToolTipMouseLeave()
                ToolTip.Visible = false
                IsToolTipActive = false
                ActiveToolTip = nil
                RunService:UnbindFromRenderStep("ciazware_tooltip_loop")
            end
            Object.MouseLeave:Connect(OnToolTipMouseLeave)
        end

        local tabs = {}
        function tabs.AddTab(Name)
            local TabButton = Instance.new("TextButton")
            TabButton.Name = Name
            TabButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            TabButton.BorderColor3 = ElementBorderColor
            TabButton.BorderSizePixel = 2
            TabButton.Size = UDim2.new(0, 38, 0, 18)
            TabButton.Font = TextFont
            TabButton.Text = Name
            TabButton.TextColor3 = TextColor
            TabButton.TextSize = 10
            TabButton.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
            TabButton.Active = true
            TabButton.ZIndex = 2
            TabButton.Parent = TabsFrame

            local TabButton_UIStroke = Instance.new("UIStroke")
            TabButton_UIStroke.Name = "TabButton_UIStroke"
            TabButton_UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            TabButton_UIStroke.Color = ElementsInlineBorderColor
            TabButton_UIStroke.LineJoinMode = Enum.LineJoinMode.Miter
            TabButton_UIStroke.Thickness = 1
            TabButton_UIStroke.Transparency = 0
            TabButton_UIStroke.Enabled = true
            TabButton_UIStroke.Parent = TabButton
            patches.FixTextSize(TabButton, 8)

            local function OnTabButtonClick()
                for _, Object in next, TabsFrame:GetChildren() do
                    if Object and Object:IsA("TextButton") then
                        Object.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
                        local existingGradient = Object:FindFirstChild("TabGradient")
                        if existingGradient then
                            existingGradient:Destroy()
                        end
                    end
                end
                task.wait()
                TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                local TabGradient = Instance.new("UIGradient")
                TabGradient.Name = "TabGradient"
                TabGradient.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 100, 200)),
                    ColorSequenceKeypoint.new(0.33, Color3.fromRGB(100, 200, 255)),
                    ColorSequenceKeypoint.new(0.67, Color3.fromRGB(200, 255, 100)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 200, 100))
                }
                TabGradient.Parent = TabButton
                coroutine.resume(coroutine.create(function()
                    local rotation = 0
                    while TabButton.Parent and TabGradient.Parent do
                        TabGradient.Rotation = rotation
                        rotation = rotation + 5
                        if rotation >= 360 then rotation = 0 end
                        wait(0.1)
                    end
                end))
                for _, Object in next, SectionsFrame:GetChildren() do
                    Object.Visible = (string.find(string.split(Object.Name, "_")[2], Name) and true or false)
                end
            end
            TabButton.MouseButton1Click:Connect(OnTabButtonClick)

            local sections = {}
            function sections.AddSection()
                local SectionFrame = Instance.new("Frame")
                SectionFrame.Name = string.format("SectionFrame_%s", TabButton.Name)
                SectionFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
                SectionFrame.BorderColor3 = FrameBorderColor
                SectionFrame.BorderSizePixel = 2
                SectionFrame.Position = UDim2.new(0, 0, 0, 0)
                SectionFrame.Size = UDim2.new(0, 303, 0, 220)
                SectionFrame.Visible = false
                SectionFrame.Parent = SectionsFrame

                local SectionFrame_UIStroke = Instance.new("UIStroke")
                SectionFrame_UIStroke.Name = "SectionFrame_UIStroke"
                SectionFrame_UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                SectionFrame_UIStroke.Color = FrameInlineBorderColor
                SectionFrame_UIStroke.LineJoinMode = Enum.LineJoinMode.Miter
                SectionFrame_UIStroke.Thickness = 1
                SectionFrame_UIStroke.Transparency = 0
                SectionFrame_UIStroke.Enabled = true
                SectionFrame_UIStroke.Parent = SectionFrame

                local LeftSideFrame = Instance.new("Frame")
                LeftSideFrame.Name = "LeftSideFrame"
                LeftSideFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                LeftSideFrame.BackgroundTransparency = 1
                LeftSideFrame.BorderSizePixel = 0
                LeftSideFrame.Size = UDim2.new(0, 148, 0, 220)
                LeftSideFrame.Parent = SectionFrame

                local LeftSideFrame_Container = Instance.new("ScrollingFrame")
                LeftSideFrame_Container.Name = "LeftSideFrame_Container"
                LeftSideFrame_Container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                LeftSideFrame_Container.BackgroundTransparency = 1
                LeftSideFrame_Container.Size = UDim2.new(0, 148, 0, 220)
                LeftSideFrame_Container.CanvasSize = UDim2.new(0, 0, 0, 0)
                LeftSideFrame_Container.ScrollBarThickness = 4
                LeftSideFrame_Container.ScrollBarImageColor3 = FrameBorderColor
                LeftSideFrame_Container.Active = true
                LeftSideFrame_Container.ZIndex = 1
                LeftSideFrame_Container.Parent = LeftSideFrame

                local LeftContainer_UIListLayout = Instance.new("UIListLayout")
                LeftContainer_UIListLayout.Name = "LeftContainer_UIListLayout"
                LeftContainer_UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                LeftContainer_UIListLayout.Padding = UDim.new(0, 5)
                LeftContainer_UIListLayout.Parent = LeftSideFrame_Container

                LeftContainer_UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    LeftSideFrame_Container.CanvasSize = UDim2.new(0, 0, 0, LeftContainer_UIListLayout.AbsoluteContentSize.Y)
                end)

                local MiddleSpliterFrame = Instance.new("Frame")
                MiddleSpliterFrame.Name = "MiddleSpliterFrame"
                MiddleSpliterFrame.BackgroundColor3 = FrameBorderColor
                MiddleSpliterFrame.BorderSizePixel = 0
                MiddleSpliterFrame.Position = UDim2.new(0.49, 0, 0, 0)
                MiddleSpliterFrame.Size = UDim2.new(0, 1, 0, 220)
                MiddleSpliterFrame.Parent = SectionFrame

                local MiddleSpliterFrame_UIStroke = Instance.new("UIStroke")
                MiddleSpliterFrame_UIStroke.Name = "MiddleSpliterFrame_UIStroke"
                MiddleSpliterFrame_UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                MiddleSpliterFrame_UIStroke.Color = FrameInlineBorderColor
                MiddleSpliterFrame_UIStroke.LineJoinMode = Enum.LineJoinMode.Miter
                MiddleSpliterFrame_UIStroke.Thickness = 1
                MiddleSpliterFrame_UIStroke.Transparency = 0
                MiddleSpliterFrame_UIStroke.Enabled = true
                MiddleSpliterFrame_UIStroke.Parent = MiddleSpliterFrame

                local RightSideFrame = Instance.new("Frame")
                RightSideFrame.Name = "RightSideFrame"
                RightSideFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                RightSideFrame.BackgroundTransparency = 1
                RightSideFrame.Position = UDim2.new(0.51, 0, 0, 0)
                RightSideFrame.Size = UDim2.new(0, 148, 0, 220)
                RightSideFrame.Parent = SectionFrame

                local RightSideFrame_Container = Instance.new("ScrollingFrame")
                RightSideFrame_Container.Name = "RightSideFrame_Container"
                RightSideFrame_Container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                RightSideFrame_Container.BackgroundTransparency = 1
                RightSideFrame_Container.Size = UDim2.new(0, 148, 0, 220)
                RightSideFrame_Container.CanvasSize = UDim2.new(0, 0, 0, 0)
                RightSideFrame_Container.ScrollBarThickness = 4
                RightSideFrame_Container.ScrollBarImageColor3 = FrameBorderColor
                RightSideFrame_Container.Active = true
                RightSideFrame_Container.ZIndex = 1
                RightSideFrame_Container.Parent = RightSideFrame

                local RightContainer_UIListLayout = Instance.new("UIListLayout")
                RightContainer_UIListLayout.Name = "RightContainer_UIListLayout"
                RightContainer_UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                RightContainer_UIListLayout.Padding = UDim.new(0, 5)
                RightContainer_UIListLayout.Parent = RightSideFrame_Container

                RightContainer_UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    RightSideFrame_Container.CanvasSize = UDim2.new(0, 0, 0, RightContainer_UIListLayout.AbsoluteContentSize.Y)
                end)

                local elements = {}
                function elements.AddToggle(Name, Callback, Side)
                    local ElementContainer = Instance.new("Frame")
                    ElementContainer.Name = "ToggleContainer_" .. Name
                    ElementContainer.BackgroundTransparency = 1
                    ElementContainer.Size = UDim2.new(0, 148, 0, 20)
                    ElementContainer.ZIndex = 2
                    ElementContainer.Parent = (string.lower(Side) == "left" and LeftSideFrame_Container) or RightSideFrame_Container

                    local ToggleLabel = Instance.new("TextLabel")
                    ToggleLabel.Name = "ToggleLabel"
                    ToggleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    ToggleLabel.BackgroundTransparency = 1
                    ToggleLabel.Size = UDim2.new(0, 80, 0, 20)
                    ToggleLabel.Position = UDim2.new(0, 0, 0, 0)
                    ToggleLabel.Font = TextFont
                    ToggleLabel.Text = Name
                    ToggleLabel.TextColor3 = TextColor
                    ToggleLabel.TextSize = 11
                    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
                    ToggleLabel.ZIndex = 2
                    ToggleLabel.Parent = ElementContainer
                    patches.FixTextSize(ToggleLabel, 8)

                    local ToggleButton = Instance.new("TextButton")
                    ToggleButton.Name = "ToggleButton"
                    ToggleButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
                    ToggleButton.BorderColor3 = ElementBorderColor
                    ToggleButton.BorderSizePixel = 2
                    ToggleButton.Size = UDim2.new(0, 14, 0, 14)
                    ToggleButton.Position = UDim2.new(0, 100, 0, 3)
                    ToggleButton.Font = TextFont
                    ToggleButton.Text = ""
                    ToggleButton.TextColor3 = TextColor
                    ToggleButton.TextSize = 8
                    ToggleButton.Active = true
                    ToggleButton.ZIndex = 3
                    ToggleButton.Parent = ElementContainer

                    local ToggleButton_UIStroke = Instance.new("UIStroke")
                    ToggleButton_UIStroke.Name = "ToggleButton_UIStroke"
                    ToggleButton_UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    ToggleButton_UIStroke.Color = ElementsInlineBorderColor
                    ToggleButton_UIStroke.LineJoinMode = Enum.LineJoinMode.Miter
                    ToggleButton_UIStroke.Thickness = 1
                    ToggleButton_UIStroke.Transparency = 0
                    ToggleButton_UIStroke.Enabled = true
                    ToggleButton_UIStroke.Parent = ToggleButton

                    local Toggled = false
                    local function OnToggleButtonClick()
                        print("Toggle clicked: " .. Name .. ", New state: " .. tostring(not Toggled)) -- Debug print
                        Toggled = not Toggled
                        patches.FadeObject(ToggleButton, 0.5, Toggled and 0 or 0.5, false) -- Fixed: Use transparency values (0 for on, 0.5 for off)
                        ToggleButton_UIStroke.Enabled = not Toggled
                        if Callback then
                            pcall(Callback, Toggled) -- Safely call the callback
                            print("Callback executed for " .. Name .. ": " .. tostring(Toggled)) -- Debug print
                        end
                    end
                    ToggleButton.MouseButton1Click:Connect(OnToggleButtonClick)

                    local subelements = {}
                    function subelements.AddToolTip(Text)
                        internalfunctions.HandleToolTip(ToggleLabel, Text)
                    end
                    return subelements
                end

                function elements.AddTextBox(Name, Min, Max, Callback, Side)
                    local ElementContainer = Instance.new("Frame")
                    ElementContainer.Name = "TextBoxContainer_" .. Name
                    ElementContainer.BackgroundTransparency = 1
                    ElementContainer.Size = UDim2.new(0, 148, 0, 20)
                    ElementContainer.ZIndex = 2
                    ElementContainer.Parent = (string.lower(Side) == "left" and LeftSideFrame_Container) or RightSideFrame_Container

                    local TextBoxLabel = Instance.new("TextLabel")
                    TextBoxLabel.Name = "TextBoxLabel"
                    TextBoxLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    TextBoxLabel.BackgroundTransparency = 1
                    TextBoxLabel.Size = UDim2.new(0, 80, 0, 20)
                    TextBoxLabel.Position = UDim2.new(0, 0, 0, 0)
                    TextBoxLabel.Font = TextFont
                    TextBoxLabel.Text = Name
                    TextBoxLabel.TextColor3 = TextColor
                    TextBoxLabel.TextSize = 11
                    TextBoxLabel.TextXAlignment = Enum.TextXAlignment.Left
                    TextBoxLabel.ZIndex = 2
                    TextBoxLabel.Parent = ElementContainer
                    patches.FixTextSize(TextBoxLabel, 8)

                    local TextBox = Instance.new("TextBox")
                    TextBox.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
                    TextBox.BorderColor3 = ElementBorderColor
                    TextBox.BorderSizePixel = 2
                    TextBox.Size = UDim2.new(0, 45, 0, 14)
                    TextBox.Position = UDim2.new(0, 100, 0, 3)
                    TextBox.Font = TextFont
                    TextBox.Text = tostring(Min)
                    TextBox.TextColor3 = TextColor
                    TextBox.TextSize = 10
                    TextBox.Active = true
                    TextBox.ZIndex = 3
                    TextBox.Parent = ElementContainer

                    local TextBox_UIStroke = Instance.new("UIStroke")
                    TextBox_UIStroke.Name = "TextBox_UIStroke"
                    TextBox_UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    TextBox_UIStroke.Color = ElementsInlineBorderColor
                    TextBox_UIStroke.LineJoinMode = Enum.LineJoinMode.Miter
                    TextBox_UIStroke.Thickness = 1
                    TextBox_UIStroke.Transparency = 0
                    TextBox_UIStroke.Enabled = true
                    TextBox_UIStroke.Parent = TextBox

                    local function OnTextBoxFocusLost()
                        if #TextBox.Text > 0 then
                            local value = tonumber(TextBox.Text)
                            if value and value >= Min and value <= Max then
                                print("TextBox " .. Name .. " value: " .. value) -- Debug print
                                Callback(value)
                            else
                                game:GetService("StarterGui"):SetCore("SendNotification", {
                                    Title = "Invalid Input",
                                    Text = "Value must be between " .. Min .. " and " .. Max,
                                    Duration = 3
                                })
                                TextBox.Text = tostring(Min)
                            end
                        end
                    end
                    TextBox.FocusLost:Connect(OnTextBoxFocusLost)

                    local subelements = {}
                    function subelements.AddToolTip(Text)
                        internalfunctions.HandleToolTip(TextBoxLabel, Text)
                    end
                    return subelements
                end

                function elements.AddParagraph(Text)
                    local ParagraphLabel = Instance.new("TextLabel")
                    ParagraphLabel.Name = "ParagraphLabel"
                    ParagraphLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                    ParagraphLabel.BackgroundTransparency = 0.1
                    ParagraphLabel.BorderColor3 = ElementBorderColor
                    ParagraphLabel.BorderSizePixel = 1
                    ParagraphLabel.Size = UDim2.new(0, 290, 0, 180)
                    ParagraphLabel.Font = TextFont
                    ParagraphLabel.Text = Text
                    ParagraphLabel.TextColor3 = TextColor
                    ParagraphLabel.TextSize = 11
                    ParagraphLabel.TextWrapped = true
                    ParagraphLabel.TextXAlignment = Enum.TextXAlignment.Left
                    ParagraphLabel.TextYAlignment = Enum.TextYAlignment.Top
                    ParagraphLabel.ZIndex = 2
                    ParagraphLabel.Parent = SectionFrame

                    local ParagraphLabel_UIStroke = Instance.new("UIStroke")
                    ParagraphLabel_UIStroke.Name = "ParagraphLabel_UIStroke"
                    ParagraphLabel_UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    ParagraphLabel_UIStroke.Color = ElementsInlineBorderColor
                    ParagraphLabel_UIStroke.LineJoinMode = Enum.LineJoinMode.Miter
                    ParagraphLabel_UIStroke.Thickness = 1
                    ParagraphLabel_UIStroke.Transparency = 0
                    ParagraphLabel_UIStroke.Enabled = true
                    ParagraphLabel_UIStroke.Parent = ParagraphLabel
                    return {}
                end

                function elements.AddCycleButton(Name, Options, Callback, Side)
                    local ElementContainer = Instance.new("Frame")
                    ElementContainer.Name = "CycleButtonContainer_" .. Name
                    ElementContainer.BackgroundTransparency = 1
                    ElementContainer.Size = UDim2.new(0, 148, 0, 20)
                    ElementContainer.ZIndex = 2
                    ElementContainer.Parent = (string.lower(Side) == "left" and LeftSideFrame_Container) or RightSideFrame_Container

                    local CycleButtonLabel = Instance.new("TextLabel")
                    CycleButtonLabel.Name = "CycleButtonLabel"
                    CycleButtonLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    CycleButtonLabel.BackgroundTransparency = 1
                    CycleButtonLabel.Size = UDim2.new(0, 80, 0, 20)
                    CycleButtonLabel.Position = UDim2.new(0, 0, 0, 0)
                    CycleButtonLabel.Font = TextFont
                    CycleButtonLabel.Text = Name
                    CycleButtonLabel.TextColor3 = TextColor
                    CycleButtonLabel.TextSize = 11
                    CycleButtonLabel.TextXAlignment = Enum.TextXAlignment.Left
                    CycleButtonLabel.ZIndex = 2
                    CycleButtonLabel.Parent = ElementContainer
                    patches.FixTextSize(CycleButtonLabel, 8)

                    local CycleButton = Instance.new("TextButton")
                    CycleButton.Name = "CycleButton"
                    CycleButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
                    CycleButton.BorderColor3 = ElementBorderColor
                    CycleButton.BorderSizePixel = 2
                    CycleButton.Size = UDim2.new(0, 45, 0, 14)
                    CycleButton.Position = UDim2.new(0, 100, 0, 3)
                    CycleButton.Font = TextFont
                    CycleButton.Text = Options[1]
                    CycleButton.TextColor3 = TextColor
                    CycleButton.TextSize = 9
                    CycleButton.Active = true
                    CycleButton.ZIndex = 3
                    CycleButton.Parent = ElementContainer

                    local CycleButton_UIStroke = Instance.new("UIStroke")
                    CycleButton_UIStroke.Name = "CycleButton_UIStroke"
                    CycleButton_UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    CycleButton_UIStroke.Color = ElementsInlineBorderColor
                    CycleButton_UIStroke.LineJoinMode = Enum.LineJoinMode.Miter
                    CycleButton_UIStroke.Thickness = 1
                    CycleButton_UIStroke.Transparency = 0
                    CycleButton_UIStroke.Enabled = true
                    CycleButton_UIStroke.Parent = CycleButton

                    local currentIndex = 1
                    local function OnCycleButtonClick()
                        print("CycleButton clicked: " .. Name .. ", New option: " .. Options[currentIndex % #Options + 1])
                        currentIndex = currentIndex % #Options + 1
                        CycleButton.Text = Options[currentIndex]
                        if Callback then
                            pcall(Callback, Options[currentIndex])
                            print("Callback executed for " .. Name .. ": " .. Options[currentIndex])
                        end
                    end
                    CycleButton.MouseButton1Click:Connect(OnCycleButtonClick)

                    local subelements = {}
                    function subelements.AddToolTip(Text)
                        internalfunctions.HandleToolTip(CycleButtonLabel, Text)
                    end
                    return subelements
                end

                function elements.AddBlankLine(Side)
                    local BlankLabel = Instance.new("TextLabel")
                    BlankLabel.Name = "BlankLabel"
                    BlankLabel.BackgroundTransparency = 1
                    BlankLabel.Size = UDim2.new(0, 148, 0, 10)
                    BlankLabel.Font = TextFont
                    BlankLabel.Text = ""
                    BlankLabel.TextColor3 = TextColor
                    BlankLabel.TextSize = 11
                    BlankLabel.ZIndex = 2
                    BlankLabel.Parent = (string.lower(Side) == "left" and LeftSideFrame_Container) or RightSideFrame_Container
                    return {}
                end

                function elements.AddSeparator(Side)
                    local Separator = Instance.new("Frame")
                    Separator.Name = "Separator"
                    Separator.BackgroundColor3 = FrameBorderColor
                    Separator.BorderSizePixel = 0
                    Separator.Size = UDim2.new(0, 140, 0, 2)
                    Separator.Position = UDim2.new(0, 4, 0, 0)
                    Separator.ZIndex = 2
                    Separator.Parent = (string.lower(Side) == "left" and LeftSideFrame_Container) or RightSideFrame_Container
                    return {}
                end

                return elements
            end
            return sections
        end
        return tabs
    end
end

return library
