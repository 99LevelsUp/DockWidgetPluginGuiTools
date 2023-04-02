local GTInstance = require(script.Parent.Parent:WaitForChild("GTInstance"))

local GTGuiObject = {
    __index = GTInstance.__index,
    __newindex = GTInstance.__newindex,
}

type GTGuiObject = GTInstance & {
    Active: boolean,
    AnchorPoint: Vector2,
    LayoutOrder: number,
    Position: UDim2,
    Rotation: number,
    Size: UDim2,
    Visible: boolean,
    ZIndex: number
}

function GTGuiObject.new(obj: GuiObject): GTGuiObject
    local self: GTGuiObject = GTInstance.new(obj)

    GTInstance._mapProperties(self, {
        Active                 = { Object = obj },
        AnchorPoint            = { Object = obj },
        LayoutOrder            = { Object = obj },
        Position               = { Object = obj },
        Rotation               = { Object = obj },
        Size                   = { Object = obj },
        Visible                = { Object = obj },
        ZIndex                 = { Object = obj },
    })
    
    setmetatable(self, GTGuiObject)
    return self
end

return GTGuiObject