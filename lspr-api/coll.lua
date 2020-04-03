--[[
         istouch and touch

         will remain seperate


]]
function col(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and x2 < x1+w1 and
         y1 < y2+h2 and y2 < y1+h1
end
function istouch(sprite,sprite2)
   local sp , sp2 = sprite , sprite2
    return col(sp.x,sp.y,sp.width,sp.height, sp2.x,sp2.y,sp2.width,sp2.height)
end
function istouchpoint(sprite,x,y)
  return col(sprite.x,sprite.y,sprite.width,sprite.height , x,y,1,1)
end
--[[

    The new and improved complete bump.lua supprot


    this below is not using any bump.lua but is using basic collision detectCollision

    in future version mid , px methods will be delted
    and  replaced with the method sao_

    short for scale and orgin support

]]
--
--
-- BUMP.lua support
--
--
--
function cross (sprite,sprite2,flag)
  local sp , sp2 , result  = sprite , sprite2 , false
  if flag == nil then flag = false end
    -- get the collision
   coll  = emptysafe(rect_detectCollision(sp.lastx,sp.lasty,sp.width,sp.height, sp2.lastx,sp2.lasty,sp2.width,sp2.height, sp.x , sp.y))
   -- only run if the touch is
   if isempty(coll.touch) then
   else
      result = coll.overlaps
      if coll.ti > 0 and coll.ti < 1 then
        result = true;
        if flag then
          --stick(sprite,sprite2)
        end
      end
   end
   -- return the result
   return result , coll
end
function slide(sprite,sprite2)
   local sp , sp2 = sprite , sprite2
    coll  = emptysafe(rect_detectCollision(sp.lastx,sp.lasty,sp.width,sp.height, sp2.lastx,sp2.lasty,sp2.width,sp2.height, sp.x , sp.y))
    if isempty(coll.touch) then

      coll = {
        donetouch = false,
      }
    else

      goalX = sp.x
      goalY = sp.y

      coll.donetouch = false
      tch, move  = coll.touch, coll.move
      if move.x ~= 0 or move.y ~= 0 then
        coll.donetouch = true
        if coll.normal.x ~= 0 then
          goalX = tch.x
        else
          goalY = tch.y
        end
      end

      coll.slide = {x = goalX, y = goalY}
      sprite.y = coll.slide.y
      sprite.x = coll.slide.x


    end

    return coll
end
function stick(sprite,sprite2)
   local sp , sp2 = sprite , sprite2
    coll  = emptysafe(rect_detectCollision(sp.lastx,sp.lasty,sp.width,sp.height, sp2.lastx,sp2.lasty,sp2.width,sp2.height, sp.x , sp.y))
    if isempty(coll.touch) then
      coll = {
        donetouch = false,
      }
    else
      if coll.move.x ~= 0 or coll.move.y ~= 0 then
        coll.donetouch = true
      end
      sprite.y = coll.touch.y
      sprite.x = coll.touch.x
    end
    return coll
end
function bounce(sprite,sprite2)
   local sp , sp2 = sprite , sprite2
    coll  = emptysafe(rect_detectCollision(sp.lastx,sp.lasty,sp.width,sp.height, sp2.lastx,sp2.lasty,sp2.width,sp2.height, sp.x , sp.y))
    if isempty(coll.touch) then
      coll = {
        donetouch = false,
      }
    else
      goalX = sp.x
      goalY = sp.y

      local tch, move = coll.touch, coll.move
      local tx, ty = tch.x, tch.y

      local bx, by = tx, ty

      if move.x ~= 0 or move.y ~= 0 then
        coll.donetouch = true
        local bnx, bny = goalX - tx, goalY - ty
        if coll.normal.x == 0 then bny = -bny else bnx = -bnx end
        bx, by = tx + bnx, ty + bny
      end

      coll.bounce   = {x = bx,  y = by}
      x,y          = tch.x, tch.y
      goalX, goalY = bx, by

      sprite.y = coll.bounce.y
      sprite.x = coll.bounce.x
    end
    return coll
end
-- velocity version
function bouncevelo(sprite,sprite2,bounceiness)
   local sp , sp2 = sprite , sprite2
    coll  = emptysafe(rect_detectCollision(sp.lastx,sp.lasty,sp.width,sp.height, sp2.lastx,sp2.lasty,sp2.width,sp2.height, sp.x , sp.y))
    if isempty(coll.touch) then else
      goalX = sp.x
      goalY = sp.y

      local tch, move = coll.touch, coll.move
      local tx, ty = tch.x, tch.y

      local bx, by = tx, ty

      if move.x ~= 0 or move.y ~= 0 then
        local bnx, bny = goalX - tx, goalY - ty
        if coll.normal.x == 0 then bny = -bny else bnx = -bnx end
        bx, by = tx + bnx, ty + bny
      end

      coll.bounce   = {x = bx,  y = by}
      x,y          = tch.x, tch.y
      goalX, goalY = bx, by
      sprite.y = coll.bounce.y
      sprite.x = coll.bounce.x
      sprite.velocity.y = coll.move.y * bounceiness
      sprite.velocity.x = coll.move.x * bounceiness
    end
end
