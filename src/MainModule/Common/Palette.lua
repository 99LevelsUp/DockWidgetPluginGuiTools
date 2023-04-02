
-- when studio is not present (aka in th game) the studio palette is not available
-- in that case internal dark theme palette is used instead
local studio_status, studio = pcall(function ()
    return settings().Studio
end)
--local studio_palette = require(script:WaitForChild("DarkThemePalette", 3))

-- some string manipulation functions
--if not string.startswith then
--    function string.startswith(s, value)
--        assert(s ~= nil and type(s) == "string", "Parameter #1 is mandatory and must be a string.")
--        assert(value ~= nil and type(value) == "string", "Parameter #2 is mandatory and must be a string.")
--        return #s >= #value and s:sub(1, #value) == value
--    end
--end
--if not string.endswith then
--    function string.endswith(s, value)
--        assert(s ~= nil and type(s) == "string", "Parameter #1 is mandatory and must be a string.")
--        assert(value ~= nil and type(value) == "string", "Parameter #2 is mandatory and must be a string.")
--        return #s >= #value and s:sub(#s - #value + 1) == value
--    end
--end

-- functions to split color name and modifier
local StudioStyleGuideModifier = {}
for _, eModifier in pairs(Enum.StudioStyleGuideModifier:GetEnumItems()) do
    StudioStyleGuideModifier[eModifier.Name] = eModifier
end
local function parseColorAndModifier(name)
    local modifier = nil
    for k, v in pairs(StudioStyleGuideModifier) do
        -- string.endsWith(name, k)
        if #name >= #k and name:sub(#name - #k + 1) == k then
            name = name:sub(1, #name - #k)
            modifier = v
            break
        end
    end
    return name, modifier
end

-- common palette containing all colors with all modifiers
local commonPalette = {}
for _, eColor in pairs(Enum.StudioStyleGuideColor:GetEnumItems()) do
    commonPalette[eColor.Name] = { }
    for _, eModifier in pairs(Enum.StudioStyleGuideModifier:GetEnumItems()) do
		commonPalette[eColor.Name][eModifier.Name] = { eColor, eModifier }
	end
end

local WidgetPalette = {}
local private = {}

-- find Enum.UITheme of actual Theme
local function getActualTheme() : Enum.UITheme?
	for _, t in pairs(Enum.UITheme:GetEnumItems()) do
		if not studio_status then
			return t
		elseif t.Name == studio.Theme.Name then
			return t
		end
	end
    return nil
end
WidgetPalette.ActualTheme = getActualTheme()

-- this "Event" fires when theme is changed.
-- in fact setting of any color should be made using this event
WidgetPalette.ThemeChanged = {
    conected = {}
}
function WidgetPalette.ThemeChanged:Connect(f)
    assert(f ~= nil and type(f) == "function", "Parameter #1 is mandatory and it must be a function!")
    self.connected[f] = f
    f(WidgetPalette.ActualTheme)
end
function WidgetPalette.ThemeChanged:Disconnect(f)
	self.connected[f] = nil
end
function WidgetPalette.ThemeChanged:Fire(theme)
    for _, f in pairs(self.connected) do
        f(theme)
    end
end
if studio_status then
	studio.ThemeChanged:Connect(function()
        WidgetPalette.ActualTheme = getActualTheme()
        WidgetPalette.ThemeChanged:Fire(WidgetPalette.ActualTheme)
	end)
end

-- register new palette color
WidgetPalette.__newindex = function(table, key, value)
    private[table].palette[key] = value
end

-- obtain actual color
WidgetPalette.__index = function(table, key)
    
    local function searchPaletteForColorName(palette, name)
        local modifier, color
        name, modifier = parseColorAndModifier(key)
        
        if palette ~= nil then
            -- first we are trying to get the raw name
            color = palette[key]
            if color ~= nil then
                name, modifier = key, Enum.StudioStyleGuideModifier.Default
                -- if color not found check the variant without modifier
            elseif modifier ~= nil then
                color = palette[name]
            else
                modifier = nil -- Enum.StudioStyleGuideModifier.Default
            end
        end

        return palette, color, name, modifier
    end
    
    local function getStudioColor(color, modifier)
        if typeof(color) == "Color3" then
            return color
        elseif studio_status then
            return studio.Theme:GetColor(color, modifier)
        -- else
        --     return studio_palette[color][modifier or Enum.StudioStyleGuideModifier.Default]
        end
        return nil
    end    
    
    local function ifExistsThenGetColorDefinition(definition, modifier, notFound)
        if typeof(definition) == "Color3" then
            return definition, definition
        elseif typeof(definition) == "EnumItem" and definition.EnumType == Enum.StudioStyleGuideColor then
            return getStudioColor(definition, modifier), definition
        elseif typeof(definition) == "table" and definition[1] then
            return getStudioColor(definition[1], definition[2] or modifier), definition
        elseif typeof(definition) == "table" and definition["color"] then
            return getStudioColor(definition["color"], definition["modifier"] or modifier), definition
        elseif typeof(definition) == "table" then
            return notFound, definition
        else
            return notFound, definition
        end
    end
    
    local _usedPalette, colorDefinition, name, modifier
    _usedPalette, colorDefinition, name, modifier = searchPaletteForColorName(private[table].palette, key)
    if not colorDefinition then
        _usedPalette, colorDefinition, name, modifier = searchPaletteForColorName(commonPalette, key)
    end
    
    -- at this time we had to find the name
    if colorDefinition == nil then
        error(string.format("Color name [%s] not found!", key), 2)
    end
    
    local theme = WidgetPalette.ActualTheme
    
    local color = ifExistsThenGetColorDefinition(colorDefinition, modifier)
    if typeof(colorDefinition) == "table" and colorDefinition[theme] then
        color = ifExistsThenGetColorDefinition(colorDefinition[theme], modifier, color)
    end
    if typeof(colorDefinition) == "table" and colorDefinition[modifier] then
        color, colorDefinition = ifExistsThenGetColorDefinition(colorDefinition[modifier], nil, color)
        if typeof(colorDefinition) == "table" and colorDefinition[theme] then
            color = ifExistsThenGetColorDefinition(colorDefinition[theme], nil, color)
        end
    end
    
    -- and here we found the color for sure
    assert(typeof(color) == "Color3", string.format("Color definition [%s].[%s].[%s] not found!", name, (modifier or {}).Name or "", theme.Name))
    
    -- TODO add some caching
    
    return color    
end

function WidgetPalette.new()
    local self = {}
    private[self] = {}
    private[self].palette = {}
    self.destroy = function(this)
        private[this] = nil
    end
    setmetatable(self, WidgetPalette)
    return self
end

return WidgetPalette