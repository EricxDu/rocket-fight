Asteroid = require'asteroid'
Joystick = require'joystick'
Missile = require'missile'
Player = require'spaceship'
Sprite = require'sprite'

needle0 = love.graphics.newImage("images/needle0.png")
needle1 = love.graphics.newImage("images/needle1.png")
needle2 = love.graphics.newImage("images/needle2.png")
needle3 = love.graphics.newQuad(0, 0, 32, 32, 256, 256)
wedge0 = love.graphics.newImage("images/wedge0.png")
wedge1 = love.graphics.newImage("images/wedge1.png")
wedge2 = love.graphics.newImage("images/wedge2.png")
wedge3 = love.graphics.newQuad(0, 0, 32, 32, 256, 256)
missile0 = love.graphics.newImage("images/missile0.png")
missile1 = love.graphics.newImage("images/missile1.png")
missile2 = love.graphics.newImage("images/missile2.png")
missile3 = love.graphics.newImage("images/missile3.png")
asteroid0 = love.graphics.newImage("images/asteroid0.png")
asteroid_large0 = love.graphics.newQuad(0, 0, 64, 64, 256, 256)
asteroid_medium0 = love.graphics.newQuad(64, 0, 32, 32, 256, 256)
asteroid_medium1 = love.graphics.newQuad(96, 0, 32, 32, 256, 256)
asteroid_medium2 = love.graphics.newQuad(64, 32, 32, 32, 256, 256)
asteroid_medium3 = love.graphics.newQuad(96, 32, 32, 32, 256, 256)
asteroid_small0 = love.graphics.newQuad(128, 0, 16, 16, 256, 256)
asteroid_small1 = love.graphics.newQuad(144, 0, 16, 16, 256, 256)
asteroid_small2 = love.graphics.newQuad(128, 16, 16, 16, 256, 256)
asteroid_small3 = love.graphics.newQuad(144, 16, 16, 16, 256, 256)
explosion0 = love.graphics.newImage("images/explosion0.png")
explosion1 = love.graphics.newQuad(0, 0, 64, 64, 256, 256)
explosion2 = love.graphics.newQuad(0, 0, 64, 64, 256, 256)

sprite_asteroid0 = Sprite:new{
  asteroid0, asteroid_large0, tile_width = 64, tile_height = 64
}
sprite_player0 = Sprite:new{
  needle0, needle3, tile_width = 32, tile_height = 32
}
sprite_player1 = Sprite:new{
  wedge0, wedge3, tile_width = 32, tile_height = 32
}
sprite_missile0 = Sprite:new{
  missile3,
  love.graphics.newQuad(0, 0, 16, 16, 128, 128),
  texture_width = 128, texture_height = 128,
  tile_width = 16, tile_height = 16,
  animation = {[0] = missile0, missile1, missile2, missile3}
}
sprite_missile1 = Sprite:new{
  missile3,
  love.graphics.newQuad(0, 0, 16, 16, 128, 128),
  texture_width = 128, texture_height = 128,
  tile_width = 16, tile_height = 16,
  animation = {[0] = missile0, missile1, missile2, missile3}
}
sprite_missile2 = Sprite:new{
  missile3,
  love.graphics.newQuad(0, 0, 16, 16, 128, 128),
  texture_width = 128, texture_height = 128,
  tile_width = 16, tile_height = 16,
  animation = {[0] = missile0, missile1, missile2, missile3}
}
sprite_missile3 = Sprite:new{
  missile3,
  love.graphics.newQuad(0, 0, 16, 16, 128, 128),
  texture_width = 128, texture_height = 128,
  tile_width = 16, tile_height = 16,
  animation = {[0] = missile0, missile1, missile2, missile3}
}
sprite_missile4 = Sprite:new{
  missile3,
  love.graphics.newQuad(0, 0, 16, 16, 128, 128),
  texture_width = 128, texture_height = 128,
  tile_width = 16, tile_height = 16,
  animation = {[0] = missile0, missile1, missile2, missile3}
}
sprite_missile5 = Sprite:new{
  missile3,
  love.graphics.newQuad(0, 0, 16, 16, 128, 128),
  texture_width = 128, texture_height = 128,
  tile_width = 16, tile_height = 16,
  animation = {[0] = missile0, missile1, missile2, missile3}
}
sprite_missile6 = Sprite:new{
  missile3,
  love.graphics.newQuad(0, 0, 16, 16, 128, 128),
  texture_width = 128, texture_height = 128,
  tile_width = 16, tile_height = 16,
  animation = {[0] = missile0, missile1, missile2, missile3}
}
sprite_missile7 = Sprite:new{
  missile3,
  love.graphics.newQuad(0, 0, 16, 16, 128, 128),
  texture_width = 128, texture_height = 128,
  tile_width = 16, tile_height = 16,
  animation = {[0] = missile0, missile1, missile2, missile3}
}
sprite_exhaust0 = Sprite:new{
  needle1, needle3,
  tile_width = 32, tile_height = 32,
  animation = {[0] = needle1, needle2}
}
sprite_exhaust1 = Sprite:new{
  wedge1, wedge3,
  tile_width = 32, tile_height = 32,
  animation = {[0] = wedge1, wedge2}
}
sprite_explosion0 = Sprite:new{
  explosion0, explosion1,
  tile_width = 32, tile_height = 32,
  timer = 0
}
sprite_explosion1 = Sprite:new{
  explosion0, explosion2,
  tile_width = 32, tile_height = 32,
  timer = 0
}

global_sprites = {
  sprite_asteroid0,
  sprite_player0,
  sprite_player1,
  sprite_missile0,
  sprite_missile1,
  sprite_missile2,
  sprite_missile3,
  sprite_missile4,
  sprite_missile5,
  sprite_exhaust0,
  sprite_exhaust1,
  sprite_explosion0,
  sprite_explosion1
}

function love.load()
  global_asteroids = {
    Asteroid:new{x=160, y=120, sprite=sprite_asteroid0}
  }
  global_explosions = {}
  global_missiles = {
    Missile:new{x=1000, y=1000, life=0, sprite=sprite_missile0},
    Missile:new{x=1000, y=1000, life=0, sprite=sprite_missile1},
    Missile:new{x=1000, y=1000, life=0, sprite=sprite_missile2},
    Missile:new{x=1000, y=1000, life=0, sprite=sprite_missile3},
    Missile:new{x=1000, y=1000, life=0, sprite=sprite_missile4},
    Missile:new{x=1000, y=1000, life=0, sprite=sprite_missile5}
  }
  global_players = {
    Player:new{
      x=80,
      y=60,
      joystick=Joystick[0],
      missiles0={},
      sprite=sprite_player0,
      sprites1={sprite_missile0,sprite_missile1,sprite_missile2},
      explosion=sprite_explosion0,
      rocket=sprite_exhaust0
    },
    Player:new{
      x=240,
      y=180,
      joystick=Joystick[1],
      missiles0={},
      sprite=sprite_player1,
      sprites1={sprite_missile3,sprite_missile4,sprite_missile5},
      explosion=sprite_explosion1,
      rocket=sprite_exhaust1
    }
  }
--[[
  global_players[1].missiles = {
    global_missiles[1],
    global_missiles[2],
    global_missiles[3]
  }
  global_players[2].missiles = {
    global_missiles[4],
    global_missiles[5],
    global_missiles[6]
  }
--]]
  global_players[1].hazards = {
    global_asteroids[1],
    global_missiles[4],
    global_missiles[5],
    global_missiles[6]
  }
  global_players[2].hazards = {
    global_asteroids[1],
    global_missiles[1],
    global_missiles[2],
    global_missiles[3]
  }
end

function love.update(dt)
  if Joystick[0].start then
    love.load()
  end
  for _, asteroid in ipairs(global_asteroids) do
    asteroid.sprite:moveto(asteroid.x - 32, asteroid.y - 32)
  end
  for _, player in ipairs(global_players) do
    control(player, player.joystick, dt)
    player:animate(dt)
    -- explode player if hit by hazard
    for _, hazard in ipairs(player.hazards) do
      if player:distance(hazard) < player.radius + hazard.radius then
        hazard.life = 0
        player.killed = true
      end
    end
    for index = #player.missiles0, 1, -1 do
      local missile = player.missiles0[index]
      if missile.timer0 > 0 then
        missile:update(dt)
      else
        table.remove(player.missiles0, index)
      end
    end
    for i, sprite in ipairs(player.sprites1) do
      if player.missiles0[i] then
        local missile = player.missiles0[i]
        player.sprites1[i]:moveto(missile.x - 8, missile.y - 8)
        sprite[2]:setViewport(
          sprite:get_tile(
            missile:segment(64)
          )
        )
      else
        player.sprites1[i]:moveto(1000, 1000)      
      end
    end
  end
  table.insert(global_sprites, table.remove(global_sprites, 1))
end

function love.draw()
  for _, sprite in ipairs(global_sprites) do
    love.graphics.draw(unpack(sprite))
  end
end

function control(player, joystick, dt)
  if player.killed then
    player.rocket:moveto(1000, 1000)
    return
  end
  if joystick then
    -- fire missiles if available
    if joystick.fire and player.cooldown == 0 then
      player.cooldown = 750
      table.insert(player.missiles0, player:fire0())
    end
    -- accelerate and show rocket fire
    if joystick.up then
      player.rocket:moveto(player:tail(14, -16, -16))
    else
      player.rocket:moveto(1000, 1000)
    end
    -- rotate rocketship
    player:control{
      up = joystick.up,
      left = joystick.left,
      right = joystick.right,
      dt = dt
    }
  end
end

function Missile:animate(dt)
--  self.sprite:moveto(self.x - 8, self.y - 8)
  self.fuse = math.min(2000 - self.life, 192)
  self.sprite[1] = self.sprite.animation[
    math.floor(self.fuse / 64)
  ]
  self.sprite[2]:setViewport(
    self.sprite:get_tile(
      self:segment(64)
    )
  )
end

function Missile:control(dt)
  if self.life > 0 then
    self:update(dt)
    self.life = self.life - dt * 1000
  else
    self.life = 0
    self.x, self.y = 1000, 1000
  end
end

function Player:animate(dt)
  self:update(dt)
  self.sprite:moveto(self.x - 16, self.y - 16)
  self.sprite[2]:setViewport(
    self.sprite:get_tile(
      self:segment(64)
    )
  )
  -- animations to perform as player is killed
  if self.killed then
    local anim = math.floor(self.explosion.timer / 75) * 64
    self.explosion[2]:setViewport(math.min(anim, 192), 0, 64, 64)
    if anim < 250 then
      self.explosion:moveto(self.x - 32, self.y - 32)
    else
      self.explosion:moveto(1000, 1000)
    end
    self.sprite:moveto(1000, 1000)
    self.explosion.timer = self.explosion.timer + dt * 1000
  else
    self.explosion:moveto(1000, 1000)
  end
  self.rocket[1] = self.rocket.animation[
    math.floor(love.timer.getTime() * 10 % 2)
  ]
end
