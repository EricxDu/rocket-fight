local joystick = {
  [0] = {},
  [1] = {},
  [2] = {},
  [3] = {}
}

function love.joystickpressed(n, b)
  if b == 0 then
    joystick[n].fire = true
  elseif b == 3 then
    joystick[n].start = true
  elseif b == 4 then
    joystick[n].up = true
  elseif b == 6 then
    joystick[n].left = true
  elseif b == 7 then
    joystick[n].right = true
  end
end

function love.joystickreleased(n, b)
  if b == 0 then
    joystick[n].fire = false
  elseif b == 3 then
    joystick[n].start = false
  elseif b == 4 then
    joystick[n].up = false
  elseif b == 6 then
    joystick[n].left = false
  elseif b == 7 then
    joystick[n].right = false
  end
end

return joystick
