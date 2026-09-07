# Swirf Docs

User documentation for **Swirf Obfuscator V1** - a Lua/Luau VM obfuscator.
DM-only Discord bot, full VM output (not a loadstring).

The engine itself is closed source. This repo holds docs + SDK only.

## Contents

- `README.md` - what Swirf is, quick start, bot commands, build options
- `SW_SDK.lua` - dev-time stubs for source macros (paste at the top of your source while developing)
- `SW_MACROS.md` - macro reference
- `FAQ.md` - frequent questions

## Quick start

1. DM the bot and run `/obfuscate` with a `.lua` file attached (max 256KB).
2. First run asks you to accept the rules (one time).
3. The build panel opens: toggle protections, set VM depth, press Obfuscate.
4. You get back `<name>.obfuscated.lua` - a full Swirf VM file. Run it directly.

Prefix also works: `!obfuscate` with the file attached (`/setprefix` to change `!`).

## Bot commands

- `/obfuscate` + `.lua` attachment - obfuscate a file (DM only)
- `/setprefix <p>` - set your personal prefix, e.g. `/setprefix .` then `.obfuscate` works
- `/help` - command list

## Build options (panel)

| Option | What it does |
|---|---|
| Intense VM | Full VM compilation. Off = legacy loader path (macros stop working) |
| VM Depth (1-5) | Nested VM depth. 5 = strongest/slowest, 1 = fastest |
| Compression | Minified output |
| Static Globals | Preloads runtime globals into locals. Only if your env supports them |
| Strings / Numbers | Source-level literal encryption (VM const plane is always encrypted) |
| Junk Code | Dead-code injection with opaque guards |
| Control Flow | Control-flow flattening on the loader path |
| IsLuau Runtime | Luau dialect output (`0b`, `+=`, backticks, casts). Off = portable 5.x |
| Roblox EnvCheck | Executor environment traps. Executor only, breaks vanilla Lua |
| Anti Tamper | VM image + constant plane validation, silent death on modification |

## Source macros

Directives you write in your own code, lowered at compile time. Nothing with
`SW_` survives in the output. Full reference: `SW_MACROS.md`. Dev stubs:
`SW_SDK.lua` (the whole block is stripped on obfuscation).

Example:

```lua
local key = SW_ENCSTR("my-secret-key")
local id = SW_SCRIPT_ID
local safe = SW_NO_VIRTUALIZE(function(x) return x * 2 end)
```

## Support

Use the Discord server. Read the rules channels before your first build.

## License

MIT. The engine is not included and is not licensed.
