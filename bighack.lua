-- Modern GUI System with Code-Based Save System (Raydium Edition)
-- Combines new modern interface with all original working systems + Code Save functionality

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

print("=== RAYDIUM BIGHACK GUI WITH CODE SAVES STARTING ===")

-- Load Raydium Library
local Raydium = loadstring(game:HttpGet("https://raw.githubusercontent.com/Retnuhzeez/Raydium/main/source.lua"))()

-- Feature toggles (same as original)
local features = {
    particles = true,
    headCircles = true,
    selectionBoxes = true,
    statusLabel = true,
    playerESP = true,
    distance = true,
    crosshair = true,
    fovCircle = true,
    crosshairSpin = false,
    xray = false,
    snaplines = false,
    bigHitboxes = false,
    armorESP = false
}

-- Visual settings (updated with color and style)
local visualSettings = {
    fovCircleSize = 100,
    crosshairSize = 16,
    crosshairSpinSpeed = 50,
    crosshairColor = {r = 0, g = 150, b = 255}, -- Default blue
    fovCircleColor = {r = 255, g = 255, b = 255}, -- Default white
    crosshairStyle = "Plus" -- Default crosshair style
}

-- Performance settings
local PERFORMANCE_MODE = true
local MAX_PARTICLES_PER_PLAYER = 3
local UPDATE_FREQUENCY = 3
local MAX_PLAYERS_PER_FRAME = 8

-- Cache for expensive detection results
local armorCache = {}
local layingCache = {}

-- NEW CODE-BASED SAVE SYSTEM VARIABLES
local codeInputRef = nil
local codeDisplayRef = nil
local saveStatusRef = nil

-- Predefined save codes with their configurations
local predefinedCodes = {
    ["COMBAT"] = {
        features = {
            particles = false, headCircles = true, selectionBoxes = true, statusLabel = true,
            playerESP = true, distance = true, crosshair = true, fovCircle = true,
            crosshairSpin = false, xray = false, snaplines = true, bigHitboxes = false, armorESP = true
        },
        visualSettings = {
            fovCircleSize = 120, crosshairSize = 20, crosshairSpinSpeed = 50,
            crosshairColor = {r = 255, g = 0, b = 0}, fovCircleColor = {r = 255, g = 255, b = 255},
            crosshairStyle = "Plus"
        },
        performanceMode = true
    },
    ["VISUAL"] = {
        features = {
            particles = true, headCircles = true, selectionBoxes = true, statusLabel = true,
            playerESP = true, distance = true, crosshair = true, fovCircle = true,
            crosshairSpin = true, xray = false, snaplines = false, bigHitboxes = false, armorESP = false
        },
        visualSettings = {
            fovCircleSize = 150, crosshairSize = 24, crosshairSpinSpeed = 100,
            crosshairColor = {r = 0, g = 255, b = 255}, fovCircleColor = {r = 0, g = 255, b = 0},
            crosshairStyle = "Star"
        },
        performanceMode = false
    },
    ["STEALTH"] = {
        features = {
            particles = false, headCircles = false, selectionBoxes = false, statusLabel = false,
            playerESP = true, distance = false, crosshair = true, fovCircle = false,
            crosshairSpin = false, xray = true, snaplines = false, bigHitboxes = false, armorESP = false
        },
        visualSettings = {
            fovCircleSize = 80, crosshairSize = 12, crosshairSpinSpeed = 30,
            crosshairColor = {r = 100, g = 100, b = 100}, fovCircleColor = {r = 50, g = 50, b = 50},
            crosshairStyle = "Dot"
        },
        performanceMode = true
    },
    ["RAINBOW"] = {
        features = {
            particles = true, headCircles = true, selectionBoxes = true, statusLabel = true,
            playerESP = true, distance = true, crosshair = true, fovCircle = true,
            crosshairSpin = true, xray = false, snaplines = true, bigHitboxes = false, armorESP = true
        },
        visualSettings = {
            fovCircleSize = 200, crosshairSize = 28, crosshairSpinSpeed = 150,
            crosshairColor = {r = 255, g = 0, b = 255}, fovCircleColor = {r = 255, g = 255, b = 0},
            crosshairStyle = "Target"
        },
        performanceMode = false
    },
    ["MINIMAL"] = {
        features = {
            particles = false, headCircles = false, selectionBoxes = false, statusLabel = false,
            playerESP = false, distance = false, crosshair = true, fovCircle = false,
            crosshairSpin = false, xray = false, snaplines = false, bigHitboxes = false, armorESP = false
        },
        visualSettings = {
            fovCircleSize = 50, crosshairSize = 8, crosshairSpinSpeed = 20,
            crosshairColor = {r = 255, g = 255, b = 255}, fovCircleColor = {r = 255, g = 255, b = 255},
            crosshairStyle = "Plus"
        },
        performanceMode = true
    }
}

-- Wait for PlayerGui
if not LocalPlayer.PlayerGui then
    LocalPlayer.CharacterAdded:Wait()
    wait(1)
end

-- Create main ScreenGui for visual elements
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BigHackVisuals"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = LocalPlayer.PlayerGui

-- CROSSHAIR SYSTEM - DEFINE EARLY BEFORE GUI CREATION
local crosshairElements = {}

-- Function to create crosshair style elements
local function createCrosshairStyle(style, size, color)
    if style == "Plus" then
        local horizontal = Instance.new("Frame")
        horizontal.Size = UDim2.new(0, size, 0, 1)
        horizontal.Position = UDim2.new(0.5, -size/2, 0.41, -0.5)
        horizontal.BackgroundColor3 = color
        horizontal.BorderSizePixel = 0
        horizontal.Visible = false
        horizontal.ZIndex = 1
        horizontal.Parent = screenGui
        
        local vertical = Instance.new("Frame")
        vertical.Size = UDim2.new(0, 1, 0, size)
        vertical.Position = UDim2.new(0.5, -0.5, 0.41, -size/2)
        vertical.BackgroundColor3 = color
        vertical.BorderSizePixel = 0
        vertical.Visible = false
        vertical.ZIndex = 1
        vertical.Parent = screenGui
        
        return {horizontal, vertical}
        
    elseif style == "X-Shape" then
        local diagonal1 = Instance.new("Frame")
        diagonal1.Size = UDim2.new(0, size * 1.4, 0, 1)
        diagonal1.Position = UDim2.new(0.5, -size * 0.7, 0.41, -0.5)
        diagonal1.BackgroundColor3 = color
        diagonal1.BorderSizePixel = 0
        diagonal1.Visible = false
        diagonal1.ZIndex = 1
        diagonal1.Rotation = 45
        diagonal1.Parent = screenGui
        
        local diagonal2 = Instance.new("Frame")
        diagonal2.Size = UDim2.new(0, size * 1.4, 0, 1)
        diagonal2.Position = UDim2.new(0.5, -size * 0.7, 0.41, -0.5)
        diagonal2.BackgroundColor3 = color
        diagonal2.BorderSizePixel = 0
        diagonal2.Visible = false
        diagonal2.ZIndex = 1
        diagonal2.Rotation = -45
        diagonal2.Parent = screenGui
        
        return {diagonal1, diagonal2}
        
    elseif style == "Circle" then
        local circle = Instance.new("Frame")
        circle.Size = UDim2.new(0, size, 0, size)
        circle.Position = UDim2.new(0.5, -size/2, 0.41, -size/2)
        circle.BackgroundTransparency = 1
        circle.BorderSizePixel = 0
        circle.Visible = false
        circle.ZIndex = 1
        circle.Parent = screenGui
        
        local stroke = Instance.new("UIStroke")
        stroke.Color = color
        stroke.Thickness = 1
        stroke.Parent = circle
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(1, 0)
        corner.Parent = circle
        
        return {circle}
        
    elseif style == "Dot" then
        local dot = Instance.new("Frame")
        dot.Size = UDim2.new(0, 3, 0, 3)
        dot.Position = UDim2.new(0.5, -1.5, 0.41, -1.5)
        dot.BackgroundColor3 = color
        dot.BorderSizePixel = 0
        dot.Visible = false
        dot.ZIndex = 1
        dot.Parent = screenGui
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(1, 0)
        corner.Parent = dot
        
        return {dot}
        
    elseif style == "Arrow" then
        local shaft = Instance.new("Frame")
        shaft.Size = UDim2.new(0, 2, 0, size * 0.8)
        shaft.Position = UDim2.new(0.5, -1, 0.41, -size * 0.4)
        shaft.BackgroundColor3 = color
        shaft.BorderSizePixel = 0
        shaft.Visible = false
        shaft.ZIndex = 1
        shaft.Parent = screenGui
        
        local arrowhead1 = Instance.new("Frame")
        arrowhead1.Size = UDim2.new(0, size * 0.4, 0, 2)
        arrowhead1.Position = UDim2.new(0.5, -size * 0.2, 0.41, -size * 0.4)
        arrowhead1.BackgroundColor3 = color
        arrowhead1.BorderSizePixel = 0
        arrowhead1.Visible = false
        arrowhead1.ZIndex = 1
        arrowhead1.Rotation = 45
        arrowhead1.Parent = screenGui
        
        local arrowhead2 = Instance.new("Frame")
        arrowhead2.Size = UDim2.new(0, size * 0.4, 0, 2)
        arrowhead2.Position = UDim2.new(0.5, -size * 0.2, 0.41, -size * 0.4)
        arrowhead2.BackgroundColor3 = color
        arrowhead2.BorderSizePixel = 0
        arrowhead2.Visible = false
        arrowhead2.ZIndex = 1
        arrowhead2.Rotation = -45
        arrowhead2.Parent = screenGui
        
        return {shaft, arrowhead1, arrowhead2}
        
    elseif style == "Target" then
        local outer = Instance.new("Frame")
        outer.Size = UDim2.new(0, size, 0, size)
        outer.Position = UDim2.new(0.5, -size/2, 0.41, -size/2)
        outer.BackgroundTransparency = 1
        outer.BorderSizePixel = 0
        outer.Visible = false
        outer.ZIndex = 1
        outer.Parent = screenGui
        
        local outerStroke = Instance.new("UIStroke")
        outerStroke.Color = color
        outerStroke.Thickness = 1
        outerStroke.Parent = outer
        
        local outerCorner = Instance.new("UICorner")
        outerCorner.CornerRadius = UDim.new(1, 0)
        outerCorner.Parent = outer
        
        local inner = Instance.new("Frame")
        inner.Size = UDim2.new(0, size * 0.6, 0, size * 0.6)
        inner.Position = UDim2.new(0.5, -size * 0.3, 0.41, -size * 0.3)
        inner.BackgroundTransparency = 1
        inner.BorderSizePixel = 0
        inner.Visible = false
        inner.ZIndex = 1
        inner.Parent = screenGui
        
        local innerStroke = Instance.new("UIStroke")
        innerStroke.Color = color
        innerStroke.Thickness = 1
        innerStroke.Parent = inner
        
        local innerCorner = Instance.new("UICorner")
        innerCorner.CornerRadius = UDim.new(1, 0)
        innerCorner.Parent = inner
        
        local center = Instance.new("Frame")
        center.Size = UDim2.new(0, 2, 0, 2)
        center.Position = UDim2.new(0.5, -1, 0.41, -1)
        center.BackgroundColor3 = color
        center.BorderSizePixel = 0
        center.Visible = false
        center.ZIndex = 1
        center.Parent = screenGui
        
        local centerCorner = Instance.new("UICorner")
        centerCorner.CornerRadius = UDim.new(1, 0)
        centerCorner.Parent = center
        
        return {outer, inner, center}
        
    elseif style == "Star" then
        local elements = {}
        local thickness = 2
        
        -- Create 4 diagonal lines for 8-point star
        for i = 1, 4 do
            local line = Instance.new("Frame")
            line.Size = UDim2.new(0, size * 0.7, 0, thickness)
            line.Position = UDim2.new(0.5, -size * 0.35, 0.41, -thickness/2)
            line.BackgroundColor3 = color
            line.BorderSizePixel = 0
            line.Visible = false
            line.ZIndex = 1
            line.Rotation = (i - 1) * 45
            line.Parent = screenGui
            table.insert(elements, line)
        end
        
        return elements
        
    elseif style == "Diamond" then
        local diamond = Instance.new("Frame")
        diamond.Size = UDim2.new(0, size * 0.8, 0, size * 0.8)
        diamond.Position = UDim2.new(0.5, -size * 0.4, 0.41, -size * 0.4)
        diamond.BackgroundTransparency = 1
        diamond.BorderSizePixel = 0
        diamond.Visible = false
        diamond.ZIndex = 1
        diamond.Rotation = 45
        diamond.Parent = screenGui
        
        local diamondStroke = Instance.new("UIStroke")
        diamondStroke.Color = color
        diamondStroke.Thickness = 1
        diamondStroke.Parent = diamond
        
        local diamondCorner = Instance.new("UICorner")
        diamondCorner.CornerRadius = UDim.new(0, 4)
        diamondCorner.Parent = diamond
        
        return {diamond}
    end
    
    return {}
end

-- Function to update crosshair style
local function updateCrosshairStyle()
    -- Hide all crosshair styles
    for style, elements in pairs(crosshairElements) do
        for _, element in pairs(elements) do
            element.Visible = false
        end
    end
    
    -- Show current style if crosshair is enabled
    if features.crosshair then
        local currentStyle = visualSettings.crosshairStyle
        if crosshairElements[currentStyle] then
            for _, element in pairs(crosshairElements[currentStyle]) do
                element.Visible = true
            end
        end
    end
end

-- Function to update crosshair colors
local function updateCrosshairColors()
    local color = Color3.fromRGB(visualSettings.crosshairColor.r, visualSettings.crosshairColor.g, visualSettings.crosshairColor.b)
    
    for style, elements in pairs(crosshairElements) do
        for _, element in pairs(elements) do
            if element:FindFirstChild("UIStroke") then
                element.UIStroke.Color = color
            else
                element.BackgroundColor3 = color
            end
        end
    end
end

-- Function to update crosshair size
local function updateCrosshairSize()
    local size = visualSettings.crosshairSize
    
    for style, elements in pairs(crosshairElements) do
        if style == "Plus" and #elements >= 2 then
            -- horizontal
            elements[1].Size = UDim2.new(0, size, 0, 1)
            elements[1].Position = UDim2.new(0.5, -size/2, 0.41, -0.5)
            -- vertical
            elements[2].Size = UDim2.new(0, 1, 0, size)
            elements[2].Position = UDim2.new(0.5, -0.5, 0.41, -size/2)
            
        elseif style == "X-Shape" and #elements >= 2 then
            -- diagonal1
            elements[1].Size = UDim2.new(0, size * 1.4, 0, 1)
            elements[1].Position = UDim2.new(0.5, -size * 0.7, 0.41, -0.5)
            -- diagonal2
            elements[2].Size = UDim2.new(0, size * 1.4, 0, 1)
            elements[2].Position = UDim2.new(0.5, -size * 0.7, 0.41, -0.5)
            
        elseif style == "Circle" and #elements >= 1 then
            elements[1].Size = UDim2.new(0, size, 0, size)
            elements[1].Position = UDim2.new(0.5, -size/2, 0.41, -size/2)
            
        elseif style == "Dot" and #elements >= 1 then
            -- Dot size stays constant but position updates
            elements[1].Position = UDim2.new(0.5, -1.5, 0.41, -1.5)
            
        elseif style == "Arrow" and #elements >= 3 then
            -- shaft
            elements[1].Size = UDim2.new(0, 2, 0, size * 0.8)
            elements[1].Position = UDim2.new(0.5, -1, 0.41, -size * 0.4)
            -- arrowhead1
            elements[2].Size = UDim2.new(0, size * 0.4, 0, 2)
            elements[2].Position = UDim2.new(0.5, -size * 0.2, 0.41, -size * 0.4)
            -- arrowhead2
            elements[3].Size = UDim2.new(0, size * 0.4, 0, 2)
            elements[3].Position = UDim2.new(0.5, -size * 0.2, 0.41, -size * 0.4)
            
        elseif style == "Target" and #elements >= 3 then
            -- outer circle
            elements[1].Size = UDim2.new(0, size, 0, size)
            elements[1].Position = UDim2.new(0.5, -size/2, 0.41, -size/2)
            -- inner circle
            elements[2].Size = UDim2.new(0, size * 0.6, 0, size * 0.6)
            elements[2].Position = UDim2.new(0.5, -size * 0.3, 0.41, -size * 0.3)
            -- center dot stays same size
            elements[3].Position = UDim2.new(0.5, -1, 0.41, -1)
            
        elseif style == "Star" and #elements >= 4 then
            for i = 1, #elements do
                elements[i].Size = UDim2.new(0, size * 0.7, 0, 2)
                elements[i].Position = UDim2.new(0.5, -size * 0.35, 0.41, -1)
            end
            
        elseif style == "Diamond" and #elements >= 1 then
            elements[1].Size = UDim2.new(0, size * 0.8, 0, size * 0.8)
            elements[1].Position = UDim2.new(0.5, -size * 0.4, 0.41, -size * 0.4)
        end
    end
    
    -- Force update the current style visibility
    updateCrosshairStyle()
end

-- Initialize crosshair elements for all styles
local function initializeCrosshairs()
    local styles = {"Plus", "X-Shape", "Circle", "Dot", "Arrow", "Target", "Star", "Diamond"}
    local color = Color3.fromRGB(visualSettings.crosshairColor.r, visualSettings.crosshairColor.g, visualSettings.crosshairColor.b)
    
    for _, style in ipairs(styles) do
        crosshairElements[style] = createCrosshairStyle(style, visualSettings.crosshairSize, color)
    end
end

-- Initialize all crosshair styles
initializeCrosshairs()

-- NEW CODE-BASED SAVE SYSTEM FUNCTIONS

-- Function to generate current configuration code
local function generateConfigCode()
    -- Create a simple string that represents current settings
    local codeData = {}
    
    -- Add feature flags (1 = true, 0 = false)
    table.insert(codeData, features.particles and "1" or "0")
    table.insert(codeData, features.headCircles and "1" or "0")
    table.insert(codeData, features.selectionBoxes and "1" or "0")
    table.insert(codeData, features.statusLabel and "1" or "0")
    table.insert(codeData, features.playerESP and "1" or "0")
    table.insert(codeData, features.distance and "1" or "0")
    table.insert(codeData, features.crosshair and "1" or "0")
    table.insert(codeData, features.fovCircle and "1" or "0")
    table.insert(codeData, features.crosshairSpin and "1" or "0")
    table.insert(codeData, features.xray and "1" or "0")
    table.insert(codeData, features.snaplines and "1" or "0")
    table.insert(codeData, features.bigHitboxes and "1" or "0")
    table.insert(codeData, features.armorESP and "1" or "0")
    table.insert(codeData, PERFORMANCE_MODE and "1" or "0")
    
    -- Add separator
    table.insert(codeData, "|")
    
    -- Add visual settings (encoded as numbers)
    table.insert(codeData, tostring(visualSettings.fovCircleSize))
    table.insert(codeData, tostring(visualSettings.crosshairSize))
    table.insert(codeData, tostring(visualSettings.crosshairSpinSpeed))
    table.insert(codeData, tostring(visualSettings.crosshairColor.r))
    table.insert(codeData, tostring(visualSettings.crosshairColor.g))
    table.insert(codeData, tostring(visualSettings.crosshairColor.b))
    table.insert(codeData, tostring(visualSettings.fovCircleColor.r))
    table.insert(codeData, tostring(visualSettings.fovCircleColor.g))
    table.insert(codeData, tostring(visualSettings.fovCircleColor.b))
    
    -- Add crosshair style (encoded as number)
    local styleIndex = 1
    local styles = {"Plus", "X-Shape", "Circle", "Dot", "Arrow", "Target", "Star", "Diamond"}
    for i, style in ipairs(styles) do
        if style == visualSettings.crosshairStyle then
            styleIndex = i
            break
        end
    end
    table.insert(codeData, tostring(styleIndex))
    
    return table.concat(codeData, "-")
end

-- Function to apply configuration from code
local function applyConfigFromCode(code)
    if not code or code == "" then
        return false, "Code cannot be empty!"
    end
    
    -- Check if it's a predefined code
    if predefinedCodes[code:upper()] then
        local config = predefinedCodes[code:upper()]
        
        -- Apply features
        for key, value in pairs(config.features) do
            if features[key] ~= nil then
                features[key] = value
            end
        end
        
        -- Apply visual settings
        for key, value in pairs(config.visualSettings) do
            if visualSettings[key] ~= nil then
                visualSettings[key] = value
            end
        end
        
        -- Apply performance mode
        if config.performanceMode ~= nil then
            PERFORMANCE_MODE = config.performanceMode
        end
        
        -- Update visual elements
        updateCrosshairStyle()
        updateCrosshairColors()
        updateCrosshairSize()
        
        return true, "Applied predefined code: " .. code:upper()
    end
    
    -- Parse custom code
    local parts = {}
    for part in string.gmatch(code, "[^-]+") do
        table.insert(parts, part)
    end
    
    if #parts < 15 then
        return false, "Invalid code format!"
    end
    
    -- Find separator
    local separatorIndex = nil
    for i, part in ipairs(parts) do
        if part == "|" then
            separatorIndex = i
            break
        end
    end
    
    if not separatorIndex then
        return false, "Invalid code format - missing separator!"
    end
    
    -- Apply feature flags
    local featureKeys = {
        "particles", "headCircles", "selectionBoxes", "statusLabel", "playerESP",
        "distance", "crosshair", "fovCircle", "crosshairSpin", "xray",
        "snaplines", "bigHitboxes", "armorESP"
    }
    
    for i, key in ipairs(featureKeys) do
        if parts[i] and features[key] ~= nil then
            features[key] = parts[i] == "1"
        end
    end
    
    -- Apply performance mode
    if parts[14] then
        PERFORMANCE_MODE = parts[14] == "1"
    end
    
    -- Apply visual settings
    local visualIndex = separatorIndex + 1
    if parts[visualIndex] then visualSettings.fovCircleSize = tonumber(parts[visualIndex]) or 100 end
    if parts[visualIndex + 1] then visualSettings.crosshairSize = tonumber(parts[visualIndex + 1]) or 16 end
    if parts[visualIndex + 2] then visualSettings.crosshairSpinSpeed = tonumber(parts[visualIndex + 2]) or 50 end
    if parts[visualIndex + 3] then visualSettings.crosshairColor.r = tonumber(parts[visualIndex + 3]) or 0 end
    if parts[visualIndex + 4] then visualSettings.crosshairColor.g = tonumber(parts[visualIndex + 4]) or 150 end
    if parts[visualIndex + 5] then visualSettings.crosshairColor.b = tonumber(parts[visualIndex + 5]) or 255 end
    if parts[visualIndex + 6] then visualSettings.fovCircleColor.r = tonumber(parts[visualIndex + 6]) or 255 end
    if parts[visualIndex + 7] then visualSettings.fovCircleColor.g = tonumber(parts[visualIndex + 7]) or 255 end
    if parts[visualIndex + 8] then visualSettings.fovCircleColor.b = tonumber(parts[visualIndex + 8]) or 255 end
    
    -- Apply crosshair style
    if parts[visualIndex + 9] then
        local styles = {"Plus", "X-Shape", "Circle", "Dot", "Arrow", "Target", "Star", "Diamond"}
        local styleIndex = tonumber(parts[visualIndex + 9]) or 1
        if styles[styleIndex] then
            visualSettings.crosshairStyle = styles[styleIndex]
        end
    end
    
    -- Update visual elements
    updateCrosshairStyle()
    updateCrosshairColors()
    updateCrosshairSize()
    
    return true, "Custom code applied successfully!"
end

-- RAYDIUM GUI CREATION
local Window = Raydium.CreateWindow({
    Title = "BIGHACK - Premium Edition",
    SubTitle = "v1.0.0 | Fully Featured ESP System",
    Size = UDim2.fromOffset(580, 400),
    Theme = {
        Colors = {
            -- Black background theme with blue accents
            Background = Color3.fromRGB(0, 0, 0),
            Primary = Color3.fromRGB(15, 15, 15),
            Secondary = Color3.fromRGB(25, 25, 25),
            Accent = Color3.fromRGB(0, 120, 255),
            Text = Color3.fromRGB(255, 255, 255),
            TextDimmed = Color3.fromRGB(180, 180, 180),
            Border = Color3.fromRGB(40, 40, 40),
            Success = Color3.fromRGB(0, 150, 255),
            Warning = Color3.fromRGB(255, 165, 0),
            Error = Color3.fromRGB(255, 80, 80)
        }
    }
})

-- Create tabs with the same structure as original
local CombatTab = Window.CreateTab({
    Title = "⚔ Combat",
    Icon = "sword"
})

local VisualsTab = Window.CreateTab({
    Title = "👁 Visuals", 
    Icon = "eye"
})

local WorldTab = Window.CreateTab({
    Title = "🌍 World",
    Icon = "globe"
})

local MiscTab = Window.CreateTab({
    Title = "⚙ Misc",
    Icon = "settings"
})

local SavesTab = Window.CreateTab({
    Title = "💾 Saves",
    Icon = "save"
})

-- COMBAT TAB
CombatTab.CreateToggle({
    Title = "Player ESP",
    Description = "Highlight all players",
    Default = features.playerESP,
    Callback = function(value)
        features.playerESP = value
    end
})

CombatTab.CreateToggle({
    Title = "Head Circles", 
    Description = "Show circles on player heads",
    Default = features.headCircles,
    Callback = function(value)
        features.headCircles = value
    end
})

CombatTab.CreateToggle({
    Title = "Armor ESP",
    Description = "Highlight player armor", 
    Default = features.armorESP,
    Callback = function(value)
        features.armorESP = value
    end
})

CombatTab.CreateToggle({
    Title = "Snaplines",
    Description = "Lines to closest players",
    Default = features.snaplines,
    Callback = function(value)
        features.snaplines = value
    end
})

CombatTab.CreateToggle({
    Title = "Distance",
    Description = "Show distance to players",
    Default = features.distance,
    Callback = function(value)
        features.distance = value
    end
})

CombatTab.CreateToggle({
    Title = "Selection Boxes",
    Description = "Boxes around players",
    Default = features.selectionBoxes,
    Callback = function(value)
        features.selectionBoxes = value
    end
})

-- VISUALS TAB
VisualsTab.CreateToggle({
    Title = "Crosshair",
    Description = "Custom crosshair overlay",
    Default = features.crosshair,
    Callback = function(value)
        features.crosshair = value
        updateCrosshairStyle()
    end
})

VisualsTab.CreateDropdown({
    Title = "Crosshair Style",
    Description = "Choose crosshair shape",
    Values = {"Plus", "X-Shape", "Circle", "Dot", "Arrow", "Target", "Star", "Diamond"},
    Default = visualSettings.crosshairStyle,
    Callback = function(value)
        visualSettings.crosshairStyle = value
        updateCrosshairStyle()
    end
})

VisualsTab.CreateSlider({
    Title = "Crosshair Size",
    Description = "Adjust crosshair size",
    Min = 8,
    Max = 40,
    Default = visualSettings.crosshairSize,
    Callback = function(value)
        visualSettings.crosshairSize = value
        updateCrosshairSize()
    end
})

VisualsTab.CreateColorPicker({
    Title = "Crosshair Color",
    Description = "Customize crosshair color",
    Default = Color3.fromRGB(visualSettings.crosshairColor.r, visualSettings.crosshairColor.g, visualSettings.crosshairColor.b),
    Callback = function(color)
        visualSettings.crosshairColor = {
            r = math.floor(color.R * 255),
            g = math.floor(color.G * 255), 
            b = math.floor(color.B * 255)
        }
        updateCrosshairColors()
    end
})

VisualsTab.CreateToggle({
    Title = "Crosshair Spin",
    Description = "Animated spinning crosshair",
    Default = features.crosshairSpin,
    Callback = function(value)
        features.crosshairSpin = value
    end
})

VisualsTab.CreateSlider({
    Title = "Spin Speed",
    Description = "Crosshair rotation speed",
    Min = 10,
    Max = 200,
    Default = visualSettings.crosshairSpinSpeed,
    Callback = function(value)
        visualSettings.crosshairSpinSpeed = value
    end
})

VisualsTab.CreateToggle({
    Title = "FOV Circle",
    Description = "Field of view indicator",
    Default = features.fovCircle,
    Callback = function(value)
        features.fovCircle = value
    end
})

VisualsTab.CreateSlider({
    Title = "FOV Size",
    Description = "FOV circle radius",
    Min = 50,
    Max = 300,
    Default = visualSettings.fovCircleSize,
    Callback = function(value)
        visualSettings.fovCircleSize = value
    end
})

VisualsTab.CreateColorPicker({
    Title = "FOV Circle Color",
    Description = "Customize FOV circle color",
    Default = Color3.fromRGB(visualSettings.fovCircleColor.r, visualSettings.fovCircleColor.g, visualSettings.fovCircleColor.b),
    Callback = function(color)
        visualSettings.fovCircleColor = {
            r = math.floor(color.R * 255),
            g = math.floor(color.G * 255),
            b = math.floor(color.B * 255)
        }
    end
})

VisualsTab.CreateToggle({
    Title = "Particle Trails",
    Description = "Visual particle effects",
    Default = features.particles,
    Callback = function(value)
        features.particles = value
    end
})

-- WORLD TAB
WorldTab.CreateToggle({
    Title = "X-Ray Vision",
    Description = "See through walls",
    Default = features.xray,
    Callback = function(value)
        features.xray = value
    end
})

WorldTab.CreateToggle({
    Title = "Expanded Hitboxes", 
    Description = "Larger player hitboxes",
    Default = features.bigHitboxes,
    Callback = function(value)
        features.bigHitboxes = value
    end
})

-- MISC TAB
MiscTab.CreateToggle({
    Title = "Status Display",
    Description = "Show system information",
    Default = features.statusLabel,
    Callback = function(value)
        features.statusLabel = value
    end
})

MiscTab.CreateToggle({
    Title = "Performance Mode",
    Description = "Optimize for better FPS",
    Default = PERFORMANCE_MODE,
    Callback = function(value)
        PERFORMANCE_MODE = value
    end
})

-- SAVES TAB
SavesTab.CreateSection({
    Title = "Configuration Management"
})

local generatedCodeDisplay = SavesTab.CreateTextbox({
    Title = "Generated Code",
    Description = "Your current configuration code",
    PlaceholderText = "Click 'Generate Code' to create...",
    ReadOnly = true
})

SavesTab.CreateButton({
    Title = "🎯 Generate Current Config Code",
    Description = "Create a shareable code for your settings",
    Callback = function()
        local code = generateConfigCode()
        generatedCodeDisplay.SetText(code)
        
        if setclipboard then
            setclipboard(code)
            Window.CreateNotification({
                Title = "Success",
                Description = "Code generated and copied to clipboard!",
                Duration = 3
            })
        else
            Window.CreateNotification({
                Title = "Generated",
                Description = "Code created! Copy it manually.",
                Duration = 3
            })
        end
    end
})

SavesTab.CreateSection({
    Title = "Quick Load Presets"
})

local presetButtons = {
    {code = "COMBAT", desc = "Combat focused setup", color = "Error"},
    {code = "VISUAL", desc = "Visual effects setup", color = "Accent"},
    {code = "STEALTH", desc = "Minimal visibility", color = "TextDimmed"},
    {code = "RAINBOW", desc = "Full effects setup", color = "Warning"},
    {code = "MINIMAL", desc = "Performance focused", color = "Success"}
}

for _, preset in ipairs(presetButtons) do
    SavesTab.CreateButton({
        Title = preset.code .. " - " .. preset.desc,
        Description = "Load the " .. preset.code:lower() .. " preset configuration",
        Callback = function()
            local success, message = applyConfigFromCode(preset.code)
            Window.CreateNotification({
                Title = success and "Success" or "Error",
                Description = message,
                Duration = 3
            })
        end
    })
end

SavesTab.CreateSection({
    Title = "Load Custom Code"
})

local codeInput = SavesTab.CreateTextbox({
    Title = "Custom Code Input",
    Description = "Paste your configuration code here",
    PlaceholderText = "Paste code here..."
})

SavesTab.CreateButton({
    Title = "📥 Load Configuration Code",
    Description = "Apply the entered configuration code",
    Callback = function()
        local inputCode = codeInput.GetText()
        if inputCode == "" then
            Window.CreateNotification({
                Title = "Error",
                Description = "Please enter a code first!",
                Duration = 3
            })
        else
            local success, message = applyConfigFromCode(inputCode)
            Window.CreateNotification({
                Title = success and "Success" or "Error", 
                Description = message,
                Duration = 3
            })
            
            if success then
                codeInput.SetText("")
            end
        end
    end
})

print("Raydium GUI created, now creating all visual elements...")

-- CREATE ALL ORIGINAL VISUAL ELEMENTS

-- Create status label
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(0, 300, 0, 40)
statusLabel.Position = UDim2.new(0, 10, 0, 70)
statusLabel.BackgroundColor3 = Color3.new(0, 0, 0)
statusLabel.BackgroundTransparency = 0.3
statusLabel.TextColor3 = Color3.new(1, 1, 1)
statusLabel.Text = "LOADING..."
statusLabel.Font = Enum.Font.SourceSansBold
statusLabel.TextScaled = true
statusLabel.ZIndex = 1
statusLabel.Parent = screenGui

-- Create particles (green dots)
local particles = {}
for i = 1, 20 do
    local particle = Instance.new("Frame")
    particle.Size = UDim2.new(0, 3, 0, 3)
    particle.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    particle.BorderSizePixel = 0
    particle.Visible = false
    particle.ZIndex = 1
    particle.Parent = screenGui
    table.insert(particles, particle)
end

-- Create head circles (red circles)
local headCircles = {}
for i = 1, 10 do
    local circle = Instance.new("Frame")
    circle.Size = UDim2.new(0, 20, 0, 20)
    circle.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    circle.BackgroundTransparency = 0.4
    circle.BorderSizePixel = 0
    circle.Visible = false
    circle.ZIndex = 1
    circle.Parent = screenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = circle
    
    table.insert(headCircles, circle)
end

-- Create selection boxes (hollow yellow rectangles)
local selectionBoxes = {}
for i = 1, 10 do
    local container = Instance.new("Frame")
    container.Size = UDim2.new(0, 50, 0, 70)
    container.BackgroundTransparency = 1
    container.Visible = false
    container.ZIndex = 1
    container.Parent = screenGui
    
    -- Create thin hollow border using 4 separate frames
    local topBorder = Instance.new("Frame")
    topBorder.Name = "TopBorder"
    topBorder.Size = UDim2.new(1, 0, 0, 1)
    topBorder.Position = UDim2.new(0, 0, 0, 0)
    topBorder.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
    topBorder.BorderSizePixel = 0
    topBorder.ZIndex = 1
    topBorder.Parent = container
    
    local bottomBorder = Instance.new("Frame")
    bottomBorder.Name = "BottomBorder"
    bottomBorder.Size = UDim2.new(1, 0, 0, 1)
    bottomBorder.Position = UDim2.new(0, 0, 1, -1)
    bottomBorder.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
    bottomBorder.BorderSizePixel = 0
    bottomBorder.ZIndex = 1
    bottomBorder.Parent = container
    
    local leftBorder = Instance.new("Frame")
    leftBorder.Name = "LeftBorder"
    leftBorder.Size = UDim2.new(0, 1, 1, 0)
    leftBorder.Position = UDim2.new(0, 0, 0, 0)
    leftBorder.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
    leftBorder.BorderSizePixel = 0
    leftBorder.ZIndex = 1
    leftBorder.Parent = container
    
    local rightBorder = Instance.new("Frame")
    rightBorder.Name = "RightBorder"
    rightBorder.Size = UDim2.new(0, 1, 1, 0)
    rightBorder.Position = UDim2.new(1, -1, 0, 0)
    rightBorder.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
    rightBorder.BorderSizePixel = 0
    rightBorder.ZIndex = 1
    rightBorder.Parent = container
    
    table.insert(selectionBoxes, container)
end

-- Create distance labels
local distanceLabels = {}
for i = 1, 10 do
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 80, 0, 20)
    label.BackgroundTransparency = 1
    label.Text = "[0]"
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Font = Enum.Font.SourceSansBold
    label.TextSize = 14
    label.TextStrokeTransparency = 0.5
    label.TextStrokeColor3 = Color3.new(0, 0, 0)
    label.Visible = false
    label.ZIndex = 1
    label.Parent = screenGui
    
    table.insert(distanceLabels, label)
end

-- Create snaplines
local snaplines = {}
for i = 1, 3 do
    local snapline = Instance.new("Frame")
    snapline.Size = UDim2.new(0, 1, 0, 100)
    snapline.Position = UDim2.new(0.5, -0.5, 1, 0)
    snapline.BackgroundColor3 = Color3.new(1, 1, 1)
    snapline.BackgroundTransparency = 0.5
    snapline.BorderSizePixel = 0
    snapline.Visible = false
    snapline.AnchorPoint = Vector2.new(0.5, 1)
    snapline.ZIndex = 1
    snapline.Parent = screenGui
    table.insert(snaplines, snapline)
end

-- Create FOV circle
local fovCircle = Instance.new("Frame")
fovCircle.Size = UDim2.new(0, 200, 0, 200)
fovCircle.Position = UDim2.new(0.5, -100, 0.41, -100)
fovCircle.BackgroundTransparency = 1
fovCircle.BorderSizePixel = 0
fovCircle.Visible = false
fovCircle.ZIndex = 1
fovCircle.Parent = screenGui

local fovCircleStroke = Instance.new("UIStroke")
fovCircleStroke.Color = Color3.fromRGB(visualSettings.fovCircleColor.r, visualSettings.fovCircleColor.g, visualSettings.fovCircleColor.b)
fovCircleStroke.Thickness = 2
fovCircleStroke.Transparency = 0.3
fovCircleStroke.Parent = fovCircle

local fovCircleCorner = Instance.new("UICorner")
fovCircleCorner.CornerRadius = UDim.new(1, 0)
fovCircleCorner.Parent = fovCircle

-- Create watermark
local watermark = Instance.new("TextLabel")
watermark.Size = UDim2.new(0, 350, 0, 40)
watermark.Position = UDim2.new(0.5, -175, 0, -40)
watermark.BackgroundTransparency = 1
watermark.Text = "— BIGHACK - PREMIUM [v1.0.0] —"
watermark.TextColor3 = Color3.new(1, 0, 0)
watermark.Font = Enum.Font.SourceSansBold
watermark.TextSize = 24
watermark.TextStrokeTransparency = 0.3
watermark.TextStrokeColor3 = Color3.new(0, 0, 0)
watermark.ZIndex = 1
watermark.Parent = screenGui

-- ESP Highlights storage
local espHighlights = {}
local armorHighlights = {}
local xrayParts = {}
local originalTransparencies = {}
local bigHitboxHeads = {}
local originalHeadSizes = {}
local originalHeadCanCollide = {}
local originalHeadTransparency = {}
local originalHeadColors = {}

-- HSV to RGB conversion function for rainbow colors
local function HSVtoRGB(h, s, v)
    local r, g, b
    local i = math.floor(h * 6)
    local f = h * 6 - i
    local p = v * (1 - s)
    local q = v * (1 - f * s)
    local t = v * (1 - (1 - f) * s)
    
    i = i % 6
    
    if i == 0 then
        r, g, b = v, t, p
    elseif i == 1 then
        r, g, b = q, v, p
    elseif i == 2 then
        r, g, b = p, v, t
    elseif i == 3 then
        r, g, b = p, q, v
    elseif i == 4 then
        r, g, b = t, p, v
    elseif i == 5 then
        r, g, b = v, p, q
    end
    
    return r, g, b
end

-- Player ESP function (FIXED SIMPLE VERSION)
local function updatePlayerESP(players)
    if not features.playerESP then
        for character, highlight in pairs(espHighlights) do
            if highlight and highlight.Parent then
                pcall(function() highlight:Destroy() end)
            end
        end
        espHighlights = {}
        return
    end
    
    local currentCharacters = {}
    
    for _, playerData in ipairs(players) do
        if playerData.character and playerData.character.Parent then
            currentCharacters[playerData.character] = true
            
            -- Check if ESP exists and is valid
            local needsNewESP = false
            if not espHighlights[playerData.character] then
                needsNewESP = true
            elseif not espHighlights[playerData.character].Parent then
                needsNewESP = true
            end
            
            if needsNewESP then
                -- Clean up any broken ESP
                if espHighlights[playerData.character] then
                    pcall(function() espHighlights[playerData.character]:Destroy() end)
                    espHighlights[playerData.character] = nil
                end
                
                -- Create new ESP
                local success, highlight = pcall(function()
                    local h = Instance.new("Highlight")
                    h.FillColor = Color3.fromRGB(0, 255, 0)
                    h.FillTransparency = 0.3
                    h.OutlineColor = Color3.fromRGB(0, 200, 0)
                    h.OutlineTransparency = 0
                    h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    h.Parent = playerData.character
                    return h
                end)
                
                if success and highlight then
                    espHighlights[playerData.character] = highlight
                end
            end
        end
    end
    
    -- Clean up old highlights
    for character, highlight in pairs(espHighlights) do
        if not currentCharacters[character] or not character.Parent then
            if highlight and highlight.Parent then
                pcall(function() highlight:Destroy() end)
            end
            espHighlights[character] = nil
        end
    end
end

-- Armor ESP function
local function updateArmorESP(players)
    if not features.armorESP then
        for item, highlight in pairs(armorHighlights) do
            if highlight and highlight.Parent then
                highlight:Destroy()
            end
        end
        armorHighlights = {}
        return
    end
    
    local currentArmorItems = {}
    
    for _, playerData in ipairs(players) do
        if playerData.character and playerData.character.Parent then
            for _, obj in pairs(playerData.character:GetDescendants()) do
                if obj:IsA("BasePart") or obj:IsA("MeshPart") then
                    local isBodyPart = obj.Name == "Head" or obj.Name == "Torso" or obj.Name == "UpperTorso" or 
                                     obj.Name == "LowerTorso" or obj.Name == "Left Arm" or obj.Name == "Right Arm" or
                                     obj.Name == "LeftUpperArm" or obj.Name == "RightUpperArm" or obj.Name == "LeftLowerArm" or
                                     obj.Name == "RightLowerArm" or obj.Name == "LeftHand" or obj.Name == "RightHand" or
                                     obj.Name == "Left Leg" or obj.Name == "Right Leg" or obj.Name == "LeftUpperLeg" or
                                     obj.Name == "RightUpperLeg" or obj.Name == "LeftLowerLeg" or obj.Name == "RightLowerLeg" or
                                     obj.Name == "LeftFoot" or obj.Name == "RightFoot" or obj.Name == "HumanoidRootPart"
                    
                    local isAccessory = obj.Parent and (obj.Parent:IsA("Accessory") or obj.Parent:IsA("Tool"))
                    
                    if (not isBodyPart or isAccessory) and obj.Parent then
                        currentArmorItems[obj] = true
                        
                        if not armorHighlights[obj] then
                            local success, highlight = pcall(function()
                                local h = Instance.new("Highlight")
                                h.FillColor = Color3.fromRGB(0, 150, 255)
                                h.FillTransparency = 0.2
                                h.OutlineColor = Color3.fromRGB(0, 100, 255)
                                h.OutlineTransparency = 0
                                h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                                h.Parent = obj
                                return h
                            end)
                            
                            if success and highlight then
                                armorHighlights[obj] = highlight
                            end
                        end
                    end
                end
            end
        end
    end
    
    for item, highlight in pairs(armorHighlights) do
        if not currentArmorItems[item] or not item.Parent then
            if highlight and highlight.Parent then
                highlight:Destroy()
            end
            armorHighlights[item] = nil
        end
    end
end

-- X-ray function
local function updateXray()
    if features.xray then
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj.Parent and obj.Parent.Name ~= "Camera" then
                local isPlayerPart = false
                for _, player in pairs(game.Players:GetPlayers()) do
                    if player.Character and obj:IsDescendantOf(player.Character) then
                        isPlayerPart = true
                        break
                    end
                end
                
                if not isPlayerPart and not xrayParts[obj] then
                    originalTransparencies[obj] = obj.Transparency
                    xrayParts[obj] = true
                    obj.Transparency = 0.8
                end
            end
        end
    else
        for part, _ in pairs(xrayParts) do
            if part and part.Parent then
                part.Transparency = originalTransparencies[part] or 0
            end
        end
        xrayParts = {}
        originalTransparencies = {}
    end
end

-- Big hitboxes function
local function updateBigHitboxes()
    if features.bigHitboxes then
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj.Name == "Head" and obj:IsA("BasePart") and obj.Parent then
                local character = obj.Parent
                if character and character:FindFirstChild("HumanoidRootPart") then
                    if not bigHitboxHeads[obj] then
                        originalHeadSizes[obj] = obj.Size
                        originalHeadCanCollide[obj] = obj.CanCollide
                        originalHeadTransparency[obj] = obj.Transparency
                        originalHeadColors[obj] = obj.Color
                        bigHitboxHeads[obj] = true
                        
                        obj.Size = Vector3.new(8.5, 8.5, 8.5)
                        obj.CanCollide = false
                        obj.Transparency = 0.7
                        obj.Color = Color3.fromRGB(255, 0, 0)
                    end
                end
            end
        end
    else
        for head, _ in pairs(bigHitboxHeads) do
            if head and head.Parent then
                head.Size = originalHeadSizes[head] or Vector3.new(2, 1, 1)
                head.CanCollide = originalHeadCanCollide[head] or false
                head.Transparency = originalHeadTransparency[head] or 0
                head.Color = originalHeadColors[head] or Color3.fromRGB(163, 162, 165)
            end
        end
        bigHitboxHeads = {}
        originalHeadSizes = {}
        originalHeadCanCollide = {}
        originalHeadTransparency = {}
        originalHeadColors = {}
    end
end

-- Function to check if character has armor
local function hasArmor(character)
    if not character then return false end
    
    for _, obj in pairs(character:GetDescendants()) do
        if obj:IsA("BasePart") or obj:IsA("MeshPart") then
            local objName = obj.Name:lower()
            local parentName = obj.Parent and obj.Parent.Name:lower() or ""
            
            local armorKeywords = {
                "armor", "vest", "helmet", "chestplate", "leggings", "boots", "shield", 
                "plate", "mail", "guard", "protection", "defensive", "body", "chest"
            }
            
            if obj.Parent and obj.Parent:IsA("Accessory") then
                for _, keyword in ipairs(armorKeywords) do
                    if objName:find(keyword) or parentName:find(keyword) then
                        return true
                    end
                end
            end
            
            local isBodyPart = objName == "head" or objName == "torso" or objName == "uppertorso" or 
                             objName == "lowertorso" or objName:find("arm") or objName:find("hand") or
                             objName:find("leg") or objName:find("foot") or objName == "humanoidrootpart"
            
            if not isBodyPart and obj.Parent then
                for _, keyword in ipairs(armorKeywords) do
                    if objName:find(keyword) or parentName:find(keyword) then
                        return true
                    end
                end
            end
        end
    end
    
    return false
end

-- Function to check if player is laying down
local function isPlayerLayingDown(character)
    if not character or not character:FindFirstChild("HumanoidRootPart") or not character:FindFirstChild("Head") then
        return false
    end
    
    local head = character.Head
    local humanoidRootPart = character.HumanoidRootPart
    
    local headPosition = head.Position
    local rootPosition = humanoidRootPart.Position
    
    if rootPosition.Y > headPosition.Y then
        return true
    end
    
    return false
end

-- Simple but reliable player detection (FIXED VERSION)
local function findPlayers()
    local found = {}
    
    -- Get all real players
    for _, player in pairs(Players:GetPlayers()) do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            table.insert(found, {
                name = player.Name,
                rootPart = player.Character.HumanoidRootPart,
                character = player.Character,
                isRealPlayer = true
            })
        end
    end
    
    -- Get NPCs/other characters
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name == "HumanoidRootPart" and obj:IsA("BasePart") then
            local alreadyFound = false
            for _, existing in ipairs(found) do
                if existing.rootPart == obj then
                    alreadyFound = true
                    break
                end
            end
            
            if not alreadyFound and obj.Parent then
                local name = obj.Parent.Name
                local shouldShow = not (name:lower():find("arm") or name:lower():find("fps") or name:lower():find("tool"))
                
                if shouldShow then
                    table.insert(found, {
                        name = name,
                        rootPart = obj,
                        character = obj.Parent,
                        isRealPlayer = false
                    })
                end
            end
        end
    end
    
    return found
end

-- Main update function (SIMPLIFIED VERSION)
local updateCount = 0
local startTime = tick()
local frameSkipCounter = 0

local function update()
    updateCount = updateCount + 1
    frameSkipCounter = frameSkipCounter + 1
    
    -- Update watermark rainbow effect
    local currentTime = tick()
    local rainbowSpeed = 2
    local hue = ((currentTime * rainbowSpeed) % 6) / 6
    local r, g, b = HSVtoRGB(hue, 1, 1)
    watermark.TextColor3 = Color3.new(r, g, b)
    
    -- Update crosshair
    updateCrosshairStyle()
    updateCrosshairColors()
    
    if features.crosshair then
        local currentStyle = visualSettings.crosshairStyle
        if crosshairElements[currentStyle] then
            if features.crosshairSpin then
                local elapsedTime = currentTime - startTime
                local rotationAngle = (elapsedTime * visualSettings.crosshairSpinSpeed) % 360
                
                for _, element in pairs(crosshairElements[currentStyle]) do
                    if currentStyle == "X-Shape" then
                        local index = 1
                        for i, elem in ipairs(crosshairElements[currentStyle]) do
                            if elem == element then
                                index = i
                                break
                            end
                        end
                        element.Rotation = rotationAngle + (index == 1 and 45 or -45)
                    elseif currentStyle == "Star" then
                        local index = 1
                        for i, elem in ipairs(crosshairElements[currentStyle]) do
                            if elem == element then
                                index = i
                                break
                            end
                        end
                        element.Rotation = rotationAngle + (index - 1) * 45
                    else
                        element.Rotation = rotationAngle
                    end
                end
            else
                for _, element in pairs(crosshairElements[currentStyle]) do
                    if currentStyle == "X-Shape" then
                        local index = 1
                        for i, elem in ipairs(crosshairElements[currentStyle]) do
                            if elem == element then
                                index = i
                                break
                            end
                        end
                        element.Rotation = index == 1 and 45 or -45
                    elseif currentStyle == "Star" then
                        local index = 1
                        for i, elem in ipairs(crosshairElements[currentStyle]) do
                            if elem == element then
                                index = i
                                break
                            end
                        end
                        element.Rotation = (index - 1) * 45
                    elseif currentStyle == "Diamond" then
                        element.Rotation = 45
                    else
                        element.Rotation = 0
                    end
                end
            end
        end
    end
    
    -- Update FOV circle
    if features.fovCircle then
        fovCircle.Visible = true
        local size = visualSettings.fovCircleSize * 2
        fovCircle.Size = UDim2.new(0, size, 0, size)
        fovCircle.Position = UDim2.new(0.5, -size/2, 0.41, -size/2)
        fovCircleStroke.Color = Color3.fromRGB(visualSettings.fovCircleColor.r, visualSettings.fovCircleColor.g, visualSettings.fovCircleColor.b)
    else
        fovCircle.Visible = false
    end
    
    local success, players = pcall(findPlayers)
    if not success then
        if features.statusLabel then
            statusLabel.Text = "ERROR FINDING PLAYERS - " .. updateCount
        end
        return
    end
    
    if updateCount % 60 == 0 then
        local currentCharacters = {}
        for _, playerData in ipairs(players) do
            if playerData.character then
                currentCharacters[playerData.character] = true
            end
        end
        
        for character, _ in pairs(armorCache) do
            if not currentCharacters[character] then
                armorCache[character] = nil
            end
        end
        
        for character, _ in pairs(layingCache) do
            if not currentCharacters[character] then
                layingCache[character] = nil
            end
        end
    end
    
    local camera = workspace.CurrentCamera
    
    if frameSkipCounter >= UPDATE_FREQUENCY then
        frameSkipCounter = 0
        
        pcall(updatePlayerESP, players)
        pcall(updateArmorESP, players)
        
        if updateCount % 10 == 0 then
            pcall(updateXray)
            pcall(updateBigHitboxes)
        end
    end
    
    -- Update snaplines
    if features.snaplines then
        local validPlayers = {}
        local bottomCenterX = camera.ViewportSize.X / 2
        local bottomCenterY = camera.ViewportSize.Y
        
        local maxSnaplinesPlayers = PERFORMANCE_MODE and 5 or 10
        local playerCount = 0
        
        for _, playerData in ipairs(players) do
            if playerCount >= maxSnaplinesPlayers then break end
            
            if playerData.rootPart and playerData.rootPart.Parent then
                local name = playerData.name:lower()
                local shouldTarget = not name:find("arm")
                
                if shouldTarget then
                    local headPos = playerData.rootPart.Position + Vector3.new(0, 1.5, 0)
                    if playerData.character and playerData.character:FindFirstChild("Head") then
                        headPos = playerData.character.Head.Position
                    end
                    
                    local success, screenPos, onScreen = pcall(function()
                        return camera:WorldToScreenPoint(headPos)
                    end)
                    
                    if success and onScreen and screenPos.Z > 0 then
                        local distance = (camera.CFrame.Position - headPos).Magnitude
                        table.insert(validPlayers, {
                            playerData = playerData,
                            screenPos = screenPos,
                            distance = distance
                        })
                        playerCount = playerCount + 1
                    end
                end
            end
        end
        
        table.sort(validPlayers, function(a, b)
            return a.distance < b.distance
        end)
        
        for i = 1, 3 do
            local snapline = snaplines[i]
            
            if validPlayers[i] then
                local player = validPlayers[i]
                local targetX = player.screenPos.X
                local targetY = player.screenPos.Y
                
                local deltaX = targetX - bottomCenterX
                local deltaY = targetY - bottomCenterY
                local lineLength = math.sqrt(deltaX * deltaX + deltaY * deltaY)
                local angle = math.deg(math.atan2(deltaX, -deltaY))
                
                snapline.Size = UDim2.new(0, 1, 0, lineLength)
                snapline.Position = UDim2.new(0, bottomCenterX, 0, bottomCenterY)
                snapline.Rotation = angle
                snapline.Visible = true
            else
                snapline.Visible = false
            end
        end
    else
        for i = 1, 3 do
            snaplines[i].Visible = false
        end
    end
    
    if not camera then
        if features.statusLabel then
            statusLabel.Text = "NO CAMERA - " .. updateCount
        end
        return
    end
    
    statusLabel.Visible = features.statusLabel
    
    if features.statusLabel then
        statusLabel.Text = "PLAYERS: " .. #players .. " | PERF MODE: " .. tostring(PERFORMANCE_MODE) .. " | UPDATE " .. updateCount
    end
    
    local particleIndex = 1
    local circleIndex = 1
    local boxIndex = 1
    local distanceIndex = 1
    
    for i = 1, #particles do
        particles[i].Visible = false
    end
    for i = 1, #headCircles do
        headCircles[i].Visible = false
    end
    for i = 1, #selectionBoxes do
        selectionBoxes[i].Visible = false
    end
    for i = 1, #distanceLabels do
        distanceLabels[i].Visible = false
    end
    
    for _, playerData in ipairs(players) do
        if playerData.rootPart and playerData.rootPart.Parent then
            local success, screenPos, onScreen = pcall(function()
                return camera:WorldToScreenPoint(playerData.rootPart.Position)
            end)
            
            if success and onScreen and screenPos.Z > 0 then
                local distance = (camera.CFrame.Position - playerData.rootPart.Position).Magnitude
                
                if features.distance and distanceIndex <= #distanceLabels then
                    local distanceLabel = distanceLabels[distanceIndex]
                    local distanceText = "[" .. math.floor(distance) .. "]"
                    distanceLabel.Text = distanceText
                    distanceLabel.Position = UDim2.new(0, screenPos.X - 40, 0, screenPos.Y - 60)
                    distanceLabel.Visible = true
                    distanceIndex = distanceIndex + 1
                end
                
                if features.particles then
                    local particleCount = PERFORMANCE_MODE and MAX_PARTICLES_PER_PLAYER or 5
                    for i = 1, particleCount do
                        if particleIndex <= #particles then
                            local particle = particles[particleIndex]
                            local y = screenPos.Y - (i * 30)
                            particle.Position = UDim2.new(0, screenPos.X, 0, y)
                            particle.Visible = true
                            particleIndex = particleIndex + 1
                        end
                    end
                end
                
                if features.headCircles and circleIndex <= #headCircles then
                    local circle = headCircles[circleIndex]
                    
                    local headPos = playerData.rootPart.Position + Vector3.new(0, 1.5, 0)
                    if playerData.character and playerData.character:FindFirstChild("Head") then
                        headPos = playerData.character.Head.Position
                    end
                    
                    local headSuccess, headScreenPos = pcall(function()
                        return camera:WorldToScreenPoint(headPos)
                    end)
                    
                    if headSuccess and headScreenPos.Z > 0 then
                        local circleSize = math.max(8, math.min(20, 400 / distance))
                        
                        if updateCount % 20 == 0 or armorCache[playerData.character] == nil then
                            armorCache[playerData.character] = hasArmor(playerData.character)
                        end
                        local hasArmorEquipped = armorCache[playerData.character] or false
                        
                        if hasArmorEquipped then
                            circle.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
                        else
                            circle.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                        end
                        
                        circle.Size = UDim2.new(0, circleSize, 0, circleSize)
                        circle.Position = UDim2.new(0, headScreenPos.X - (circleSize/2), 0, headScreenPos.Y - (circleSize/2))
                        circle.Visible = true
                        circleIndex = circleIndex + 1
                    end
                end
                
                if features.selectionBoxes and not playerData.name:lower():find("arm") and boxIndex <= #selectionBoxes then
                    local box = selectionBoxes[boxIndex]
                    
                    if updateCount % 15 == 0 or layingCache[playerData.character] == nil then
                        layingCache[playerData.character] = isPlayerLayingDown(playerData.character)
                    end
                    local isLayingDown = layingCache[playerData.character] or false
                    
                    local baseSize = math.max(20, math.min(50, 1000 / distance))
                    local boxWidth, boxHeight
                    
                    if isLayingDown then
                        boxWidth = math.min(baseSize * 1.8, 90)
                        boxHeight = math.min(baseSize * 0.5, 25)
                    else
                        boxWidth = math.min(baseSize, 50)
                        boxHeight = math.min(baseSize * 1.4, 70)
                    end
                    
                    local boxColor = isLayingDown and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 255, 0)
                    
                    local topBorder = box:FindFirstChild("TopBorder")
                    local bottomBorder = box:FindFirstChild("BottomBorder")
                    local leftBorder = box:FindFirstChild("LeftBorder")
                    local rightBorder = box:FindFirstChild("RightBorder")
                    
                    if topBorder then topBorder.BackgroundColor3 = boxColor end
                    if bottomBorder then bottomBorder.BackgroundColor3 = boxColor end
                    if leftBorder then leftBorder.BackgroundColor3 = boxColor end
                    if rightBorder then rightBorder.BackgroundColor3 = boxColor end
                    
                    box.Size = UDim2.new(0, boxWidth, 0, boxHeight)
                    box.Position = UDim2.new(0, screenPos.X - (boxWidth/2), 0, screenPos.Y - (boxHeight/2))
                    box.Visible = true
                    boxIndex = boxIndex + 1
                end
            end
        end
    end
    
    if features.statusLabel then
        statusLabel.Text = "PLAYERS: " .. #players .. " | PARTICLES: " .. (particleIndex-1) .. " | CIRCLES: " .. (circleIndex-1) .. " | BOXES: " .. (boxIndex-1) .. " | DISTANCES: " .. (distanceIndex-1) .. " | PERF: " .. tostring(PERFORMANCE_MODE)
    end
end

-- Start the update loop
statusLabel.Text = "STARTING RAYDIUM UPDATE LOOP"

local connection = RunService.Heartbeat:Connect(function()
    pcall(update)
end)

print("=== RAYDIUM CODE-BASED SAVE SYSTEM LOADED SUCCESSFULLY ===")

-- Return the tables for external use
return {
    features = features,
    visualSettings = visualSettings,
    screenGui = screenGui,
    predefinedCodes = predefinedCodes,
    Window = Window
}
