Joystick = require'joystick'
Missile = require'missile'
Player = require'spaceship'
Sprite = require'sprite'

sprite0 = Sprite:new{
  love.graphics.newImage("images/needle0.png"),
  love.graphics.newQuad(0, 0, 32, 32, 256, 256),
  tile_width = 32, tile_height = 32
}
sprite1 = Sprite:new{
  love.graphics.newImage("images/wedge0.png"),
  love.graphics.newQuad(0, 0, 32, 32, 256, 256),
  tile_width = 32, tile_height = 32
}
sprite2 = Sprite:new{
  sprite0[1],
  sprite0[2],
  tile_width = 32, tile_height = 32,
  animation = {
    [0] = love.graphics.newImage("images/needle1.png"),
    [1] = love.graphics.newImage("images/needle2.png")
  }
}
sprite3 = Sprite:new{
  sprite1[1],
  sprite1[2],
  tile_width = 32, tile_height = 32,
  animation = {
    [0] = love.graphics.newImage("images/wedge1.png"),
    [1] = love.graphics.newImage("images/wedge2.png")
  }
}
sprite4 = Sprite:new{
  love.graphics.newImage("images/missile0.png"),
  love.graphics.newQuad(0, 0, 16, 16, 256, 256),
  tile_width = 16, tile_height = 16
}
sprite5 = Sprite:new{
  love.graphics.newImage("images/missile0.png"),
  love.graphics.newQuad(0, 0, 16, 16, 256, 256),
  tile_width = 16, tile_height = 16
}
sprite6 = Sprite:new{
  love.graphics.newImage("images/missile0.png"),
  love.graphics.newQuad(0, 0, 16, 16, 256, 256),
  tile_width = 16, tile_height = 16
}
sprite7 = Sprite:new{
  love.graphics.newImage("images/missile0.png"),
  love.graphics.newQuad(0, 0, 16, 16, 256, 256),
  tile_width = 16, tile_height = 16
}
sprite8 = Sprite:new{
  love.graphics.newImage("images/asteroid0.png"),
  love.graphics.newQuad(144, 16, 16, 16, 256, 256),
  tile_width = 16, tile_height = 16
}
sprite9 = Sprite:new{
  love.graphics.newImage("images/asteroid0.png"),
  love.graphics.newQuad(160, 16, 16, 16, 256, 256),
  tile_width = 16, tile_height = 16
}
sprite10 = Sprite:new{
  love.graphics.newImage("images/asteroid0.png"),
  love.graphics.newQuad(144, 32, 16, 16, 256, 256),
  tile_width = 16, tile_height = 16
}
sprite11 = Sprite:new{
  love.graphics.newImage("images/asteroid0.png"),
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
end

function love.update(dt)
  if Joystick[0].start then
    love.load()
  end
  for i, player in ipairs(global_players) do
    local j = i - 1
    if Joystick[j] then
      if Joystick[j].fire and not player.fired then
        player.fired = true
        if global_missiles[i + 2].timer <= 0 then
          fire_missile(player, global_missiles[i + 2])
        end
      elseif not Joystick[j].fire then
        player.fired = false
      end
      if Joystick[j].up then
        player:accelerate(dt)
        player.rsprite:moveto(player:tail(14, -16, -16))
      else
        player.rsprite:moveto(1000, 1000)
      end
      if Joystick[j].left then
        player:rotate(-dt)
      elseif Joystick[j].right then
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
    local anim = 0
    if missile.timer > 2000 then
      anim = math.floor((missile.timer - 2001) / 48) * 64
      missile.timer = missile.timer - dt * 1000
    elseif missile.timer > 0 then
      missile:translate(dt)
      missile.timer = missile.timer - dt * 1000
    else
      missile.x = 1000
      missile.y = 1000
    end
    missile.sprite:moveto(missile.x - 8, missile.y - 8)
    missile.sprite[2]:setViewport(
      missile.sprite:get_tile(
        missile:segment(64) + 192 - anim
      )
    )
  end
  table.insert(global_sprites, 1, table.remove(global_sprites, #global_sprites))
end

function love.draw()
  for _, sprite in ipairs(global_sprites) do
    love.graphics.draw(unpack(sprite))
  end
end

function fire_missile(player, missile)
  missile.x, missile.y = player:nose(24)
  missile.angle = player.angle
  missile.timer = 2192
end
