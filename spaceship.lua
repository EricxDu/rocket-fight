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
"spaceship.lua" is a physics library for managing a rocketship akin to
the original *Spacewar!* and derivatives like *Galaxy Game*, *Computer
Space*, and *Asteroids*.
--]]

local spaceship = {
  x = 0,
  y = 0,
  dx = 0,
  dy = 0,
  angle = 0,
  cooldown = 0,
  radius = 15,
  timer0 = 0
}

function spaceship:control(arg)
  local dt = arg.dt or 1
  local ship_speed = 35
  local turn_speed = 3.5
  if arg.left then
    self.angle = (self.angle - turn_speed * dt) % (2 * math.pi)
  elseif arg.right then
    self.angle = (self.angle + turn_speed * dt) % (2 * math.pi)
  end
  if arg.up then
    self.dx = self.dx + math.cos(self.angle) * ship_speed * dt
    self.dy = self.dy + math.sin(self.angle) * ship_speed * dt
  end
end

function spaceship:distance(obj)
  local dx, dy = self.x - obj.x, self.y - obj.y
  return math.sqrt(dx * dx + dy * dy)
end

function spaceship:fire0()
  if self.timer0 == 0 then
    self.timer0 = 0.75
    local o = {
      x = self.x + math.cos(self.angle) * self.radius,
      y = self.y + math.sin(self.angle) * self.radius,
      dx = self.dx + math.cos(self.angle) * 100,
      dy = self.dy + math.sin(self.angle) * 100,
      angle = self.angle,
      radius = 4,
      timer0 = 1.60
    }
    setmetatable(o, spaceship)
    o.__index = spaceship
    return o
  end
end

function spaceship:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

--[[
    spaceship:nose
    Return coordinates at forward edge of spaceship.
    d == distance from center (optional)
    x, y == relative offset from center (optional)
--]]
function spaceship:nose(d)
  d = d or self.radius
  return self.x + math.cos(self.angle) * d,
         self.y + math.sin(self.angle) * d
end

--[[
    spaceship:segment
    Return current angle in degrees
    n == use fewer or more segments (optional)
--]]
function spaceship:segment(n)
  n = n or 360
  return math.floor(self.angle * (n / 2 / math.pi))
end

--[[ Return coordinates at rear edge of spaceship --]]
function spaceship:tail(d, x, y)
  d = d or self.radius
  x = x or 0
  y = y or 0
  return self.x - math.cos(self.angle) * d + x,
         self.y - math.sin(self.angle) * d + y
end

--[[ Update ship position and timers --]]
function spaceship:update(dt)
  local right, bottom = 320, 240
  self.x = self.x + self.dx * dt
  self.y = self.y + self.dy * dt
  self.x = (self.x + self.radius) % (right + self.radius * 2) - self.radius
  self.y = (self.y + self.radius) % (bottom + self.radius * 2) - self.radius
  if self.cooldown > 0 then
    self.cooldown = self.cooldown - dt * 1000
  else
    self.cooldown = 0
  end
  self.timer0 = math.max(0, self.timer0 - dt)
end

return spaceship
