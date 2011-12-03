--[[ FILE README.txt

LUA MODULE

  requireany v$(_VERSION) - require any one of the listed modules

SYNOPSIS
  
  local bit, name = require 'requireany' ('bit', 'bit32', 'bit.numberlua')
  print(bit.band(0x4, 0x1)) --> 5
  print(name) --> 'bit32' (for example)

  local bit = require 'requireany' ('bitfoo', nil) --> nil
  local bit = require 'requireany' ('bitfoo', {band=. . .}) --> {band=. . .}
  -- returns last non-string argument if fail to load any listed module.

DESCRIPTION

  Sometimes more than one module may have a necessary interface
  and you want to load just one of them depending on which are installed
  on the user's system.
  
  In the example above, there are three modules that provide some form
  of bitwise-AND operator, and it will preferrentially load them from
  left-to-right: first attempt to load 'bit' (LuaBitOp), and failing that
  attempt to load load 'bit32' (Lua 5.2), and failing that attempt to load
  'bit.numberlua' (a slower pure Lua module), and failing that raise
  an error.  Alternately, if the last value passed to `requireany` is a
  non-string, this value will be returned rather than raising an error.
  The second return value (`name`) is the name of the module loaded
  (or `nil`).
 
API

  require 'requireany' ( [names...] [, fallback] )  --> module, name
  
    See DESCRIPTION above.
    
    `require 'requireany' (...)` is a short-hand for
    `require 'requireany' . requireany (...)`.
 
HOME PAGE

  https://raw.github.com/gist/1414923

DOWNLOAD/INSTALL

  If using LuaRocks:
    luarocks install lua-requireany

  Download <https://raw.github.com/gist/1414923/requireany.lua>.
  Alternately, if using git:
    git clone git://gist.github.com/1414923.git lua-requireany
    cd lua-requireany
  Optionally unpack and install in LuaRocks:
    Download <https://raw.github.com/gist/1422205/sourceunpack.lua>.
    lua sourceunpack.lua requireany.lua
    cd out && luarocks make *.rockspec
 
DEPENDENCIES

  None (other than Lua 5.1 or 5.2).
  
LICENSE

  (c) 2008-2011 David Manura.  Licensed under the same terms as Lua (MIT).

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
  (end license)
 
 --]]---------------------------------------------------------------------

 -- requireany.lua
 -- (c) 2011 David Manura.  Licensed under the same terms as Lua 5.1 (MIT license).
 
 local M = {_TYPE='module', _NAME='requireany', _VERSION='0.1.20111203'}

function M.requireany(...)
  local errs = {}
  for i = 1, select('#', ...) do local name = select(i, ...)
    if type(name) ~= 'string' then return name, nil end
    local ok, mod = pcall(require, name)
    if ok then return mod, name end
    errs[#errs+1] = mod
  end
  error(table.concat(errs, '\n'), 2)
end

setmetatable(M, {__call = function(_, ...) return M.requireany(...) end})

return M


--[[ FILE lua-requireany-$(_VERSION)-1.rockspec

package = 'lua-requireany'
version = '$(_VERSION)-1'
source = {
  url = 'https://raw.github.com/gist/1414923/$(GITID)/requireany.lua',
  --url = 'https://raw.github.com/gist/1414923/requireany.lua', -- latest raw
  --url = 'https://gist.github.com/gists/1414923/download', -- latest archive
  md5 = '$(MD5)'
}
description = {
  summary = 'require any one of the listed modules.',
  detailed =
    'require any one of the listed modules.',
  license = 'MIT/X11',
  homepage = 'https://gist.github.com/1414923',
  maintainer = 'David Manura'
}
dependencies = {}
build = {
  type = 'builtin',
  modules = {
    ['requireany'] = 'requireany.lua'
  }
}

--]]---------------------------------------------------------------------


--[[ FILE test.lua


local function checkeq(a, b, e)
  if a ~= b then error(
    'not equal ['..tostring(a)..'] ['..tostring(b)..'] ['..tostring(e)..']', 2)
  end
end

assert(not pcall(require 'requireany')) -- zero args
checkeq(require 'requireany' ('_G'), _G)
checkeq(require 'requireany' ('nonexist1', 'os'), os)
checkeq(require 'requireany' ('nonexist1', os), os)
checkeq(require 'requireany' ('nonexist1', nil), nil)
assert(not pcall(require 'requireany', 'nonexist1', 'nonexist2'))

print 'OK'

--]]---------------------------------------------------------------------
