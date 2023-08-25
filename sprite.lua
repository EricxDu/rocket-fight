--[[
Copyright 2023 Eric Duhamel

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
--]]

--[[
"sprite.lua" is a data structure meant for use with the
"love.graphics.draw" function. Arguments for "draw" are stored
sequentially.
--]]

local sprite = {
  [3] = 0, --x
  [4] = 0, --y
--   [5] = 0, --r
--   [6] = 1, --sx
--   [7] = 1, --sy
--   [8] = 0, --ox
--   [9] = 0, --oy
--   [10] = 0, --kx
--   [11] = 0, --ky
  texture_width = 256,
  texture_height = 256,
  tile_width = 8,
  tile_height = 8
}

function sprite:moveto(x, y)
  self[3] = x
  self[4] = y
end

function sprite:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  for x=1, 9, 1 do --ensure the new object has default arguments
    if self[x] then
      o[x] = self[x]
    end
  end
  return o
end

function sprite:get_tile(n)
  local x = self.texture_width / self.tile_width
  return
    math.floor(n % x) * self.tile_width,
    math.floor(n / x) * self.tile_height,
    self.tile_width,
    self.tile_height
end

return sprite
