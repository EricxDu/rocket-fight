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
asteroid1 = love.graphics.newQuad(0, 0, 64, 64, 256, 256)
asteroid2 = love.graphics.newQuad(64, 0, 32, 32, 256, 256)
asteroid3 = love.graphics.newQuad(96, 0, 32, 32, 256, 256)
asteroid4 = love.graphics.newQuad(64, 32, 32, 32, 256, 256)
asteroid5 = love.graphics.newQuad(96, 32, 32, 32, 256, 256)
asteroid6 = love.graphics.newQuad(128, 0, 16, 16, 256, 256)
asteroid7 = love.graphics.newQuad(144, 0, 16, 16, 256, 256)
asteroid8 = love.graphics.newQuad(128, 16, 16, 16, 256, 256)
asteroid9 = love.graphics.newQuad(144, 16, 16, 16, 256, 256)

sprite0 = Sprite:new{needle0, needle3, tile_width = 32, tile_height = 32}
sprite1 = Sprite:new{wedge0, wedge3, tile_width = 32, tile_height = 32}
sprite2 = Sprite:new{needle1, needle3, tile_width = 32, tile_height = 32,
  animation = {[0] = needle1, needle2}
}
sprite3 = Sprite:new{wedge1, wedge3, tile_width = 32, tile_height = 32,
  animation = {[0] = wedge1, wedge2}
}
sprite4 = Sprite:new{
  missle0,
  love.graphics.newQuad(0, 0, 16, 16, 256, 256),
  tile_width = 16, tile_height = 16
}
sprite5 = Sprite:new{
  missle0,
  love.graphics.newQuad(0, 0, 16, 16, 256, 256),
  tile_width = 16, tile_height = 16
}
sprite6 = Sprite:new{
  missle0,
  love.graphics.newQuad(0, 0, 16, 16, 256, 256),
  tile_width = 16, tile_height = 16
}
sprite7 = Sprite:new{
  missle0,
  love.graphics.newQuad(0, 0, 16, 16, 256, 256),
  tile_width = 16, tile_height = 16
}
sprite8 = Sprite:new{
  asteroid0,
  love.graphics.newQuad(144, 16, 16, 16, 256, 256),
  tile_width = 16, tile_height = 16
}
sprite9 = Sprite:new{
  asteroid0,
  love.graphics.newQuad(160, 16, 16, 16, 256, 256),
  tile_width = 16, tile_height = 16
}
sprite10 = Sprite:new{
  asteroid0,
  love.graphics.newQuad(144, 32, 16, 16, 256, 256),
  tile_width = 16, tile_height = 16
}
sprite11 = Sprite:new{
  asteroid0,
  love.graphics.newQuad(160, 32, 16, 16, 256, 256),
  tile_width = 16, tile_height = 16
}
global_sprites = {
  sprite0,
  sprite1,
  sprite2,
  sprite3,
  sprite4,
  sprite5,
  sprite6,
  sprite7,
  sprite8,
  sprite9,
  sprite10,
  sprite11
}

function love.load()
  global_players = {
    Player:new{x=80, y=60, sprite=sprite0, rsprite=sprite2},
    Player:new{x=240, y=180, sprite=sprite1, rsprite=sprite3}
  }
  global_missiles = {
    Missile:new{x=1000, y=1000, timer=0, sprite=sprite4},
    Missile:new{x=1000, y=1000, timer=0, sprite=sprite5},
    Missile:new{x=1000, y=1000, timer=0, sprite=sprite6},
    Missile:new{x=1000, y=1000, timer=0, sprite=sprite7}
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
  for i, player in ipairs(global_players) do
    if player.cooldown > 0 then
      player.cooldown = player.cooldown - dt * 1000
    else
      player.cooldown = 0
    end
    if Joystick[i] then
      if Joystick[i].fire and player.cooldown == 0 then
        player.cooldown = 750
        for _, missile in ipairs(player.missiles) do
          if missile.timer <= 0 then
            fire_missile(player, missile)
            break
          end
        end
      elseif not Joystick[i].fire then
        player.fired = false
      end
      if Joystick[i].up then
        player:accelerate(dt)
        player.rsprite:moveto(player:tail(14, -16, -16))
      else
        player.rsprite:moveto(1000, 1000)
      end
      if Joystick[i].left then
        player:rotate(-dt)
      elseif Joystick[i].right then
        player:rotate(dt)
      end
    end
    player:translate(dt)
    player.sprite:moveto(player.x - 16, player.y - 16)
    player.sprite[2]:setViewport(
      player.sprite:get_tile(
        player:segment(64)
      )
    )
    player.rsprite[1] = player.rsprite.animation[
      math.floor(love.timer.getTime() * 10 % 2)
    ]
  end
  for _, missile in ipairs(global_missiles) do
    local anim = math.min(
      math.floor((2000 - missile.timer) / 64) * 64,
      192
    )
    if missile.timer > 1808 then
      missile.timer = missile.timer - dt * 1000
      missile.sprite:moveto(missile.x - 8, missile.y - 8)
    elseif missile.timer > 0 then
      missile:translate(dt)
      missile.timer = missile.timer - dt * 1000
      missile.sprite:moveto(missile.x - 8, missile.y - 8)
    else
      missile.sprite:moveto(1000, 1000)
    end
    missile.sprite[2]:setViewport(
      missile.sprite:get_tile(
        missile:segment(64) + anim
      )
    )
  end
  table.insert(global_sprites, 1, table.remove(global_sprites, #global_sprites))
end

function love.draw()
  for i, sprite in ipairs(global_sprites) do
    love.graphics.draw(unpack(sprite))
  end
end

function fire_missile(player, missile)
  missile.x, missile.y = player:nose(24)
  missile.angle = player.angle
  missile.timer = 2000
end
