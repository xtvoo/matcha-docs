# File System Functions

The following functions allow interaction with the file system. Files are typically saved in the `workspace` folder of the executor.

## `readfile`

```luau
function readfile(path: string): string
```

Reads the contents of the file at `path`.

## `writefile`

```luau
function writefile(path: string, content: string)
```

Writes `content` to the file at `path`. Overwrites existing content.

## `appendfile`

```luau
function appendfile(path: string, content: string)
```

Appends `content` to the end of the file at `path`.

## `listfiles`

```luau
function listfiles(folder: string): {string}
```

Returns a list of file paths in the specified `folder`.

## `isfile`

```luau
function isfile(path: string): boolean
```

Returns `true` if `path` points to a file, `false` otherwise.

## `isfolder`

```luau
function isfolder(path: string): boolean
```

Returns `true` if `path` points to a folder, `false` otherwise.

## `makefolder`

```luau
function makefolder(path: string)
```

Creates a new folder at `path`.

## `delfolder`

```luau
function delfolder(path: string)
```

Deletes the folder at `path`.

## `delfile`

```luau
function delfile(path: string)
```

Deletes the file at `path`.
