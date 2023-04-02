local GTInstance = {}
local private = {}

GTInstance.__index = function(table: GTInstance, key: any): any
        
    local value = nil

    local property = private[table].properties and private[table].properties[key]
    if property then
        local object = property.Object
        key = property.Property or key
        value = object[key]

    else
        local tmp = table
        while true do
            value = rawget(tmp, key)
            if value then
                break
            end

            tmp = getmetatable(tmp)
            if not tmp then
                break
            end
        end
    end

    return value
end

GTInstance.__newindex = function(table: GTInstance, key: string, value: any)

    local property = private[table].properties[key]
    if property then
        local object = property.Object
        key = property.Property or key
        object[key] = value

    else
        rawset(table, key, value)

    end
end

type GTMap = { [string]: { Object: Instance, Property: string? } }

function GTInstance._mapProperties(table: GTInstance, value: GTMap)
    local properties = private[table]["properties"] or {}
    for k, v in pairs(value) do
        local object = v.Object
        assert(object ~= nil, "Object must be specified")
        table[k] = nil
        properties[k] = v

    end
    private[table]["properties"] = properties
end

type GTInstance = {
    destroy: (GTInstance) -> (...any),
    Name: string
}

function GTInstance.new(obj: Instance): GTInstance
    local self: GTInstance = {
        destroy = function(this)
            private[this] = nil
        end
    }
    private[self] = {}

    GTInstance._mapProperties(self, {
        Name                   = { Object = obj },

        GetChildren            = { Object = obj },
    })
    
    setmetatable(self, GTInstance)
    return self
end

return GTInstance
