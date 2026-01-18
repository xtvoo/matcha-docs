# Datatypes

## Vector3

[Roblox Documentation](https://create.roblox.com/docs/reference/engine/datatypes/Vector3)

### Constructors

#### `new`

```luau
Vector3.new(x: number, y: number, z: number): Vector3
```

Returns a new Vector3 from the given x, y, and z components.

### Properties

- `X: number`
- `Y: number`
- `Z: number`

## Vector2

[Roblox Documentation](https://create.roblox.com/docs/reference/engine/datatypes/Vector2)

### Constructors

#### `new`

```luau
Vector2.new(x: number, y: number): Vector2
```

Returns a Vector2 from the given x and y components.

### Properties

- `X: number`
- `Y: number`

## Color3

[Roblox Documentation](https://create.roblox.com/docs/reference/engine/datatypes/Color3)

### Constructors

#### `new`

```luau
Color3.new(red: number, green: number, blue: number): Color3
```

Returns a Color3 with the given red, green, and blue values.

#### `fromRGB`

```luau
Color3.fromRGB(red: number, green: number, blue: number): Color3
```

Returns a Color3 from given components within the range of 0 to 255.

#### `fromHSV`

```luau
Color3.fromHSV(hue: number, saturation: number, value: number): Color3
```

Returns a Color3 from the given hue, saturation, and value components.

#### `fromHex`

```luau
Color3.fromHex(hex: string): Color3
```

Returns a Color3 from a given hex value.

### Properties

- `R: number`
- `G: number`
- `B: number`
