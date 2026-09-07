# Swirf source macros

Compile-time directives. Write them in your source, the obfuscator lowers
them during compilation. After obfuscation no `SW_*` names remain anywhere
in the output - not in code, not in the constant pool.

Macros require the VM path (Intense VM on). With Intense VM off the build
aborts with an error instead of emitting broken code.

## Setup

Paste `SW_SDK.lua` at the top of your source while developing. The stubs make
the code runnable without obfuscation. The entire `if not SW_OBFUSCATED` block
is stripped on obfuscation, then macro calls are lowered.

## Encryption

| Macro | Effect |
|---|---|
| `SW_ENCSTR(s)` / `SW_STRENC(s)` | String forced onto the encrypted const path |
| `SW_ENCNUM(n)` / `SW_NUMENC(n)` | Number forced onto the encrypted const path |
| `SW_ENCBUF(s)` / `SW_BUFENC(s)` | Bytes encrypted, materialized via `buffer.fromstring` at the use site (Luau only) |
| `SW_ENCFUNC(f)` / `SW_FUNCENC(f)` | Every const loaded by `f` forced onto the encrypted path |

Note: the VM const plane is always encrypted. These macros are guarantees -
they pin specific values to the recipe path and document intent.

## Control

| Macro | Effect |
|---|---|
| `SW_OBFUSCATED` | `true` in obfuscated builds. `if not SW_OBFUSCATED then ... end` blocks (SDK) are stripped before compile |
| `SW_CRASH()` | Crash cell, statement position only. Never returns |
| `SW_NO_VIRTUALIZE(function ... end)` | The function keeps plain VM ops (no fusion, no heavy wiring). Argument must be a function literal |
| `SW_REWRITE(e)` / `SW_HOOK_FIX(e)` | Identity. The wrapper call is erased, `e` stays |
| `SW_PRECHECK(fn)` | Erases the wrapper and calls `fn()` at that point |
| `SW_STACKALLOC(size, base)` | Fresh table allocation at that point |
| `SW_WATERMARK` | Banner string: `protected by Swirf Obfuscator V1` |
| `SW_SCRIPT_ID` | Build-local integer, fresh every build |

## Not supported in V1

- `SW_NO_UPVALUES` - aborts with a clear error, use `SW_NO_VIRTUALIZE`
- Unknown `SW_*` names - abort with a clear error
- `SW_*` as anything but a direct call (or bare identifier for `SW_OBFUSCATED`, `SW_WATERMARK`, `SW_SCRIPT_ID`)
- Do not name your own variables/functions `SW_*` - the names are reserved

## Example

```lua
if not SW_OBFUSCATED then
  -- dev-only helpers go here, stripped on obfuscation
end

local apiKey = SW_ENCSTR("live-key-here")
local fast = SW_NO_VIRTUALIZE(function(x) return x + 1 end)

if SW_OBFUSCATED then
  -- only runs in the obfuscated build
end
```
