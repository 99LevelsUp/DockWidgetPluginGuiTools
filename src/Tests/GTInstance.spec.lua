local GTInstance = require(script.Parent.Parent.MainModule:WaitForChild("GTInstance", 1))

return function()

    local object: Instance = Instance.new("Part")

    describe("Properties", function()
        local gtObject: GTInstance = nil
        beforeAll(function ()
            gtObject = GTInstance.new(object)
        end)
        afterAll(function ()
            gtObject:destroy()
        end)

        it("should write the Name property", function()
            gtObject.Name = "A"
            expect(object.Name).to.equal("A")
            gtObject.Name = "B"
            expect(object.Name).to.equal("B")
        end)
        it("should read the Name property", function()
            object.Name = "A"
            expect(gtObject.Name).to.equal("A")
            object.Name = "B"
            expect(gtObject.Name).to.equal("B")
        end)

        it("should call the GetChildren method", function()
            local subObject: Instance = Instance.new("Part", object)
            local children = gtObject:GetChildren()
            print(children)
        end)

    end)

end