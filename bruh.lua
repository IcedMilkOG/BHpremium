-- KelTech Mobile GUI Library v1.0
-- Optimized for mobile devices with touch support
-- Theme: Minty Green & Black/Grey

local KelGUI = {}
KelGUI.__index = KelGUI

-- Theme Configuration
KelGUI.theme = {
    primary = {52, 168, 123},      -- Minty calm green
    primaryDark = {41, 134, 98},   -- Darker green for hover
    background = {25, 25, 25},     -- Dark background
    surface = {40, 40, 40},        -- Surface color
    surfaceLight = {55, 55, 55},   -- Light surface
    text = {255, 255, 255},        -- White text
    textSecondary = {200, 200, 200}, -- Light grey text
    border = {80, 80, 80},         -- Border color
    shadow = {0, 0, 0, 50},        -- Shadow
}

-- Configuration
KelGUI.config = {
    toggleButtonSize = 50,
    toggleButtonPosition = {10, 10}, -- Top left
    cornerRadius = 8,
    padding = 12,
    spacing = 8,
    animationSpeed = 0.3,
    touchThreshold = 5, -- Pixels for touch detection
}

-- Initialize GUI
function KelGUI:new(options)
    local gui = setmetatable({}, KelGUI)
    gui.isVisible = false
    gui.isAnimating = false
    gui.animationTime = 0
    gui.customToggleButton = options and options.customToggleButton or nil
    gui.tabs = {}
    gui.activeTab = 1
    gui.tabPosition = (options and options.tabPosition) or "top" -- "top" or "left"
    gui.components = {}
    gui.dropdowns = {}
    gui.colorPicker = nil
    gui.touchStart = nil
    gui.isDragging = false
    
    -- Screen dimensions (should be set by the host application)
    gui.screenWidth = 800
    gui.screenHeight = 600
    
    return gui
end

-- Set screen dimensions
function KelGUI:setScreenSize(width, height)
    self.screenWidth = width
    self.screenHeight = height
end

-- Toggle GUI visibility
function KelGUI:toggle()
    if not self.isAnimating then
        self.isVisible = not self.isVisible
        self.isAnimating = true
        self.animationTime = 0
    end
end

-- Add new tab
function KelGUI:addTab(name, icon)
    table.insert(self.tabs, {
        name = name,
        icon = icon or "⚙",
        components = {},
        scrollY = 0
    })
    return #self.tabs
end

-- Add component to tab
function KelGUI:addComponent(tabIndex, component)
    if self.tabs[tabIndex] then
        table.insert(self.tabs[tabIndex].components, component)
    end
end

-- Create Category
function KelGUI:createCategory(name)
    return {
        type = "category",
        name = name,
        expanded = true
    }
end

-- Create Toggle Button
function KelGUI:createToggle(name, value, callback, column)
    return {
        type = "toggle",
        name = name,
        value = value or false,
        callback = callback or function() end,
        column = column or 1
    }
end

-- Create Slider
function KelGUI:createSlider(name, value, min, max, callback, column)
    return {
        type = "slider",
        name = name,
        value = value or 0,
        min = min or 0,
        max = max or 100,
        callback = callback or function() end,
        column = column or 1,
        isDragging = false
    }
end

-- Create Dropdown
function KelGUI:createDropdown(name, options, selected, callback, column)
    return {
        type = "dropdown",
        name = name,
        options = options or {},
        selected = selected or 1,
        callback = callback or function() end,
        column = column or 1,
        isOpen = false
    }
end

-- Create Color Picker Button
function KelGUI:createColorPicker(name, color, callback, column)
    return {
        type = "colorpicker",
        name = name,
        color = color or {255, 255, 255},
        callback = callback or function() end,
        column = column or 1
    }
end

-- Update function (call this in your main loop)
function KelGUI:update(dt, mouseX, mouseY, isPressed, justPressed, justReleased)
    -- Update animations
    if self.isAnimating then
        self.animationTime = self.animationTime + dt
        if self.animationTime >= self.config.animationSpeed then
            self.isAnimating = false
            self.animationTime = self.config.animationSpeed
        end
    end
    
    -- Handle touch/mouse input
    if justPressed then
        self:handleTouchStart(mouseX, mouseY)
    elseif isPressed then
        self:handleTouchMove(mouseX, mouseY)
    elseif justReleased then
        self:handleTouchEnd(mouseX, mouseY)
    end
end

-- Handle touch start
function KelGUI:handleTouchStart(x, y)
    self.touchStart = {x = x, y = y}
    self.isDragging = false
    
    -- Check toggle button
    local toggleX, toggleY = self.config.toggleButtonPosition[1], self.config.toggleButtonPosition[2]
    local toggleSize = self.config.toggleButtonSize
    
    if x >= toggleX and x <= toggleX + toggleSize and
       y >= toggleY and y <= toggleY + toggleSize then
        self:toggle()
        return
    end
    
    if not self.isVisible then return end
    
    -- Handle component interactions
    self:handleComponentTouch(x, y, true)
end

-- Handle touch move
function KelGUI:handleTouchMove(x, y)
    if not self.touchStart then return end
    
    local dx = x - self.touchStart.x
    local dy = y - self.touchStart.y
    local distance = math.sqrt(dx*dx + dy*dy)
    
    if distance > self.config.touchThreshold then
        self.isDragging = true
    end
    
    if self.isVisible then
        self:handleComponentTouch(x, y, false)
    end
end

-- Handle touch end
function KelGUI:handleTouchEnd(x, y)
    if self.isVisible and not self.isDragging then
        self:handleComponentTouch(x, y, false, true)
    end
    
    -- Reset sliders
    if self.tabs[self.activeTab] then
        for _, component in ipairs(self.tabs[self.activeTab].components) do
            if component.type == "slider" then
                component.isDragging = false
            end
        end
    end
    
    self.touchStart = nil
    self.isDragging = false
end

-- Handle component touch interactions
function KelGUI:handleComponentTouch(x, y, isStart, isEnd)
    if not self.tabs[self.activeTab] then return end
    
    local guiX, guiY, guiW, guiH = self:getGUIBounds()
    
    -- Handle tab clicks
    if self:isPointInTabs(x, y, guiX, guiY, guiW, guiH) then
        local tabIndex = self:getTabAtPoint(x, y, guiX, guiY, guiW, guiH)
        if tabIndex and isEnd then
            self.activeTab = tabIndex
        end
        return
    end
    
    -- Handle content area
    local contentX, contentY, contentW, contentH = self:getContentBounds(guiX, guiY, guiW, guiH)
    local columnW = (contentW - self.config.spacing) / 2
    
    local yOffset = contentY + self.config.padding - self.tabs[self.activeTab].scrollY
    
    for _, component in ipairs(self.tabs[self.activeTab].components) do
        local compX = contentX + self.config.padding
        if component.column == 2 then
            compX = compX + columnW + self.config.spacing
        end
        
        local compY = yOffset
        local compW = columnW - self.config.padding * 2
        local compH = self:getComponentHeight(component)
        
        if component.type == "category" then
            compW = contentW - self.config.padding * 2
        end
        
        if x >= compX and x <= compX + compW and y >= compY and y <= compY + compH then
            self:handleComponentInteraction(component, x - compX, y - compY, isStart, isEnd)
            break
        end
        
        yOffset = yOffset + compH + self.config.spacing
    end
end

-- Handle individual component interactions
function KelGUI:handleComponentInteraction(component, localX, localY, isStart, isEnd)
    if component.type == "toggle" and isEnd then
        component.value = not component.value
        component.callback(component.value)
        
    elseif component.type == "slider" then
        if isStart then
            component.isDragging = true
        end
        if component.isDragging then
            local sliderY = 30
            local sliderW = 200
            local percentage = math.max(0, math.min(1, localX / sliderW))
            component.value = component.min + (component.max - component.min) * percentage
            component.callback(component.value)
        end
        
    elseif component.type == "dropdown" and isEnd then
        component.isOpen = not component.isOpen
        
    elseif component.type == "colorpicker" and isEnd then
        self:openColorPicker(component)
        
    elseif component.type == "category" and isEnd then
        component.expanded = not component.expanded
    end
end

-- Open color picker popup
function KelGUI:openColorPicker(component)
    self.colorPicker = {
        component = component,
        hue = 0,
        saturation = 1,
        brightness = 1,
        alpha = 1
    }
end

-- Close color picker
function KelGUI:closeColorPicker()
    self.colorPicker = nil
end

-- Draw function (call this in your draw loop)
function KelGUI:draw()
    -- Draw toggle button
    self:drawToggleButton()
    
    if not self.isVisible and not self.isAnimating then return end
    
    -- Calculate animation progress
    local progress = 1
    if self.isAnimating then
        progress = self.animationTime / self.config.animationSpeed
        if not self.isVisible then
            progress = 1 - progress
        end
    end
    
    -- Draw main GUI
    self:drawGUI(progress)
    
    -- Draw color picker popup
    if self.colorPicker then
        self:drawColorPicker()
    end
end

-- Draw toggle button
function KelGUI:drawToggleButton()
    local x, y = self.config.toggleButtonPosition[1], self.config.toggleButtonPosition[2]
    local size = self.config.toggleButtonSize
    
    if self.customToggleButton then
        self.customToggleButton(x, y, size, self.isVisible)
    else
        -- Default toggle button
        self:setColor(self.theme.primary)
        self:drawRoundedRect(x, y, size, size, self.config.cornerRadius)
        
        self:setColor(self.theme.text)
        local iconX, iconY = x + size/2, y + size/2
        if self.isVisible then
            self:drawText("✕", iconX, iconY, "center")
        else
            self:drawText("≡", iconX, iconY, "center")
        end
    end
end

-- Draw main GUI
function KelGUI:drawGUI(progress)
    local guiX, guiY, guiW, guiH = self:getGUIBounds()
    
    -- Apply animation offset
    if self.tabPosition == "left" then
        guiX = guiX - (guiW * (1 - progress))
    else
        guiY = guiY - (guiH * (1 - progress))
    end
    
    -- Draw shadow
    self:setColor(self.theme.shadow)
    self:drawRoundedRect(guiX + 4, guiY + 4, guiW, guiH, self.config.cornerRadius)
    
    -- Draw main background
    self:setColor(self.theme.background)
    self:drawRoundedRect(guiX, guiY, guiW, guiH, self.config.cornerRadius)
    
    -- Draw tabs
    self:drawTabs(guiX, guiY, guiW, guiH)
    
    -- Draw content
    self:drawContent(guiX, guiY, guiW, guiH)
end

-- Draw tabs
function KelGUI:drawTabs(guiX, guiY, guiW, guiH)
    local tabHeight = 50
    local tabWidth = 120
    
    for i, tab in ipairs(self.tabs) do
        local tabX, tabY
        
        if self.tabPosition == "top" then
            tabX = guiX + (i - 1) * tabWidth
            tabY = guiY
        else -- left
            tabX = guiX
            tabY = guiY + (i - 1) * tabHeight
        end
        
        -- Tab background
        if i == self.activeTab then
            self:setColor(self.theme.primary)
        else
            self:setColor(self.theme.surface)
        end
        
        if self.tabPosition == "top" then
            self:drawRoundedRect(tabX, tabY, tabWidth, tabHeight, self.config.cornerRadius, true, true, false, false)
        else
            self:drawRoundedRect(tabX, tabY, tabWidth, tabHeight, self.config.cornerRadius, true, false, false, true)
        end
        
        -- Tab text
        self:setColor(self.theme.text)
        local textX = tabX + tabWidth/2
        local textY = tabY + tabHeight/2
        self:drawText(tab.icon .. " " .. tab.name, textX, textY, "center")
    end
end

-- Draw content area
function KelGUI:drawContent(guiX, guiY, guiW, guiH)
    local contentX, contentY, contentW, contentH = self:getContentBounds(guiX, guiY, guiW, guiH)
    
    -- Content background
    self:setColor(self.theme.surface)
    self:drawRect(contentX, contentY, contentW, contentH)
    
    if not self.tabs[self.activeTab] then return end
    
    -- Draw components in two columns
    local columnW = (contentW - self.config.spacing) / 2
    local yOffset = contentY + self.config.padding - self.tabs[self.activeTab].scrollY
    
    for _, component in ipairs(self.tabs[self.activeTab].components) do
        local compX = contentX + self.config.padding
        if component.column == 2 then
            compX = compX + columnW + self.config.spacing
        end
        
        local compY = yOffset
        local compW = columnW - self.config.padding * 2
        
        if component.type == "category" then
            compW = contentW - self.config.padding * 2
        end
        
        self:drawComponent(component, compX, compY, compW)
        yOffset = yOffset + self:getComponentHeight(component) + self.config.spacing
    end
end

-- Draw individual component
function KelGUI:drawComponent(component, x, y, width)
    if component.type == "category" then
        self:drawCategory(component, x, y, width)
    elseif component.type == "toggle" then
        self:drawToggle(component, x, y, width)
    elseif component.type == "slider" then
        self:drawSlider(component, x, y, width)
    elseif component.type == "dropdown" then
        self:drawDropdown(component, x, y, width)
    elseif component.type == "colorpicker" then
        self:drawColorPickerButton(component, x, y, width)
    end
end

-- Draw category
function KelGUI:drawCategory(component, x, y, width)
    local height = 40
    
    -- Background
    self:setColor(self.theme.surfaceLight)
    self:drawRoundedRect(x, y, width, height, self.config.cornerRadius/2)
    
    -- Text
    self:setColor(self.theme.text)
    self:drawText(component.name, x + self.config.padding, y + height/2, "left")
    
    -- Expand/collapse indicator
    local indicator = component.expanded and "▼" or "▶"
    self:drawText(indicator, x + width - 20, y + height/2, "center")
end

-- Draw toggle button
function KelGUI:drawToggle(component, x, y, width)
    local height = 35
    local toggleW = 50
    local toggleH = 25
    
    -- Label
    self:setColor(self.theme.text)
    self:drawText(component.name, x, y + height/2, "left")
    
    -- Toggle background
    local toggleX = x + width - toggleW
    local toggleY = y + (height - toggleH) / 2
    
    if component.value then
        self:setColor(self.theme.primary)
    else
        self:setColor(self.theme.border)
    end
    self:drawRoundedRect(toggleX, toggleY, toggleW, toggleH, toggleH/2)
    
    -- Toggle handle
    self:setColor(self.theme.text)
    local handleX = toggleX + (component.value and (toggleW - toggleH + 4) or 4)
    local handleY = toggleY + 2
    self:drawRoundedRect(handleX, handleY, toggleH - 4, toggleH - 4, (toggleH - 4)/2)
end

-- Draw slider
function KelGUI:drawSlider(component, x, y, width)
    local height = 50
    local sliderH = 6
    local handleSize = 20
    
    -- Label
    self:setColor(self.theme.text)
    self:drawText(component.name, x, y + 10, "left")
    
    -- Value
    local valueText = string.format("%.1f", component.value)
    self:drawText(valueText, x + width - 40, y + 10, "right")
    
    -- Slider track
    local sliderY = y + 30
    self:setColor(self.theme.border)
    self:drawRoundedRect(x, sliderY, width, sliderH, sliderH/2)
    
    -- Slider fill
    local percentage = (component.value - component.min) / (component.max - component.min)
    local fillW = width * percentage
    self:setColor(self.theme.primary)
    self:drawRoundedRect(x, sliderY, fillW, sliderH, sliderH/2)
    
    -- Slider handle
    local handleX = x + fillW - handleSize/2
    local handleY = sliderY - (handleSize - sliderH)/2
    self:setColor(self.theme.text)
    self:drawRoundedRect(handleX, handleY, handleSize, handleSize, handleSize/2)
end

-- Draw dropdown
function KelGUI:drawDropdown(component, x, y, width)
    local height = 35
    
    -- Background
    self:setColor(self.theme.surfaceLight)
    self:drawRoundedRect(x, y, width, height, self.config.cornerRadius/2)
    
    -- Border
    self:setColor(self.theme.border)
    self:drawRoundedRectOutline(x, y, width, height, self.config.cornerRadius/2)
    
    -- Selected text
    self:setColor(self.theme.text)
    local selectedText = component.options[component.selected] or "None"
    self:drawText(component.name .. ": " .. selectedText, x + self.config.padding, y + height/2, "left")
    
    -- Dropdown arrow
    self:drawText(component.isOpen and "▲" or "▼", x + width - 20, y + height/2, "center")
    
    -- Dropdown options
    if component.isOpen then
        local optionHeight = 30
        local dropdownY = y + height
        local dropdownH = #component.options * optionHeight
        
        -- Options background
        self:setColor(self.theme.surface)
        self:drawRect(x, dropdownY, width, dropdownH)
        
        -- Options border
        self:setColor(self.theme.border)
        self:drawRectOutline(x, dropdownY, width, dropdownH)
        
        -- Options
        for i, option in ipairs(component.options) do
            local optionY = dropdownY + (i - 1) * optionHeight
            
            if i == component.selected then
                self:setColor(self.theme.primary)
                self:drawRect(x, optionY, width, optionHeight)
            end
            
            self:setColor(self.theme.text)
            self:drawText(option, x + self.config.padding, optionY + optionHeight/2, "left")
        end
    end
end

-- Draw color picker button
function KelGUI:drawColorPickerButton(component, x, y, width)
    local height = 35
    local colorSize = 25
    
    -- Label
    self:setColor(self.theme.text)
    self:drawText(component.name, x, y + height/2, "left")
    
    -- Color preview
    local colorX = x + width - colorSize - 5
    local colorY = y + (height - colorSize) / 2
    
    self:setColor(component.color)
    self:drawRoundedRect(colorX, colorY, colorSize, colorSize, self.config.cornerRadius/2)
    
    self:setColor(self.theme.border)
    self:drawRoundedRectOutline(colorX, colorY, colorSize, colorSize, self.config.cornerRadius/2)
end

-- Draw color picker popup
function KelGUI:drawColorPicker()
    if not self.colorPicker then return end
    
    local pickerW, pickerH = 300, 400
    local pickerX = (self.screenWidth - pickerW) / 2
    local pickerY = (self.screenHeight - pickerH) / 2
    
    -- Background
    self:setColor(self.theme.background)
    self:drawRoundedRect(pickerX, pickerY, pickerW, pickerH, self.config.cornerRadius)
    
    -- Border
    self:setColor(self.theme.border)
    self:drawRoundedRectOutline(pickerX, pickerY, pickerW, pickerH, self.config.cornerRadius)
    
    -- Title
    self:setColor(self.theme.text)
    self:drawText("Color Picker", pickerX + pickerW/2, pickerY + 30, "center")
    
    -- Color preview
    local previewY = pickerY + 60
    local previewH = 40
    self:setColor(self.colorPicker.component.color)
    self:drawRoundedRect(pickerX + 20, previewY, pickerW - 40, previewH, self.config.cornerRadius/2)
    
    -- Close button
    self:setColor(self.theme.primary)
    self:drawRoundedRect(pickerX + 20, pickerY + pickerH - 60, pickerW - 40, 40, self.config.cornerRadius/2)
    
    self:setColor(self.theme.text)
    self:drawText("Close", pickerX + pickerW/2, pickerY + pickerH - 40, "center")
end

-- Utility functions
function KelGUI:getGUIBounds()
    local width = math.min(600, self.screenWidth * 0.9)
    local height = math.min(500, self.screenHeight * 0.8)
    local x = (self.screenWidth - width) / 2
    local y = (self.screenHeight - height) / 2
    return x, y, width, height
end

function KelGUI:getContentBounds(guiX, guiY, guiW, guiH)
    local tabHeight = 50
    if self.tabPosition == "top" then
        return guiX, guiY + tabHeight, guiW, guiH - tabHeight
    else
        return guiX + 120, guiY, guiW - 120, guiH
    end
end

function KelGUI:getComponentHeight(component)
    if component.type == "category" then return 40
    elseif component.type == "slider" then return 50
    else return 35 end
end

function KelGUI:isPointInTabs(x, y, guiX, guiY, guiW, guiH)
    if self.tabPosition == "top" then
        return y >= guiY and y <= guiY + 50
    else
        return x >= guiX and x <= guiX + 120
    end
end

function KelGUI:getTabAtPoint(x, y, guiX, guiY, guiW, guiH)
    if self.tabPosition == "top" then
        local tabIndex = math.floor((x - guiX) / 120) + 1
        return tabIndex <= #self.tabs and tabIndex or nil
    else
        local tabIndex = math.floor((y - guiY) / 50) + 1
        return tabIndex <= #self.tabs and tabIndex or nil
    end
end

-- Drawing helper functions (implement these based on your graphics library)
function KelGUI:setColor(color)
    -- Implement color setting for your graphics library
    -- Example: love.graphics.setColor(color[1]/255, color[2]/255, color[3]/255, (color[4] or 255)/255)
end

function KelGUI:drawRect(x, y, w, h)
    -- Implement rectangle drawing
    -- Example: love.graphics.rectangle("fill", x, y, w, h)
end

function KelGUI:drawRoundedRect(x, y, w, h, radius, tl, tr, bl, br)
    -- Implement rounded rectangle drawing
    -- Parameters: tl=top-left, tr=top-right, bl=bottom-left, br=bottom-right corners
    -- Default to all corners rounded if not specified
end

function KelGUI:drawRoundedRectOutline(x, y, w, h, radius)
    -- Implement rounded rectangle outline
end

function KelGUI:drawRectOutline(x, y, w, h)
    -- Implement rectangle outline
end

function KelGUI:drawText(text, x, y, align)
    -- Implement text drawing
    -- align can be "left", "center", "right"
end

return KelGUI