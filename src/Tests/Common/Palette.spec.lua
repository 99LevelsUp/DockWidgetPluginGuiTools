local Palette = require(script.Parent.Parent.Parent.MainModule.Common:WaitForChild("Palette"))

return function()

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

    local inverseTheme = {
        [Enum.UITheme.Light] = Enum.UITheme.Dark,
        [Enum.UITheme.Dark] = Enum.UITheme.Light
    }

    describe("ActualTheme", function()
        it("should be same as studio theme", function()
            expect(Palette.ActualTheme.Name).to.equal(settings().Studio.Theme.Name)
        end)
    end)

    describe("Color3", function ()
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

    describe("{ Color3 }", function()
        local palette = nil
        beforeEach(function ()
            palette = Palette.new()

            palette.Color1 = { staticColors[1] }
            palette.Color2 = { staticColors[2] }
            palette.Color3 = { staticColors[3], staticColors[4] }
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
    end)

    describe("Enum.StudioStyleGuideColor", function()
        local theme = settings().Studio.Theme
        local palette = nil
        beforeEach(function ()
            palette = Palette.new()

            palette.Color1 = namedColors[1]
            palette.Color2 = namedColors[2]
            palette.Color3 = namedColors[3]
        end)
        afterEach(function ()
            palette:destroy()
        end)

        it("should hold the color 1", function()
            expect(palette.Color1).to.equal(theme:GetColor(namedColors[1]))
        end)
        it("should hold the color 2", function()
            expect(palette.Color2).to.equal(theme:GetColor(namedColors[2]))
        end)
        it("should hold the color 3", function()
            expect(palette.Color3).to.equal(theme:GetColor(namedColors[3]))
        end)

        it("should return the right color", function()  
            expect(palette.Color1).never.to.equal(theme:GetColor(namedColors[2]))
            expect(palette.Color1).never.to.equal(theme:GetColor(namedColors[3]))
            expect(palette.Color2).never.to.equal(theme:GetColor(namedColors[1]))
            expect(palette.Color2).never.to.equal(theme:GetColor(namedColors[3]))
            expect(palette.Color3).never.to.equal(theme:GetColor(namedColors[1]))
            expect(palette.Color3).never.to.equal(theme:GetColor(namedColors[2]))
        end)

        it("should apply color modifiers", function()
            expect(palette.Color1Default).to.equal(theme:GetColor(namedColors[1], Enum.StudioStyleGuideModifier.Default))
            expect(palette.Color1Selected).to.equal(theme:GetColor(namedColors[1], Enum.StudioStyleGuideModifier.Selected))
            expect(palette.Color1Pressed).to.equal(theme:GetColor(namedColors[1], Enum.StudioStyleGuideModifier.Pressed))
            expect(palette.Color1Disabled).to.equal(theme:GetColor(namedColors[1], Enum.StudioStyleGuideModifier.Disabled))
            expect(palette.Color1Hover).to.equal(theme:GetColor(namedColors[1], Enum.StudioStyleGuideModifier.Hover))
        end)
    end)
    describe("{ Enum.StudioStyleGuideColor }", function()
        local theme = settings().Studio.Theme
        local palette = nil
        beforeEach(function ()
            palette = Palette.new()

            palette.Color1 = { namedColors[1] }
            palette.Color2 = { namedColors[2] }
            palette.Color3 = { namedColors[3] }
        end)
        afterEach(function ()
            palette:destroy()
        end)

        it("should hold the color 1", function()
            expect(palette.Color1).to.equal(theme:GetColor(namedColors[1]))
        end)
        it("should hold the color 2", function()
            expect(palette.Color2).to.equal(theme:GetColor(namedColors[2]))
        end)
        it("should hold the color 3", function()
            expect(palette.Color3).to.equal(theme:GetColor(namedColors[3]))
        end)

        it("should return the right color", function()  
            expect(palette.Color1).never.to.equal(theme:GetColor(namedColors[2]))
            expect(palette.Color1).never.to.equal(theme:GetColor(namedColors[3]))
            expect(palette.Color2).never.to.equal(theme:GetColor(namedColors[1]))
            expect(palette.Color2).never.to.equal(theme:GetColor(namedColors[3]))
            expect(palette.Color3).never.to.equal(theme:GetColor(namedColors[1]))
            expect(palette.Color3).never.to.equal(theme:GetColor(namedColors[2]))
        end)

        it("should apply color modifiers", function()
            expect(palette.Color1Default).to.equal(theme:GetColor(namedColors[1], Enum.StudioStyleGuideModifier.Default))
            expect(palette.Color1Selected).to.equal(theme:GetColor(namedColors[1], Enum.StudioStyleGuideModifier.Selected))
            expect(palette.Color1Pressed).to.equal(theme:GetColor(namedColors[1], Enum.StudioStyleGuideModifier.Pressed))
            expect(palette.Color1Disabled).to.equal(theme:GetColor(namedColors[1], Enum.StudioStyleGuideModifier.Disabled))
            expect(palette.Color1Hover).to.equal(theme:GetColor(namedColors[1], Enum.StudioStyleGuideModifier.Hover))
        end)
    end)

    describe("{ Enum.StudioStyleGuideColor, Enum.StudioStyleGuideModifier }", function()
        local theme = settings().Studio.Theme
        local palette = nil
        beforeEach(function ()
            palette = Palette.new()

            palette.Color1 = { namedColors[1], modifiers[1] }
            palette.Color2 = { namedColors[2], modifiers[2] }
            palette.Color3 = { namedColors[3], modifiers[3] }
        end)
        afterEach(function ()
            palette:destroy()
        end)

        it("should hold the color 1", function()
            expect(palette.Color1).to.equal(theme:GetColor(namedColors[1], modifiers[1]))
            expect(palette.Color1Default).to.equal(theme:GetColor(namedColors[1], modifiers[1]))
            expect(palette.Color1Selected).to.equal(theme:GetColor(namedColors[1], modifiers[1]))
            expect(palette.Color1Pressed).to.equal(theme:GetColor(namedColors[1], modifiers[1]))
            expect(palette.Color1Disabled).to.equal(theme:GetColor(namedColors[1], modifiers[1]))
            expect(palette.Color1Hover).to.equal(theme:GetColor(namedColors[1], modifiers[1]))
        end)
        it("should hold the color 2", function()
            expect(palette.Color2).to.equal(theme:GetColor(namedColors[2], modifiers[2]))
        end)
        it("should hold the color 3", function()
            expect(palette.Color3).to.equal(theme:GetColor(namedColors[3], modifiers[3]))
        end)

        it("should return the right color with right modifier", function()  
            expect(palette.Color1).never.to.equal(theme:GetColor(namedColors[1], modifiers[2]))
            expect(palette.Color1).never.to.equal(theme:GetColor(namedColors[1], modifiers[3]))
            expect(palette.Color1).never.to.equal(theme:GetColor(namedColors[2], modifiers[1]))
            expect(palette.Color1).never.to.equal(theme:GetColor(namedColors[2], modifiers[2]))
            expect(palette.Color1).never.to.equal(theme:GetColor(namedColors[2], modifiers[3]))
            expect(palette.Color1).never.to.equal(theme:GetColor(namedColors[3], modifiers[1]))
            expect(palette.Color1).never.to.equal(theme:GetColor(namedColors[3], modifiers[2]))
            expect(palette.Color1).never.to.equal(theme:GetColor(namedColors[3], modifiers[3]))
        end)

        it("should ignore color modifiers", function()
            expect(palette.Color1Selected).never.to.equal(theme:GetColor(namedColors[1], Enum.StudioStyleGuideModifier.Selected))
            expect(palette.Color1Pressed).never.to.equal(theme:GetColor(namedColors[1], Enum.StudioStyleGuideModifier.Pressed))
        end)
    end)

    describe("[Enum.UITheme] = Color3", function ()
        local palette = nil
        beforeEach(function ()
            palette = Palette.new()

            palette.Color1 = {
                [Palette.ActualTheme] = staticColors[1]
            }
            palette.Color2 = {
                [inverseTheme[Palette.ActualTheme]] = staticColors[2]
            }
            palette.Color3 = {
                [Palette.ActualTheme] = staticColors[3],
                [inverseTheme[Palette.ActualTheme]] = staticColors[4]
            }
        end)
        afterEach(function ()
            palette:destroy()
        end)

        it("should hold the color with actual theme", function()
            expect(palette.Color1).to.equal(staticColors[1])
            expect(palette.Color1Default).to.equal(staticColors[1])
            expect(palette.Color1Selected).to.equal(staticColors[1])
        end)
        it("should not hold the color with other theme", function()
            expect(function()
                return palette.Color2
            end).to.throw(--[["Color name [...] not found!"]])
        end)
        it("should hold the color with both themes", function()
            expect(palette.Color3).to.equal(staticColors[3])
            expect(palette.Color3Default).to.equal(staticColors[3])
            expect(palette.Color3Selected).to.equal(staticColors[3])
        end)
    end)

    describe("[Enum.UITheme] = Enum.StudioStyleGuideColor", function ()
        local theme = settings().Studio.Theme
        local palette = nil
        beforeEach(function ()
            palette = Palette.new()

            palette.Color1 = {
                [Palette.ActualTheme] = namedColors[1]
            }
            palette.Color2 = {
                [inverseTheme[Palette.ActualTheme]] = namedColors[2]
            }
            palette.Color3 = {
                [Palette.ActualTheme] = namedColors[3],
                [inverseTheme[Palette.ActualTheme]] = namedColors[4]
            }
        end)
        afterEach(function ()
            palette:destroy()
        end)

        it("should hold the color with actual theme", function()
            expect(palette.Color1).to.equal(theme:GetColor(namedColors[1]))
            expect(palette.Color1Default).to.equal(theme:GetColor(namedColors[1], Enum.StudioStyleGuideModifier.Default))
            expect(palette.Color1Selected).to.equal(theme:GetColor(namedColors[1], Enum.StudioStyleGuideModifier.Selected))
        end)
        it("should not hold the color with other theme", function()
            expect(function()
                return palette.Color2
            end).to.throw(--[["Color name [...] not found!"]])
        end)
        it("should hold the color with both themes", function()
            expect(palette.Color3).to.equal(theme:GetColor(namedColors[3]))
            expect(palette.Color3Default).to.equal(theme:GetColor(namedColors[3], Enum.StudioStyleGuideModifier.Default))
            expect(palette.Color3Selected).to.equal(theme:GetColor(namedColors[3], Enum.StudioStyleGuideModifier.Selected))
        end)
    end)

    describe("[Enum.UITheme] = { Enum.StudioStyleGuideColor, Enum.StudioStyleGuideModifier? }", function ()
        local theme = settings().Studio.Theme
        local palette = nil
        beforeEach(function ()
            palette = Palette.new()

            palette.Color1 = {
                [Palette.ActualTheme] = { namedColors[1] }
            }
            palette.Color2 = {
                [Palette.ActualTheme] = { namedColors[2], modifiers[2] }
            }
            palette.Color3 = {
                [Palette.ActualTheme] = { namedColors[3], modifiers[3] },
                [inverseTheme[Palette.ActualTheme]] = { namedColors[4], modifiers[4] }
            }
        end)
        afterEach(function ()
            palette:destroy()
        end)

        it("should apply color modifiers when not specified", function()
            expect(palette.Color1).to.equal(theme:GetColor(namedColors[1]))
            expect(palette.Color1Default).to.equal(theme:GetColor(namedColors[1], Enum.StudioStyleGuideModifier.Default))
            expect(palette.Color1Selected).to.equal(theme:GetColor(namedColors[1], Enum.StudioStyleGuideModifier.Selected))
            expect(palette.Color1Pressed).to.equal(theme:GetColor(namedColors[1], Enum.StudioStyleGuideModifier.Pressed))
            expect(palette.Color1Disabled).to.equal(theme:GetColor(namedColors[1], Enum.StudioStyleGuideModifier.Disabled))
            expect(palette.Color1Hover).to.equal(theme:GetColor(namedColors[1], Enum.StudioStyleGuideModifier.Hover))
        end)
        it("should ignore color modifiers when specified", function()
            expect(palette.Color2).to.equal(theme:GetColor(namedColors[2], modifiers[2]))
            expect(palette.Color2Default).to.equal(theme:GetColor(namedColors[2], modifiers[2]))
            expect(palette.Color2Selected).to.equal(theme:GetColor(namedColors[2], modifiers[2]))
            expect(palette.Color2Pressed).to.equal(theme:GetColor(namedColors[2], modifiers[2]))
            expect(palette.Color2Disabled).to.equal(theme:GetColor(namedColors[2], modifiers[2]))
            expect(palette.Color2Hover).to.equal(theme:GetColor(namedColors[2], modifiers[2]))
        end)
        it("should recognize theme", function()
            expect(palette.Color3).to.equal(theme:GetColor(namedColors[3], modifiers[3]))
            expect(palette.Color3Default).to.equal(theme:GetColor(namedColors[3], modifiers[3]))
            expect(palette.Color3Selected).to.equal(theme:GetColor(namedColors[3], modifiers[3]))
            expect(palette.Color3Pressed).to.equal(theme:GetColor(namedColors[3], modifiers[3]))
            expect(palette.Color3Disabled).to.equal(theme:GetColor(namedColors[3], modifiers[3]))
            expect(palette.Color3Hover).to.equal(theme:GetColor(namedColors[3], modifiers[3]))
        end)
    end)

    describe("{ Color3, [Enum.UITheme] = Enum.StudioStyleGuideColor }", function ()
        local theme = settings().Studio.Theme
        local palette = nil
        beforeEach(function ()
            palette = Palette.new()

            palette.Color1 = {
                staticColors[1],
                [Palette.ActualTheme] = namedColors[1]
            }
            palette.Color2 = {
                staticColors[2],
                [inverseTheme[Palette.ActualTheme]] = namedColors[2]
            }
        end)
        afterEach(function ()
            palette:destroy()
        end)

        it("should evaluate all colors of active palette as if static color is not present", function()
            expect(palette.Color1).to.equal(theme:GetColor(namedColors[1]))
            expect(palette.Color1Default).to.equal(theme:GetColor(namedColors[1], Enum.StudioStyleGuideModifier.Default))
            expect(palette.Color1Selected).to.equal(theme:GetColor(namedColors[1], Enum.StudioStyleGuideModifier.Selected))
            expect(palette.Color1Pressed).to.equal(theme:GetColor(namedColors[1], Enum.StudioStyleGuideModifier.Pressed))
            expect(palette.Color1Disabled).to.equal(theme:GetColor(namedColors[1], Enum.StudioStyleGuideModifier.Disabled))
            expect(palette.Color1Hover).to.equal(theme:GetColor(namedColors[1], Enum.StudioStyleGuideModifier.Hover))
        end)
        it("should evaluate all colors of inactive palette as if the pallette is not present", function()
            expect(palette.Color2).to.equal(staticColors[2])
            expect(palette.Color2Default).to.equal(staticColors[2])
            expect(palette.Color2Selected).to.equal(staticColors[2])
            expect(palette.Color2Pressed).to.equal(staticColors[2])
            expect(palette.Color2Disabled).to.equal(staticColors[2])
            expect(palette.Color2Hover).to.equal(staticColors[2])
        end)
    end)

    describe("{ [Enum.StudioStyleGuideModifier] = Color }", function ()
        local theme = settings().Studio.Theme
        local palette = nil
        beforeEach(function ()
            palette = Palette.new()

            palette.Color1 = {
                [Enum.StudioStyleGuideModifier.Default] = staticColors[1],
                [Enum.StudioStyleGuideModifier.Selected] = { staticColors[2] },
                -- [Enum.StudioStyleGuideModifier.Pressed] = namedColors[3],
                [Enum.StudioStyleGuideModifier.Disabled] = { namedColors[4] },
                [Enum.StudioStyleGuideModifier.Hover] = { namedColors[5], modifiers[5] },
            }
        end)
        afterEach(function ()
            palette:destroy()
        end)

        it("should evaluate all colors of active palette as if static color is not present", function()
            expect(palette.Color1).to.equal(staticColors[1])
            expect(palette.Color1Default).to.equal(staticColors[1])
            expect(palette.Color1Selected).to.equal(staticColors[2])
            -- expect(palette.Color1Pressed).to.equal(theme:GetColor(namedColors[3]))
            expect(function()
                return palette.Color1Pressed
            end).to.throw(--[["Color name [...] not found!"]])
            expect(palette.Color1Disabled).to.equal(theme:GetColor(namedColors[4]))
            expect(palette.Color1Hover).to.equal(theme:GetColor(namedColors[5], modifiers[5]))
        end)
    end)

end