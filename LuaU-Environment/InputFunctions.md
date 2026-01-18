# Input Functions

## `setrobloxinput`

```luau
function setrobloxinput(state: boolean): nil
```

This function toggles sending inputs to the game.

## `isrbxactive`

```luau
function isrbxactive(): boolean
```

This function will return if your current window is Roblox.

## `setclipboard`

```luau
function setclipboard(value: string): nil
```

Sets the clipboard data.

## `keyrelease`

```luau
function keyrelease(keycode: number): nil
```

Releases a key.

## `keypress`

```luau
function keypress(keycode: number): nil
```

Presses a key.

## `iskeypressed`

```luau
function iskeypressed(keycode: number): boolean
```

Returns true if the key is currently pressed.

## `ismouse1pressed`

```luau
function ismouse1pressed(): boolean
```

Returns true if mouse button 1 is pressed.

## `ismouse2pressed`

```luau
function ismouse2pressed(): boolean
```

Returns true if mouse button 2 is pressed.

## `mouse1press`

```luau
function mouse1press(): nil
```

Presses mouse button 1.

## `mouse1release`

```luau
function mouse1release(): nil
```

Releases mouse button 1.

## `mouse1click`

```luau
function mouse1click(): nil
```

Clicks mouse button 1 (press and release).

## `mouse2press`

```luau
function mouse2press(): nil
```

Presses mouse button 2.

## `mouse2release`

```luau
function mouse2release(): nil
```

Releases mouse button 2.

## `mouse2click`

```luau
function mouse2click(): nil
```

Clicks mouse button 2 (press and release).

## `mousemoveabs`

```luau
function mousemoveabs(x: number, y: number): nil
```

Moves the mouse to the absolute coordinates (x, y).

## `mousemoverel`

```luau
function mousemoverel(x: number, y: number): nil
```

Moves the mouse relative to its current position by (x, y).

## `mousescroll`

```luau
function mousescroll(amount: number): nil
```

Scrolls the mouse wheel.
