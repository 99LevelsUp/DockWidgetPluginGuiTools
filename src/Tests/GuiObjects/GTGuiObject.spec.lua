local GTGuiObject = require(script.Parent.Parent.Parent.MainModule.GuiObjects:WaitForChild("GTGuiObject", 1))

return function()

    local object: GuiObject = Instance.new("TextButton")

    describe("Properties", function()
        local guiObject: GTGuiObject = nil
        beforeAll(function ()
            guiObject = GTGuiObject.new(object)
        end)
        afterAll(function ()
            guiObject:destroy()
        end)

        it("shloud write the Active property", function()
            guiObject.Active = false
            expect(object.Active).to.equal(false)
            guiObject.Active = true
            expect(object.Active).to.equal(true)
        end)

        it("shloud read the Active property", function()
            object.Active = false
            expect(guiObject.Active).to.equal(false)
            object.Active = true
            expect(guiObject.Active).to.equal(true)
        end)

        it("shloud write the AnchorPoint property", function()
            guiObject.AnchorPoint = Vector2.new(0, 0)
            expect(object.AnchorPoint).to.equal(Vector2.new(0, 0))
            guiObject.AnchorPoint = Vector2.new(1, 1)
            expect(object.AnchorPoint).to.equal(Vector2.new(1, 1))
        end)

        it("shloud read the AnchorPoint property", function()
            object.AnchorPoint = Vector2.new(0, 0)
            expect(guiObject.AnchorPoint).to.equal(Vector2.new(0, 0))
            object.AnchorPoint = Vector2.new(1, 1)
            expect(guiObject.AnchorPoint).to.equal(Vector2.new(1, 1))
        end)

        it("shloud write the LayoutOrder property", function()
            guiObject.LayoutOrder = 0
            expect(object.LayoutOrder).to.equal(0)
            guiObject.LayoutOrder = 1
            expect(object.LayoutOrder).to.equal(1)
        end)

        it("shloud read the LayoutOrder property", function()
            object.LayoutOrder = 0
            expect(guiObject.LayoutOrder).to.equal(0)
            object.LayoutOrder = 1
            expect(guiObject.LayoutOrder).to.equal(1)
        end)

        it("shloud write the Name property", function()
            guiObject.Name = "A"
            expect(object.Name).to.equal("A")
            guiObject.Name = "B"
            expect(object.Name).to.equal("B")
        end)

        it("shloud read the Name property", function()
            object.Name = "A"
            expect(guiObject.Name).to.equal("A")
            object.Name = "B"
            expect(guiObject.Name).to.equal("B")
        end)

        it("shloud write the Position property", function()
            guiObject.Position = UDim2.new(0, 0, 0, 0)
            expect(object.Position).to.equal(UDim2.new(0, 0, 0, 0))
            guiObject.Position = UDim2.new(1, 1, 1, 1)
            expect(object.Position).to.equal(UDim2.new(1, 1, 1, 1))
        end)

        it("shloud read the Position property", function()
            object.Position = UDim2.new(0, 0, 0, 0)
            expect(guiObject.Position).to.equal(UDim2.new(0, 0, 0, 0))
            object.Position = UDim2.new(1, 1, 1, 1)
            expect(guiObject.Position).to.equal(UDim2.new(1, 1, 1, 1))
        end)

        it("shloud write the Rotation property", function()
            guiObject.Rotation = 0
            expect(object.Rotation).to.equal(0)
            guiObject.Rotation = 1
            expect(object.Rotation).to.equal(1)
        end)

        it("shloud read the Rotation property", function()
            object.Rotation = 0
            expect(guiObject.Rotation).to.equal(0)
            object.Rotation = 1
            expect(guiObject.Rotation).to.equal(1)
        end)

        it("shloud write the Size property", function()
            guiObject.Size = UDim2.new(0, 0, 0, 0)
            expect(object.Size).to.equal(UDim2.new(0, 0, 0, 0))
            guiObject.Size = UDim2.new(1, 1, 1, 1)
            expect(object.Size).to.equal(UDim2.new(1, 1, 1, 1))
        end)

        it("shloud read the Size property", function()
            object.Size = UDim2.new(0, 0, 0, 0)
            expect(guiObject.Size).to.equal(UDim2.new(0, 0, 0, 0))
            object.Size = UDim2.new(1, 1, 1, 1)
            expect(guiObject.Size).to.equal(UDim2.new(1, 1, 1, 1))
        end)

        it("shloud write the Visible property", function()
            guiObject.Visible = false
            expect(object.Visible).to.equal(false)
            guiObject.Visible = true
            expect(object.Visible).to.equal(true)
        end)

        it("shloud read the Visible property", function()
            object.Visible = false
            expect(guiObject.Visible).to.equal(false)
            object.Visible = true
            expect(guiObject.Visible).to.equal(true)
        end)

        it("shloud write the ZIndex property", function()
            guiObject.ZIndex = 0
            expect(object.ZIndex).to.equal(0)
            guiObject.ZIndex = 1
            expect(object.ZIndex).to.equal(1)
        end)

        it("shloud read the ZIndex property", function()
            object.ZIndex = 0
            expect(guiObject.ZIndex).to.equal(0)
            object.ZIndex = 1
            expect(guiObject.ZIndex).to.equal(1)
        end)

    end)

end