tArgs = {...}
x = tArgs[1]
y = tArgs[2]

function fSubforward()
  if turtle.getItemCount(turtle.getSelectedSlot()) == 0 or not validSeed(turtle.getItemDetail(1)) then
    fSscan()
  end
  repeat
    bGo = turtle.forward()
    if bGo == false then
      if turtle.getFuelLevel() == 0 then
        print('Out of fuel. checking for fuel now...')
        repeat
          bFuel = turtle.refuel()
          sleep(1)
        until bFuel == true
      elseif turtle.detect() == true then
        print("...that block isn't supposed to be there. Move it out of my way to continue farming.")
        repeat
          bBlock = turtle.detect()
          sleep(1)
        until bBlock == false
      else
        print("Could not diagnose movement issue. Terminating with error.")
        error("Forward Issue Diagnostic failure")
      end
    end
  until bGo == true
end
function fSscan()
  local slotData = turtle.getItemDetail(1)
  if slotData then
    if not validSeed(slotData) then
      for i = 2, 15 do
        if turtle.getItemCount(i) < 1 then
          turtle.select(1)
          turtle.transferTo(i)
          slotData = turtle.getItemDetail(1)
        end
      end
    end
  end
  if not slotData then
    for i = 2, 15 do
      print(i)
      if turtle.getItemCount(i) > 0 then
        tData = turtle.getItemDetail(i)
        if tData then
          if validSeed(tData) then
            print("trying to move around slots")
            turtle.select(i)
            turtle.transferTo(1)
            turtle.select(1)
            break
          end
        end
      end
    end
  end
end
function fSforward()
  _, tMeta = turtle.inspectDown()
  if tMeta.metadata == 7 then
    turtle.digDown()
    if 	turtle.getItemCount(turtle.getSelectedSlot()) == 0  or not validSeed(turtle.getItemDetail(1)) then
      fSscan()
    end
    turtle.placeDown()
  elseif tMeta.metadata == nil then
    turtle.placeDown()
  end
  fSubforward()
end
function fDnS()
  for i = 2, 15 do
    turtle.select(i)
    repeat
      bFull = turtle.drop()
      if bFull == false and turtle.getItemCount() ~= 0 then
        print('Get your Wheat you lazy scum!')
        sleep(1)
      else
        break
      end
    until bFull == true
  end
  turtle.select(1)
  turtle.turnRight()
  turtle.forward()
end
function fFuelcheck(l, w)
  if w/2 == math.ceil(w/2) then
    nFuelR = (l*(w+1))+w+l+1
  else
    nFuelR = (l*(w+1))+w+1
  end
    nCurFuel = turtle.getFuelLevel()
  if nCurFuel < nFuelR then
    turtle.select(16)
    turtle.suck() --gives chest that nice succ
    repeat
      bFuelup = turtle.refuel(1)
      if bFuelup == false then
        sleep(1)
      end
    until nCurFuel <= nFuelR
    turtle.drop()
    turtle.select(1)
  end  
end
function fMkui()
  term.setBackgroundColor(colors.gray)
  term.clear()
  term.setTextColor(colors.white)
  term.setCursorPos(1, 1)
  print('            _            _')
  print('        .-./*) |------| (*\\.-.')
  print('      _/___\\/     ||     \\/___\\_')
  print('        U U       ||TARTLE  U U')
  print('------------------')
  print('Modified by Gene')
end
function fFarm()
  fMkui()
  term.setCursorPos(1, 6)
  fFuelcheck(tArgs[1], tArgs[2])
  for i = 1, y+1 do
    for j = 1, x do
      fSforward()
    end
    if i/2 ~= math.ceil(i/2) and i ~= y+1 then
      for i = 1, 2 do
        turtle.turnRight()
        fSubforward()
      end
    elseif i ~= y+1 then
      for i = 1, 2 do
        turtle.turnLeft()
        fSubforward()
      end
    else
      if (i-1)/2 == math.ceil((i-1)/2) then
        turtle.turnLeft()
        for j = 1, y do
          fSubforward()
        end
        turtle.turnLeft()
        for j = 1, x+1 do
          fSubforward()
        end
        turtle.turnRight()
        fDnS()
      else
        turtle.turnRight()
        for j = 1, y do
          fSubforward()
        end
        fDnS()
      end
    end
  end
end
function validSeed(i)
  n = i.name
  print(n)
  if n == "minecraft:carrot" then
    return true
  end
  if n == "magicalcrops:DiamondSeeds" then
    return true
  end
  if n == "magicalcrops:MinicioSeeds" then
    return true
  end
  if n == "magicalcrops:IronSeeds" then
    return true
  end
  if n == "minecraft:wheat_seeds" then
    return true
  end
  return false
end

whule true do
fFarm()
sleep(600)
end

