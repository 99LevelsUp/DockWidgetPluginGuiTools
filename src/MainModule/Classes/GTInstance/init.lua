

local classes = {}
local properties = {}

--- This function registers a subclass. These classes form the basic class tree structure.
--- @param className string: Name of the class.
--- @param baseName string: Parent class name. All classes must inherit from GTInstance.
--- @param creatable boolean: Whether the class can be created or not.
local function subclass(className: string, baseName: string?, creatable: boolean, constructor)
    -- TODO asserty
    -- baseClass == nil and subclasses:Where(baseClass == nil):Count() <= 1
    -- or subclasses[baseClass] ~= nil

    local base = classes[baseName]

    local class = {
        ClassName = className,
        Base = base,
        Creatable = creatable,
        Constructor =
            if base ~= nil
                then
                    function(self: {}, ...: any): any
                        return constructor(self, base.Constructor, ...)
                    end
                else
                    constructor,
        
    }

    classes[className] = class
end

local function constructor(self: {[any]: any}, instance: Instance)

    self.MapProperties = {
        Name                   = { MapTo = instance },
    }

    return self
end

subclass("GTInstance", nil, false, constructor)

type GTInstance = {
    Active: boolean,
}

local GTInstance = {}

function GTInstance.__newindex(table, key, value)

    if key == "MapProperties" then
        -- fill up property mappings
        local props = properties[table] or {}
        for k, v in pairs(value) do
            props[k] = v
        end
        properties[table] = props
        
    else
        -- set the mapped property
        local property = properties[table][key]
        if property then
            local object = property.MapTo
            key = property.Property or key
            object[key] = value

        else
            rawset(table, key, value)

        end
    end
end

function GTInstance.new(className: string, parent: Instance)
    local class = classes[className]
    assert(class ~= nil and class.Creatable, string.format('Unable to create an GTInstance of type "%s"', className))

    local object = {}
    setmetatable(object, GTInstance)
    class.Constructor(object, parent)
    return object
end

return GTInstance