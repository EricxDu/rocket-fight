local asteroid = {
  right = 320,
  bottom = 240,
  x = 0,
  y = 0,
  radius = 32,
  speed = 0
}

function asteroid:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function asteroid:translate(dt)
  self.x = self.x + math.cos(self.angle) * self.speed * dt
  self.y = self.y + math.sin(self.angle) * self.speed * dt
  self.x = (self.x+self.radius) % (self.right+self.radius*2) - self.radius
  self.y = (self.y+self.radius) % (self.bottom+self.radius*2) - self.radius
end

return asteroid
