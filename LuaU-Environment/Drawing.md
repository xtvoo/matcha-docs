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
