-- Add these advanced features to your KelTec library (before "return KelTecLib")

-- Advanced Notification System
local NotificationSystem = {}

function KelTecLib.CreateNotification(title, message, duration, notificationType)
    duration = duration or 3
    notificationType = notificationType or "info" -- "info", "success", "warning", "error"
    
    local colors = {
        info = Config.Colors.Accent,
        success = Config.Colors.Success,
        warning = Config.Colors.Warning,
        error = Config.Colors.Error
    }
    
    local icons = {
        info = "ℹ️",
        success = "✅", 
        warning = "⚠️",
        error = "❌"
    }
    
    -- Create notification GUI
    local NotifGui = Instance.new("ScreenGui")
    NotifGui.Name = "KelTecNotification"
    NotifGui.Parent = CoreGui
    NotifGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    NotifGui.DisplayOrder = 200
    
    local NotifFrame = Instance.new("Frame")
    NotifFrame.Name = "NotificationFrame"
    NotifFrame.Size = UDim2.new(0, 350, 0, 80)
    NotifFrame.Position = UDim2.new(1, 10, 0, 10)
    NotifFrame.BackgroundColor3 = Config.Colors.Primary
    NotifFrame.BorderSizePixel = 0
    NotifFrame.ZIndex = 10
    NotifFrame.Parent = NotifGui
    CreateCorner(NotifFrame, 12)
    CreateStroke(NotifFrame, colors[notificationType], 2)
    CreateGlow(NotifFrame, colors[notificationType], 15)
    
    -- Modern gradient
    CreateGradient(NotifFrame, ColorSequence.new{
        ColorSequenceKeypoint.new(0, Config.Colors.Primary),
        ColorSequenceKeypoint.new(1, Config.Colors.Secondary)
    }, 90)
    
    -- Icon
    local NotifIcon = Instance.new("TextLabel")
    NotifIcon.Name = "Icon"
    NotifIcon.Size = UDim2.new(0, 40, 0, 40)
    NotifIcon.Position = UDim2.new(0, 15, 0.5, -20)
    NotifIcon.BackgroundTransparency = 1
    NotifIcon.Text = icons[notificationType]
    NotifIcon.TextColor3 = colors[notificationType]
    NotifIcon.TextSize = 24
    NotifIcon.Font = Config.Fonts.Bold
    NotifIcon.ZIndex = 11
    NotifIcon.Parent = NotifFrame
    
    -- Title
    local NotifTitle = Instance.new("TextLabel")
    NotifTitle.Name = "Title"
    NotifTitle.Size = UDim2.new(1, -70, 0, 25)
    NotifTitle.Position = UDim2.new(0, 60, 0, 12)
    NotifTitle.BackgroundTransparency = 1
    NotifTitle.Text = title
    NotifTitle.TextColor3 = Config.Colors.Text
    NotifTitle.TextSize = 16
    NotifTitle.Font = Config.Fonts.Bold
    NotifTitle.TextXAlignment = Enum.TextXAlignment.Left
    NotifTitle.ZIndex = 11
    NotifTitle.Parent = NotifFrame
    
    -- Message
    local NotifMessage = Instance.new("TextLabel")
    NotifMessage.Name = "Message"
    NotifMessage.Size = UDim2.new(1, -70, 0, 25)
    NotifMessage.Position = UDim2.new(0, 60, 0, 35)
    NotifMessage.BackgroundTransparency = 1
    NotifMessage.Text = message
    NotifMessage.TextColor3 = Config.Colors.TextSecondary
    NotifMessage.TextSize = 13
    NotifMessage.Font = Config.Fonts.Main
    NotifMessage.TextXAlignment = Enum.TextXAlignment.Left
    NotifMessage.ZIndex = 11
    NotifMessage.Parent = NotifFrame
    
    -- Progress bar
    local ProgressBar = Instance.new("Frame")
    ProgressBar.Name = "ProgressBar"
    ProgressBar.Size = UDim2.new(1, 0, 0, 3)
    ProgressBar.Position = UDim2.new(0, 0, 1, -3)
    ProgressBar.BackgroundColor3 = colors[notificationType]
    ProgressBar.BorderSizePixel = 0
    ProgressBar.ZIndex = 11
    ProgressBar.Parent = NotifFrame
    
    -- Animate entrance
    CreateTween(NotifFrame, {Position = UDim2.new(1, -360, 0, 10)}, 0.4, Enum.EasingStyle.Back)
    
    -- Animate progress bar
    CreateTween(ProgressBar, {Size = UDim2.new(0, 0, 0, 3)}, duration, Enum.EasingStyle.Linear)
    
    -- Auto-close
    spawn(function()
        wait(duration)
        CreateTween(NotifFrame, {
            Position = UDim2.new(1, 10, 0, 10),
            BackgroundTransparency = 1
        }, 0.3)
        
        for _, child in pairs(NotifFrame:GetChildren()) do
            if child:IsA("GuiObject") then
                if child:IsA("TextLabel") then
                    CreateTween(child, {TextTransparency = 1}, 0.3)
                else
                    CreateTween(child, {BackgroundTransparency = 1}, 0.3)
                end
            end
        end
        
        wait(0.4)
        NotifGui:Destroy()
    end)
end

-- Advanced Keybind System
function GUI:CreateKeybind(section, name, default, callback)
    default = default or Enum.KeyCode.Unknown
    callback = callback or function() end
    
    local KeybindFrame = Instance.new("Frame")
    KeybindFrame.Name = name .. "Keybind"
    KeybindFrame.Size = UDim2.new(1, 0, 0, 42)
    KeybindFrame.BackgroundColor3 = Config.Colors.Background
    KeybindFrame.BorderSizePixel = 0
    KeybindFrame.ZIndex = 16
    KeybindFrame.Parent = section.Content
    CreateCorner(KeybindFrame, 10)
    CreateStroke(KeybindFrame, Config.Colors.Border)
    
    CreateGradient(KeybindFrame, ColorSequence.new{
        ColorSequenceKeypoint.new(0, Config.Colors.Background),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 30))
    }, 90)
    
    local KeybindLabel = Instance.new("TextLabel")
    KeybindLabel.Name = "KeybindLabel"
    KeybindLabel.Size = UDim2.new(1, -80, 1, 0)
    KeybindLabel.Position = UDim2.new(0, 16, 0, 0)
    KeybindLabel.BackgroundTransparency = 1
    KeybindLabel.Text = name
    KeybindLabel.TextColor3 = Config.Colors.Text
    KeybindLabel.TextSize = 15
    KeybindLabel.Font = Config.Fonts.Main
    KeybindLabel.TextXAlignment = Enum.TextXAlignment.Left
    KeybindLabel.ZIndex = 17
    KeybindLabel.Parent = KeybindFrame
    
    local KeybindButton = Instance.new("TextButton")
    KeybindButton.Name = "KeybindButton"
    KeybindButton.Size = UDim2.new(0, 60, 0, 26)
    KeybindButton.Position = UDim2.new(1, -70, 0.5, -13)
    KeybindButton.BackgroundColor3 = Config.Colors.Accent
    KeybindButton.BorderSizePixel = 0
    KeybindButton.Text = default.Name:sub(1, 8)
    KeybindButton.TextColor3 = Config.Colors.Text
    KeybindButton.TextSize = 12
    KeybindButton.Font = Config.Fonts.Bold
    KeybindButton.ZIndex = 17
    KeybindButton.Parent = KeybindFrame
    CreateCorner(KeybindButton, 6)
    CreateGlow(KeybindButton, Config.Colors.Accent, 8)
    
    local currentKey = default
    local listening = false
    
    KeybindButton.MouseButton1Click:Connect(function()
        if listening then return end
        
        listening = true
        KeybindButton.Text = "..."
        KeybindButton.BackgroundColor3 = Config.Colors.Warning
        
        local connection
        connection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if gameProcessed then return end
            
            currentKey = input.KeyCode
            KeybindButton.Text = currentKey.Name:sub(1, 8)
            KeybindButton.BackgroundColor3 = Config.Colors.Accent
            listening = false
            connection:Disconnect()
        end)
    end)
    
    -- Listen for keybind activation
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed or listening then return end
        if input.KeyCode == currentKey then
            callback(currentKey)
        end
    end)
    
    return {
        Frame = KeybindFrame,
        SetKey = function(key)
            currentKey = key
            KeybindButton.Text = key.Name:sub(1, 8)
        end,
        GetKey = function()
            return currentKey
        end
    }
end

-- Advanced TextBox
function GUI:CreateTextBox(section, name, placeholder, callback)
    placeholder = placeholder or "Enter text..."
    callback = callback or function() end
    
    local TextBoxFrame = Instance.new("Frame")
    TextBoxFrame.Name = name .. "TextBox"
    TextBoxFrame.Size = UDim2.new(1, 0, 0, 42)
    TextBoxFrame.BackgroundColor3 = Config.Colors.Background
    TextBoxFrame.BorderSizePixel = 0
    TextBoxFrame.ZIndex = 16
    TextBoxFrame.Parent = section.Content
    CreateCorner(TextBoxFrame, 10)
    CreateStroke(TextBoxFrame, Config.Colors.Border)
    
    CreateGradient(TextBoxFrame, ColorSequence.new{
        ColorSequenceKeypoint.new(0, Config.Colors.Background),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 30))
    }, 90)
    
    local TextBoxLabel = Instance.new("TextLabel")
    TextBoxLabel.Name = "TextBoxLabel"
    TextBoxLabel.Size = UDim2.new(0.4, 0, 1, 0)
    TextBoxLabel.Position = UDim2.new(0, 16, 0, 0)
    TextBoxLabel.BackgroundTransparency = 1
    TextBoxLabel.Text = name
    TextBoxLabel.TextColor3 = Config.Colors.Text
    TextBoxLabel.TextSize = 15
    TextBoxLabel.Font = Config.Fonts.Main
    TextBoxLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextBoxLabel.ZIndex = 17
    TextBoxLabel.Parent = TextBoxFrame
    
    local TextBox = Instance.new("TextBox")
    TextBox.Name = "TextBox"
    TextBox.Size = UDim2.new(0.55, -16, 0, 26)
    TextBox.Position = UDim2.new(0.45, 0, 0.5, -13)
    TextBox.BackgroundColor3 = Config.Colors.Secondary
    TextBox.BorderSizePixel = 0
    TextBox.Text = ""
    TextBox.PlaceholderText = placeholder
    TextBox.TextColor3 = Config.Colors.Text
    TextBox.PlaceholderColor3 = Config.Colors.TextMuted
    TextBox.TextSize = 13
    TextBox.Font = Config.Fonts.Main
    TextBox.ZIndex = 17
    TextBox.Parent = TextBoxFrame
    CreateCorner(TextBox, 6)
    
    local TextBoxPadding = Instance.new("UIPadding")
    TextBoxPadding.PaddingLeft = UDim.new(0, 8)
    TextBoxPadding.PaddingRight = UDim.new(0, 8)
    TextBoxPadding.Parent = TextBox
    
    -- Focus effects
    TextBox.Focused:Connect(function()
        CreateStroke(TextBoxFrame, Config.Colors.Accent, 2)
        CreateGlow(TextBoxFrame, Config.Colors.Accent, 8)
    end)
    
    TextBox.FocusLost:Connect(function()
        CreateStroke(TextBoxFrame, Config.Colors.Border, 1)
        local glow = TextBoxFrame.Parent:FindFirstChild("Glow")
        if glow then glow:Destroy() end
        callback(TextBox.Text)
    end)
    
    return {
        Frame = TextBoxFrame,
        SetText = function(text)
            TextBox.Text = text
        end,
        GetText = function()
            return TextBox.Text
        end
    }
end

-- Advanced Config System
function GUI:CreateConfigSystem()
    local ConfigSystem = {
        Settings = {},
        FileName = "KelTecConfig.json"
    }
    
    function ConfigSystem:Save()
        local success, result = pcall(function()
            local data = game:GetService("HttpService"):JSONEncode(self.Settings)
            writefile(self.FileName, data)
            return true
        end)
        
        if success then
            KelTecLib.CreateNotification("Config Saved", "Configuration saved successfully!", 2, "success")
        else
            KelTecLib.CreateNotification("Save Failed", "Failed to save configuration", 3, "error")
        end
        
        return success
    end
    
    function ConfigSystem:Load()
        local success, result = pcall(function()
            if isfile(self.FileName) then
                local data = readfile(self.FileName)
                self.Settings = game:GetService("HttpService"):JSONDecode(data)
                return true
            end
            return false
        end)
        
        if success and result then
            KelTecLib.CreateNotification("Config Loaded", "Configuration loaded successfully!", 2, "success")
        else
            KelTecLib.CreateNotification("Load Failed", "No config file found or failed to load", 3, "warning")
        end
        
        return success and result
    end
    
    function ConfigSystem:Set(key, value)
        self.Settings[key] = value
    end
    
    function ConfigSystem:Get(key, default)
        return self.Settings[key] or default
    end
    
    return ConfigSystem
end

-- Performance Monitor
local PerformanceMonitor = {
    FPS = 0,
    Ping = 0,
    MemoryUsage = 0
}

function PerformanceMonitor:Start()
    spawn(function()
        local lastTime = tick()
        local frameCount = 0
        
        RunService.Heartbeat:Connect(function()
            frameCount = frameCount + 1
            local currentTime = tick()
            
            if currentTime - lastTime >= 1 then
                self.FPS = frameCount
                frameCount = 0
                lastTime = currentTime
                
                -- Get ping
                local stats = game:GetService("Stats")
                local ping = stats.Network.ServerStatsItem["Data Ping"]:GetValueString()
                self.Ping = tonumber(ping:match("(%d+)")) or 0
                
                -- Memory usage (approximate)
                self.MemoryUsage = math.floor(stats:GetTotalMemoryUsageMb())
            end
        end)
    end)
end

-- Advanced Theme System
local ThemeManager = {
    Themes = {
        ["Dark Modern"] = {
            Primary = Color3.fromRGB(15, 15, 23),
            Secondary = Color3.fromRGB(25, 25, 35),
            Accent = Color3.fromRGB(88, 101, 242),
            Background = Color3.fromRGB(10, 10, 15)
        },
        ["Purple Dream"] = {
            Primary = Color3.fromRGB(20, 15, 25),
            Secondary = Color3.fromRGB(30, 25, 40),
            Accent = Color3.fromRGB(138, 43, 226),
            Background = Color3.fromRGB(15, 10, 20)
        },
        ["Ocean Blue"] = {
            Primary = Color3.fromRGB(15, 20, 30),
            Secondary = Color3.fromRGB(25, 35, 45),
            Accent = Color3.fromRGB(0, 150, 255),
            Background = Color3.fromRGB(10, 15, 25)
        },
        ["Forest Green"] = {
            Primary = Color3.fromRGB(15, 25, 15),
            Secondary = Color3.fromRGB(25, 40, 25),
            Accent = Color3.fromRGB(67, 181, 129),
            Background = Color3.fromRGB(10, 20, 10)
        },
        ["Blood Red"] = {
            Primary = Color3.fromRGB(25, 15, 15),
            Secondary = Color3.fromRGB(40, 25, 25),
            Accent = Color3.fromRGB(237, 66, 69),
            Background = Color3.fromRGB(20, 10, 10)
        }
    }
}

function ThemeManager:ApplyTheme(themeName, gui)
    local theme = self.Themes[themeName]
    if not theme then return false end
    
    -- Update config colors
    for key, value in pairs(theme) do
        Config.Colors[key] = value
    end
    
    -- Apply to existing elements (would need to iterate through GUI elements)
    KelTecLib.CreateNotification("Theme Applied", "Theme '" .. themeName .. "' applied successfully!", 2, "success")
    return true
end

-- Watermark System
function GUI:CreateWatermark()
    local WatermarkGui = Instance.new("ScreenGui")
    WatermarkGui.Name = "KelTecWatermark"
    WatermarkGui.Parent = CoreGui
    WatermarkGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    WatermarkGui.DisplayOrder = 150
    
    local WatermarkFrame = Instance.new("Frame")
    WatermarkFrame.Name = "WatermarkFrame"
    WatermarkFrame.Size = UDim2.new(0, 200, 0, 60)
    WatermarkFrame.Position = UDim2.new(0, 10, 0, 10)
    WatermarkFrame.BackgroundColor3 = Config.Colors.Primary
    WatermarkFrame.BorderSizePixel = 0
    WatermarkFrame.ZIndex = 10
    WatermarkFrame.Parent = WatermarkGui
    CreateCorner(WatermarkFrame, 10)
    CreateStroke(WatermarkFrame, Config.Colors.Border)
    
    CreateGradient(WatermarkFrame, ColorSequence.new{
        ColorSequenceKeypoint.new(0, Config.Colors.Primary),
        ColorSequenceKeypoint.new(1, Config.Colors.Secondary)
    }, 90)
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -20, 0, 20)
    Title.Position = UDim2.new(0, 10, 0, 8)
    Title.BackgroundTransparency = 1
    Title.Text = "KelTec • Premium"
    Title.TextColor3 = Config.Colors.Text
    Title.TextSize = 14
    Title.Font = Config.Fonts.Bold
    Title.ZIndex = 11
    Title.Parent = WatermarkFrame
    
    local InfoLabel = Instance.new("TextLabel")
    InfoLabel.Size = UDim2.new(1, -20, 0, 15)
    InfoLabel.Position = UDim2.new(0, 10, 0, 28)
    InfoLabel.BackgroundTransparency = 1
    InfoLabel.Text = "FPS: 0 | Ping: 0ms"
    InfoLabel.TextColor3 = Config.Colors.TextSecondary
    InfoLabel.TextSize = 11
    InfoLabel.Font = Config.Fonts.Main
    InfoLabel.ZIndex = 11
    InfoLabel.Parent = WatermarkFrame
    
    local TimeLabel = Instance.new("TextLabel")
    TimeLabel.Size = UDim2.new(1, -20, 0, 15)
    TimeLabel.Position = UDim2.new(0, 10, 0, 43)
    TimeLabel.BackgroundTransparency = 1
    TimeLabel.Text = os.date("%H:%M:%S")
    TimeLabel.TextColor3 = Config.Colors.TextMuted
    TimeLabel.TextSize = 10
    TimeLabel.Font = Config.Fonts.Main
    TimeLabel.ZIndex = 11
    TimeLabel.Parent = WatermarkFrame
    
    -- Update watermark info
    spawn(function()
        while WatermarkGui.Parent do
            InfoLabel.Text = string.format("FPS: %d | Ping: %dms", PerformanceMonitor.FPS, PerformanceMonitor.Ping)
            TimeLabel.Text = os.date("%H:%M:%S")
            wait(1)
        end
    end)
    
    return WatermarkGui
end

-- Initialize performance monitor
PerformanceMonitor:Start()

-- Console Commands System
local ConsoleCommands = {}

function ConsoleCommands:RegisterCommand(name, description, callback)
    self[name] = {
        description = description,
        callback = callback
    }
end

function ConsoleCommands:ExecuteCommand(command)
    local parts = command:split(" ")
    local commandName = parts[1]:lower()
    
    if self[commandName] then
        local args = {}
        for i = 2, #parts do
            table.insert(args, parts[i])
        end
        self[commandName].callback(unpack(args))
        return true
    end
    return false
end

-- Register default commands
ConsoleCommands:RegisterCommand("help", "Show all available commands", function()
    print("=== KelTec Console Commands ===")
    for name, cmd in pairs(ConsoleCommands) do
        if type(cmd) == "table" and cmd.description then
            print(name .. " - " .. cmd.description)
        end
    end
end)

ConsoleCommands:RegisterCommand("theme", "Change GUI theme", function(themeName)
    if themeName then
        ThemeManager:ApplyTheme(themeName)
    else
        print("Available themes: " .. table.concat(table.keys(ThemeManager.Themes), ", "))
    end
end)

ConsoleCommands:RegisterCommand("fps", "Show current FPS", function()
    print("Current FPS: " .. PerformanceMonitor.FPS)
end)

-- Export advanced systems
KelTecLib.NotificationSystem = NotificationSystem
KelTecLib.PerformanceMonitor = PerformanceMonitor
KelTecLib.ThemeManager = ThemeManager
KelTecLib.ConsoleCommands = ConsoleCommands
