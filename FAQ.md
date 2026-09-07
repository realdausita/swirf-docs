# FAQ

## Is the output a loadstring?

No. Output is a full Swirf VM file - bytecode plus interpreter, runs directly.
There is no `loadstring` wrapper and no `loadstring` call in the output.

## Why is my file so big?

VM output carries the interpreter, encrypted const plane, junk code and
integrity data. Depth 5 + all protections on a small script lands around
80-170KB. That is normal. Lower the depth or turn off Junk Code for size.

## Which executors / runtimes?

Standard Lua 5.x output runs on 5.1-5.4 and Luau. Turn on IsLuau only if your
target is Luau (enables `0b`, `+=`, backticks, type casts). Roblox EnvCheck is
executor-only and breaks vanilla Lua - leave it off unless you know why you
need it.

## Why did my build fail with "Macros need Intense VM"?

You used `SW_*` macros with Intense VM off. Macros only lower on the VM path.
Turn Intense VM back on.

## My macros are still visible / it errors on SW_NO_UPVALUES?

`SW_NO_UPVALUES` is not supported in V1, use `SW_NO_VIRTUALIZE`. Unknown
`SW_*` names abort the build on purpose - check spelling in `SW_MACROS.md`.

## Why DM only? Why did the server command fail?

The bot answers `/obfuscate` in DMs only. Server use is rejected by design
(your source stays between you and the bot).

## Prefix reset itself?

Custom prefixes (`/setprefix`) live in memory. A bot restart resets yours to
`!`. Slash commands are unaffected.

## File too big?

Cap is 256KB of source. Split the file or strip assets/comments first.

## The bot is offline?

It runs on the owner's machine. If it is down, ask in the Discord server.
Check your own connection first - Discord is filtered in some regions and the
bot cannot be reached through those filters either (a VPN fixes it).
