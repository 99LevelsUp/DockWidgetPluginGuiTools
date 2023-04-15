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

local GTGuiObject = {}

GTGuiObject.creatables = false

function GTGuiObject.constructor(base, self, guiObject)
    self = base(self, guiObject)

    self.MapPoperties = {
        Active                 = { Object = guiObject },
    }
end

return GTGuiObject