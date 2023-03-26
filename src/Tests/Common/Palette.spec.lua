local Palette = require(script.Parent.Parent.Parent.MainModule.Common:WaitForChild("Palette"))

return function()

    describe("Static colors", function ()
        -- constants
        local staticColors = {
            Color3.new(0.1, 0.1, 0.1),
            Color3.new(0.2, 0.2, 0.2),
            Color3.new(0.3, 0.3, 0.3),
            Color3.new(0.4, 0.4, 0.4),
            Color3.new(0.5, 0.5, 0.5),
        }

        local palette = nil
        beforeEach(function ()
            palette = Palette.new()

            palette.Color1 = staticColors[1]
            palette.Color2 = staticColors[2]
            palette.Color3 = staticColors[3]
        end)
        afterEach(function ()
            palette:destroy()
        end)

        it("should hold the color 1", function()
            expect(palette.Color1).to.equal(staticColors[1])
        end)
        it("should hold the color 2", function()
            expect(palette.Color2).to.equal(staticColors[2])
        end)
        it("should hold the color 3", function()
            expect(palette.Color3).to.equal(staticColors[3])
        end)

        it("should return the right color", function()  
            expect(palette.Color1).never.to.equal(staticColors[2])
            expect(palette.Color1).never.to.equal(staticColors[3])
            expect(palette.Color2).never.to.equal(staticColors[1])
            expect(palette.Color2).never.to.equal(staticColors[3])
            expect(palette.Color3).never.to.equal(staticColors[1])
            expect(palette.Color3).never.to.equal(staticColors[2])
        end)

        it("should ignore color modifiers", function()
            expect(palette.Color1Default).to.equal(palette.Color1)
            expect(palette.Color1Selected).to.equal(palette.Color1)
            expect(palette.Color2Pressed).to.equal(palette.Color2)
            expect(palette.Color2Disabled).to.equal(palette.Color2)
            expect(palette.Color3Hover).to.equal(palette.Color3)
        end)

        it("should recognize nonexistent color modifiers", function()
            expect(function()
                return palette.Color1Nonexistent
            end).to.throw(--[["Color name [Color3Nonexistent] not found!"]])
        end)
    end)

    describe("Named colors", function()
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

    end)

end