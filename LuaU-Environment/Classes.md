# Classes

## UserInputService

```luau
local UserInputService = game:GetService("UserInputService")
```

### `InputBegan`

```luau
UserInputService.InputBegan:Connect(function(input: InputObject, gameProcessed: boolean)
    -- code
end)
```

### `InputEnded`

```luau
UserInputService.InputEnded:Connect(function(input: InputObject, gameProcessed: boolean)
    -- code
end)
```

## MeshPart

[Roblox Documentation](https://create.roblox.com/docs/reference/engine/classes/MeshPart)

### Properties

#### `TextureId`

```luau
MeshPart.TextureId: string
```

#### `MeshId`

```luau
MeshPart.MeshId: string
```

## Instance

[Roblox Documentation](https://create.roblox.com/docs/reference/engine/classes/Instance)

### Properties

#### `Address`

```luau
Instance.Address: number
```

Hexadecimal number representing the Instance’s memory address.

#### `Name`

```luau
Instance.Name: string
```

#### `ClassName`

```luau
Instance.ClassName: string
```

#### `Parent`

```luau
Instance.Parent: Instance
```
