-- requireany.lua -- see README
-- (c) 2011-2012 David Manura.  Licensed under Lua 5.1 terms (MIT license).
 
local M = {_TYPE='module', _NAME='requireany', _VERSION='0.1.1.20120406'}

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
