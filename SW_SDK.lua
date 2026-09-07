-- Swirf SDK (dev-time stubs). Paste at the top of your source while developing,
-- or require it in your toolchain. The whole block vanishes when obfuscated
-- (strip via `if not SW_OBFUSCATED`), macro calls lower at compile time,
-- and no SW_* names survive in the output. Macros require the VM path
-- (Intense VM on). SW_ENCBUF needs the Luau `buffer` library.
if not SW_OBFUSCATED then
  local function _id(x) return x end
  SW_ENCSTR = _id
  SW_STRENC = _id
  SW_ENCNUM = _id
  SW_NUMENC = _id
  SW_ENCBUF = function(s) return buffer.fromstring(s) end
  SW_BUFENC = function(s) return buffer.fromstring(s) end
  SW_ENCFUNC = _id
  SW_FUNCENC = _id
  SW_REWRITE = _id
  SW_HOOK_FIX = _id
  SW_PRECHECK = function(f) return f() end
  SW_STACKALLOC = function() return {} end
  SW_NO_VIRTUALIZE = _id
  SW_JIT = _id
  SW_JIT_MAX = _id
  SW_WATERMARK = "dev"
  SW_SCRIPT_ID = 0
  SW_LINE = 0
end
