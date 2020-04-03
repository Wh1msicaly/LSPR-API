

--
--
--     lock value modifies every single value
-- that has to do with size or posistionsing
--
--       either convert actual pixel vals into pxl pxllockvalu
--
--          or round not pxllockvalues
function pxllockvalue(val)
  return val * lsworld.lock
end
function pxllockround(val)
  return math.floor(val / lsworld.lock) * lsworld.lock
end
function normaltopxllockvalue(val)
  return val / lsworld.lock
end
function perpxllockvalue(val)
  return pxllockvalue(val / lsworld.lock)
end
-- img
function img(str)
  return love.graphics.newImage(str)
end
--
--
-- get group sprite
--
--
function dist(x1,y1,x2,y2)
  a = x1 - x2;
  b = y1 - y2;
  return math.sqrt( a*a + b*b );
end
function setlock(var)
  lsworld.lock = var
end
--
--
-- destroysprite
--
function destroyallsprites(s)
  spritelist = {}
end

function lspr_checkforid(list,id)
  for i=1,#list do
    if list[i] == id then
      return i
    end
  end
  return 0
end
function autosizesprite(sprite)
  sprite.width = pxllockvalue(sprite.image:getWidth());
  sprite.height = pxllockvalue(sprite.image:getHeight());
end
