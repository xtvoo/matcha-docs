# Drawing

### API

#### `new`

```luau
Drawing.new(drawingType: string): DrawingObject
```

`drawingType` must be one of the following types:
- `Square`
- `Line`
- `Circle`
- `Text`
- `Triangle`
- `Quad`
- `Image`


### Example Code

The following snippet will display a red square on the user's screen for 5 seconds.

```luau
local square = Drawing.new("Square") 
square.Filled = true 
square.Color = Color3.fromRGB(255, 0, 0) 
square.Position = Vector2.new(20, 20) 
square.Size = Vector2.new(200, 200) 
square.Visible = true 
square.Transparency = 1 -- Assumed property from context of other drawing libs
wait(5) 
square:Remove()
```

# DrawingObject

## Methods

### `Remove`

```luau
function DrawingObject:Remove(): nil
```

## Base Properties

Shared set of properties across all `DrawingObject` types.

#### `Color`

```luau
DrawingObject.Color: Color3
```

#### `Transparency`

```luau
DrawingObject.Transparency: number
```

#### `Visible`

```luau
DrawingObject.Visible: boolean
```

#### `Position`

```luau
DrawingObject.Position: Vector2
```

#### `ZIndex`

```luau
DrawingObject.ZIndex: number
```

## Square Properties

#### `Size`

```luau
DrawingObject.Size: Vector2
```

#### `Filled`

```luau
DrawingObject.Filled: boolean
```

#### `Thickness`

```luau
DrawingObject.Thickness: number
```

## Line Properties

#### `From`

```luau
DrawingObject.From: Vector2
```

#### `To`

```luau
DrawingObject.To: Vector2
```

#### `Thickness`

```luau
DrawingObject.Thickness: number
```

## Circle Properties

#### `Radius`

```luau
DrawingObject.Radius: number
```

#### `NumSides`

```luau
DrawingObject.NumSides: number
```

#### `Thickness`

```luau
DrawingObject.Thickness: number
```

#### `Filled`

```luau
DrawingObject.Filled: boolean
```

## Text Properties

#### `Text`

```luau
DrawingObject.Text: string
```

#### `Outline`

```luau
DrawingObject.Outline: boolean
```

#### `Center`

```luau
DrawingObject.Center: boolean
```

#### `Font`

```luau
DrawingObject.Font: Font -- (number/enum)
```

Available Fonts:
- `UI`: 0
- `System`: 1
- `SystemBold`: 2
- `Monospace`: 3
- `Minecraft`: 4
- `Pixel`: 7
- `Fortnite`: 8


#### `Size` (FontSize)

```luau
DrawingObject.Size: number
```

## Triangle Properties

#### `PointA`

```luau
DrawingObject.PointA: Vector2
```

#### `PointB`

```luau
DrawingObject.PointB: Vector2
```

#### `PointC`

```luau
DrawingObject.PointC: Vector2
```

#### `Filled`

```luau
DrawingObject.Filled: boolean
```

#### `Thickness`

```luau
DrawingObject.Thickness: number
```
