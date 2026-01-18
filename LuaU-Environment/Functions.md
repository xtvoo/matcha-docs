# Global Functions

This article documents the global functions built into `Matcha`.

## `loadstring` / `load`

```luau
function loadstring(chunk: string, chunkname: string?)
```

Loads `chunk` as a Lua function and returns it if compilation is successful. Otherwise, if an error has occurred during compilation, `nil` followed by the error message will be returned.

## `decompile`

```luau
function decompile(script: Instance): string
```

Decompiles `Script` and returns the decompiled script source as a string. If the decompilation fails, it notifies with an error message.

## `WorldToScreen`

```luau
function WorldToScreen(position: Vector3): (Vector2, boolean)
```

## `notify`

```luau
function notify(message: string, title: string, duration: number)
```

Sends a Matcha notification with a message, title, and duration in seconds.

## `identifyexecutor`

```luau
function identifyexecutor(): string
```

Returns `"Matcha"` and the version.

## `getscripthash`

```luau
function getscripthash(script: Instance): string
```

Returns the FNV-1a 64-bit hash of the script's bytecode.

## `getgetname`

```luau
function getgetname(): string
```

Returns the game name.

## `getscripts`

```luau
function getscripts(): { Instance }
```

Returns all script instances.

## `getscriptbytecode`

```luau
function getscriptbytecode(script: Instance): string
```

Returns the raw bytecode of a script.

## `base64encode`

```luau
function base64encode(data: string): string
```

Encodes a string to Base64 format.

## `base64decode`

```luau
function base64decode(data: string): string
```

Decodes a Base64 string back to a normal string.
