--- The infinite singularity... does stuff forever!


local tArgs = { ... }

x = tArgs[1]
y = tArgs[2]

local startX
local startY


local fuelLoaderX, fuelLoaderY

local seedLoaderX, seedLoaderY

function farm() {
    fuel(tArgs[1], tArgs[2])
}

--- Stolen from Tartal.lua, no idea what math it actually does
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


farm()