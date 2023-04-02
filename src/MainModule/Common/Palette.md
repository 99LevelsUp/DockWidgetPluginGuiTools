# Overview

Palette is simple class for storing colors using descriptive names. It can store exact colors (using `Color3` values) or color names (using `Enum.StudioStyleGuideColor` values).

# Usage

``` lua
local Palette = require(<path/to/palette>)

-- create palette for this module
local palette = Palette.new()

-- assign colors
palette.Button = Enum.StudioStyleGuideColor.Button
palette.DefaultButton = { Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Default }

-- use colors
local button = Instance.new("TextButton")
button.BackgroundColor3 = palette.Button
```
# API

## Constructors

### new

Creates new palette class.

``` lua
local palette = Palette.new()
```

## Properties

### {name} [Color3] | [Enum.StudioStyleGuideColor] | { [Enum.StudioStyleGuideColor], [Enum.StudioStyleGuideModifier]? } | { [[Enum.UITheme]]: Color } | { [[Enum.StudioStyleGuideModifier]]: Color }

This property holds all the palette functionality. When declaring palette programmer assigns colors to symbolic names and when reading palette, the names return ```Color3``` value.

``` lua
local palette = Palette.new()

-- static colors stays the same regardles of context
palette.FirstColor = Color3.new(0.1, 0.1, 0.1)
local firstColor = palette.FirstColor -- this will allways evaluate to Color3.new(0.1, 0.1, 0.1)

-- when you define named color, you can add modifier directly to color name
palette.SecondColor = Enum.StudioStyleGuideColor.Button
local secondColor = palette.SecondColor -- == settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button)
local secondColorSelected = palette.SecondColorSelected -- == settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Selected)

-- however, when you define color using modifier, it will allways use this modifier
palette.ThirdColor = { Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Selected }
local thirdColor = palette.ThirdColor -- == settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Selected)
local thirdColorPressed = palette.ThirdColorPressed -- == settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Selected)

-- you can define different color for different modifiers
palette.FourthColor = {
    [ Enum.StudioStyleGuideModifier.Default ]  = Color3.new(0.1, 0.1, 0.1),
    [ Enum.StudioStyleGuideModifier.Selected ]  = Enum.StudioStyleGuideColor.Button,
}
local fourthColor = palette.FourthColor -- == Color3.new(0.1, 0.1, 0.1)
local fourthColorSelected = palette.FourthColorSelected -- == settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button)
local fourthColorPressed = palette.FourthColorPressed -- error modifier Pressed not specified

-- you can define different colors for different themes
palette.FourthColor = { [Enum.UITheme.Light] = Enum.StudioStyleGuideColor.Button }
local fourthColor = palette.FourthColor -- error when Theme == Dark

```
## Methods

### destroy: void

Cleans up all internal resources.

## Events

### ThemeChanged(theme: [Enum.UITheme]): [RBXScriptSignal]

Fired when RobloxStudio changes `theme`. When storing colors using color names you should allways assign them using this event handler.

``` lua
local button = Instance.new("TextButton")
palette.ThemeChanged.Connect(Function()
    button.TextColor3 = palette.Text
    button.BackgroundColor3 = palette.Button
end)
```

[string]: https://create.roblox.com/docs/scripting/luau/strings
[Color3]: https://create.roblox.com/docs/reference/engine/datatypes/Color3
[RBXScriptSignal]: https://create.roblox.com/docs/reference/engine/datatypes/RBXScriptSignal
[Enum.UITheme]: https://create.roblox.com/docs/reference/engine/enums/UITheme
[Enum.StudioStyleGuideColor]: https://create.roblox.com/docs/reference/engine/enums/StudioStyleGuideColor
[Enum.StudioStyleGuideModifier]: https://create.roblox.com/docs/reference/engine/enums/StudioStyleGuideModifier
