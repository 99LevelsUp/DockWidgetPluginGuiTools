

local function constructor(base, self, parent)

    local background = Instance.new("ImageLabel", parent)
	do
		background.Name = "Background"
		background.BackgroundTransparency = 1
		background.BorderSizePixel = 0
		
		background.Image = "rbxasset://textures/StudioToolbox/RoundedBackground.png"
		background.ScaleType = Enum.ScaleType.Slice
		background.SliceCenter = Rect.new(3, 3, 12, 12)
	end

	local border = Instance.new("ImageLabel", background)
	do
		border.Name = "Border"
		border.BackgroundTransparency = 1
		border.BorderSizePixel = 0
		border.Size = UDim2.new(1, 0, 1, 0)
		border.Position = UDim2.new(0, 0, 0, 0)

		border.Image = "rbxasset://textures/StudioToolbox/RoundedBorder.png"
		border.ScaleType = Enum.ScaleType.Slice
		border.SliceCenter = Rect.new(3, 3, 12, 12)
	end

    self = base(self, background)

    self.properties = {
        BorderColor3           = { Object = border, Property = "ImageColor3" },
    }

    return self
end

return true, constructor