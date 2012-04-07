-- test.lua - test suite for requireany module.

-- 'findbin' -- https://github.com/davidm/lua-find-bin
package.preload.findbin = function()
  local M = {_TYPE='module', _NAME='findbin', _VERSION='0.1.1.20120406'}
  local script = arg and arg[0] or ''
  local bin = script:gsub('[/\\]?[^/\\]+$', '') -- remove file name
  if bin == '' then bin = '.' end
  M.bin = bin
  setmetatable(M, {__call = function(_, relpath) return bin .. relpath end})
  return M
end
package.path = require 'findbin' '/lua/?.lua;' .. package.path

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

