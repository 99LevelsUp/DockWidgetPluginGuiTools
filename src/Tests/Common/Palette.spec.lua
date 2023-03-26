--[[
    https://stackoverflow.com/questions/66575540/is-there-a-way-to-test-roblox-games
--]]

local Palette = require(script.Parent.Parent.Parent.MainModule.Common:WaitForChild("Palette"))

return function()

    describe("Palette", function ()
        -- constants
        local staticColors = {
            Color3.new(0.1, 0.1, 0.1),
            Color3.new(0.2, 0.2, 0.2),
            Color3.new(0.3, 0.3, 0.3),
            Color3.new(0.4, 0.4, 0.4),
            Color3.new(0.5, 0.5, 0.5),
        }
        local namedColors = {
            Enum.StudioStyleGuideColor.Button,
            Enum.StudioStyleGuideColor.MainButton,
            Enum.StudioStyleGuideColor.RibbonButton,
            Enum.StudioStyleGuideColor.MainText,
            Enum.StudioStyleGuideColor.SubText
        }
        local modifiers = {
            Enum.StudioStyleGuideModifier.Default,
            Enum.StudioStyleGuideModifier.Selected,
            Enum.StudioStyleGuideModifier.Pressed,
            Enum.StudioStyleGuideModifier.Disabled,
            Enum.StudioStyleGuideModifier.Hover
        }

        local palette = nil
        beforeEach(function ()
            palette = Palette.new()
        end)
        afterEach(function ()
            palette:destroy()
        end)

        it("should hold static color", function()
            palette.Color1 = staticColors[1]
            palette.Color2 = staticColors[2]
            palette.Color3 = staticColors[3]
            
            expect(palette.Color1).to.equal(staticColors[1])
            expect(palette.Color1Default).to.equal(staticColors[1])
            expect(palette.Color1Selected).to.equal(staticColors[1])
            expect(palette.Color1).never.to.equal(staticColors[2])
            expect(palette.Color1Default).never.to.equal(staticColors[2])
            expect(palette.Color1Selected).never.to.equal(staticColors[2])
        end)
    end)

end