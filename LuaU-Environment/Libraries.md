# Libraries

Matcha provides several standard and custom libraries to enhance the LuaU environment.

## `bit32`

Standard Lua 5.2 bitwise operations library.

- `band(a, b)`: Bitwise AND
- `bor(a, b)`: Bitwise OR
- `bxor(a, b)`: Bitwise XOR
- `bnot(a)`: Bitwise NOT
- `lshift(n, disp)`: Left shift
- `rshift(n, disp)`: Logical right shift
- `arshift(n, disp)`: Arithmetic right shift
- `lrotate(n, disp)`: Left rotate
- `rrotate(n, disp)`: Right rotate
- `btest(a, b)`: Boolean bitwise testing
- `extract(n, field, width)`: Extract bit field
- `replace(n, v, field, width)`: Replace bit field
- `countlz(n)`: Count leading zeros
- `countrz(n)`: Count trailing zeros
- `byteswap(n)`: Swap bytes

## `buffer`

A library for high-performance memory manipulation.

### Creation & Conversion
- `create(size)`: Creates a buffer of `size` bytes.
- `fromstring(str)`: Creates a buffer from a string.
- `tostring(buf)`: Converts buffer to string.
- `len(buf)`: Returns buffer length.
- `copy(dest, source, ...)`: Copies data between buffers.
- `fill(buf, ...)`: Fills buffer with value.

### Reading
- `readi8`, `readu8`
- `readi16`, `readu16`
- `readi32`, `readu32`
- `readf32`, `readf64`
- `readstring`
- `readbits`

### Writing
- `writei8`, `writeu8`
- `writei16`, `writeu16`
- `writei32`, `writeu32`
- `writef32`, `writef64`
- `writestring`
- `writebits`

## `vector`

A high-performance SIMD-enabled vector library.

- `create(x, y, z)`: Creates a new vector.
- `zero`: Constant zero vector.
- `one`: Constant one vector.
- `magnitude(v)`: Returns length of vector.
- `normalize(v)`: Returns normalized unit vector.
- `cross(a, b)`: Cross product.
- `dot(a, b)`: Dot product.
- `angle(a, b)`: Angle between vectors.
- `clamp(v, min, max)`: Clamps vector components.
- `min(a, b)`: Component-wise minimum.
- `max(a, b)`: Component-wise maximum.
- `abs(v)`: Component-wise absolute value.
- `floor(v)`: Component-wise floor.
- `ceil(v)`: Component-wise ceiling.
- `sign(v)`: Component-wise sign.

## `utf8`

Standard Lua 5.3 UTF-8 library.

- `char(...)`
- `codes(str)`
- `codepoint(str, ...)`
- `len(str, ...)`
- `offset(str, ...)`
- `charpattern`

## `debug`

Restricted debug library.

- `info(...)`: Get function info.
- `traceback(...)`: Get stack traceback.
