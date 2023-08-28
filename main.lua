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
missle0 = love.graphics.newImage("images/missile0.png")
missle1 = love.graphics.newQuad(0, 0, 16, 16, 256, 256)
missle2 = love.graphics.newQuad(0, 0, 16, 16, 256, 256)
missle3 = love.graphics.newQuad(0, 0, 16, 16, 256, 256)
missle4 = love.graphics.newQuad(0, 0, 16, 16, 256, 256)
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
  missle0,
  love.graphics.newQuad(0, 0, 16, 16, 256, 256),
  tile_width = 16, tile_height = 16
}
sprite_missile1 = Sprite:new{
  missle0,
  love.graphics.newQuad(0, 0, 16, 16, 256, 256),
  tile_width = 16, tile_height = 16
}
sprite_missile2 = Sprite:new{
  missle0,
  love.graphics.newQuad(0, 0, 16, 16, 256, 256),
  tile_width = 16, tile_height = 16
}
sprite_missile3 = Sprite:new{
  missle0,
  love.graphics.newQuad(0, 0, 16, 16, 256, 256),
  tile_width = 16, tile_height = 16
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
    Missile:new{x=1000, y=1000, timer=0, sprite=sprite_missile0},
    Missile:new{x=1000, y=1000, timer=0, sprite=sprite_missile1},
    Missile:new{x=1000, y=1000, timer=0, sprite=sprite_missile2},
    Missile:new{x=1000, y=1000, timer=0, sprite=sprite_missile3}
  }
  global_players = {
    Player:new{
      x=80,
      y=60,
      joystick=Joystick[0],
      sprite=sprite_player0,
      explosion=sprite_explosion0,
      rocket=sprite_exhaust0
    },
    Player:new{
      x=240,
      y=180,
      joystick=Joystick[1],
      sprite=sprite_player1,
      explosion=sprite_explosion1,
      rocket=sprite_exhaust1
    }
  }
  global_players[1].missiles = {
    global_missiles[1],
    global_missiles[2]
  }
  global_players[2].missiles = {
    global_missiles[3],
    global_missiles[4]
  }
end

function love.update(dt)
  if Joystick[0].start then
    love.load()
  end
  for _, asteroid in ipairs(global_asteroids) do
    asteroid.sprite:moveto(asteroid.x - 32, asteroid.y - 32)
  end
  for _, missile in ipairs(global_missiles) do
    local anim = math.floor((2000 - missile.timer) / 64) * 64
    if missile.timer > 1808 then
      missile.timer = missile.timer - dt * 1000
    elseif missile.timer > 0 then
      missile:translate(dt)
      missile.timer = missile.timer - dt * 1000
    else
      missile.x, missile.y = 1000, 1000
    end
    missile.sprite:moveto(missile.x - 8, missile.y - 8)
    missile.sprite[2]:setViewport(
      missile.sprite:get_tile(
        missile:segment(64) + math.min(anim, 192)
      )
    )
  end
  for i, player in ipairs(global_players) do
    if player.cooldown > 0 then
      player.cooldown = player.cooldown - dt * 1000
    else
      player.cooldown = 0
    end
    control(player, Joystick[i-1], dt)
    -- explode player if hit by missile
    for _, missile in ipairs(global_missiles) do
      if player:distance(missile) < player.radius + missile.radius then
        missile.timer = 0
        player.killed = true
      end
    end
    panimate(player, dt)
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
    -- launch missiles if available
    if joystick.fire and player.cooldown == 0 then
      player.cooldown = 750
      for _, missile in ipairs(player.missiles) do
        if missile.timer <= 0 then
          fire_missile(player, missile)
          break
        end
      end
    end
    -- accelerate and show rocket fire
    if joystick.up then
      player:accelerate(dt)
      player.rocket:moveto(player:tail(14, -16, -16))
    else
      player.rocket:moveto(1000, 1000)
    end
    -- rotate rocketship
    if joystick.left then
      player:rotate(-dt)
    elseif joystick.right then
      player:rotate(dt)
    end
  end
end

function fire_missile(player, missile)
  missile.x, missile.y = player:nose(24)
  missile.angle = player.angle
  missile.timer = 2000
end

function panimate(player, dt)
  player:translate(dt)
  player.sprite:moveto(player.x - 16, player.y - 16)
  player.sprite[2]:setViewport(
    player.sprite:get_tile(
      player:segment(64)
    )
  )
  -- animations to perform as player is killed
  if player.killed then
    local anim = math.floor(player.explosion.timer / 75) * 64
    player.explosion[2]:setViewport(math.min(anim, 192), 0, 64, 64)
    if anim < 250 then
      player.explosion:moveto(player.x - 32, player.y - 32)
    else
      player.explosion:moveto(1000, 1000)
    end
    player.sprite:moveto(1000, 1000)
    player.explosion.timer = player.explosion.timer + dt * 1000
  else
    player.explosion:moveto(1000, 1000)
  end
  player.rocket[1] = player.rocket.animation[
    math.floor(love.timer.getTime() * 10 % 2)
  ]
end
