local GTInstance = require(script.Parent.Parent.Parent.MainModule.Classes.GTInstance)

return function()
    describe("Create", function ()
        it("should not create a new instance", function()
            expect(function()
                return GTInstance.new("GTInstance")
            end).to.throw(--[[""]])
        end)
    end)
end