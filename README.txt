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

  https://github.com/davidm/lua-require-any

DOWNLOAD/INSTALL

  To install using LuaRocks:
  
    luarocks install requireany

  Otherwise download <https://github.com/davidm/lua-require-any>.

  You may just copy requireany.lua into your LUA_PATH.

  Otherwise:
    
      make test
      make install  (or make install-local)  -- to install in LuaRocks
      make remove  (or make remove-local) -- to remove from LuaRocks
 
DEPENDENCIES

  None (other than Lua 5.1 or 5.2).
  
LICENSE

  (c) 2008-2012 David Manura.  Licensed under the same terms as Lua (MIT).

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
 
 