function rgb(r,g,b)
  return {r=r,g=g,b=b}
end
function rgba(r,g,b,a)
  return  {r=r,g=g,b=b,alpha=a}
end
function roundto(num,val)
 return math.ceil(num / val) * val;
end
--
----
--    useful function
    --
    -- img
    function img(str)
      return love.graphics.newImage(str)
    end
    function pximg(str)
      local h = img(str)
      h:setFilter("nearest", "nearest")
      return h
    end
function round(n)
  return math.floor((math.floor(n*2) + 1)/2)
end
function isempty(s)
  return s == nil or s == ''
end
function emptysafe(s)
  if s == nil then return {} end
  return s
end
function table.copy(t)
  local u = { }
  for k, v in pairs(t) do u[k] = v end
  return setmetatable(u, getmetatable(t))
end
function copysprite(sprite)
 return table.copy(sprite)
end
function valcon(val)
  con = val/255
  if con > 255 then
    return 255
  end
  if con < 0 then
    return 0
  end
  return con
end
function max(val,max)
 if(val > max) then return max end
 return val
end
function min(val,min)
 if(val < min) then return min end
 return val
end
function range(val,min,max)
  if(val < min) then return min end
  if(val > max) then return max end
  return val
end
function passxarray(array,val)
  return  {array = array , val = val}
end
function readxarray(xarray)
  return  xarray.array[xarray.val]
end
function table.deepinsert(array1,array2)
  for i=1,table.getn(array2) do
    array1[#array1+1] = array2[i]
  end
end
function inc(val)
 val = val + 1
end
function dist( x1, y1, x2, y2 )
  local dx = x1 - x2
  local dy = y1 - y2
  return dx+dy
end
function pxllockvalue(val)
  return val * lsworld.lock
end
function pxllockround(val)
  return math.floor(val / lsworld.lock) * lsworld.lock
end
function normaltopxllockvalue(val)
  return val / lsworld.lock
end
function setspritesizefromimage( sprite , nwidth, nheight )
    local cwidth, cheight = sprite.image:getDimensions()
    sprite.scalex , sprite.scaley =  (nwidth/cwidth), (nheight/cheight)
    sprite.width = nwidth
    sprite.height = nheight
end
function merge(a, b)
    if type(a) == 'table' and type(b) == 'table' then
        for k,v in pairs(b) do if type(v)=='table' and type(a[k] or false)=='table' then merge(a[k],v) else a[k]=v end end
    end
    return a
end
function combine(a, b)
  a = merge(a,b)
end
function lspr.print(v)
  print(inspect(v))
end
function lspr.checkforid(list,id)
  for i=1,#list do
    if list[i] == id then
      return i
    end
  end
  return 0
end
function checkfor(list,thing)
  return  lspr.checkforidbool(list,thing)
end
function lspr.checkforidbool(list,id)
  for i=1,#list do
    if list[i] == id then
      return true
    end
  end
  return false
end
function getanglevalues(angle,speed)
  return {
  x = (math.cos(angle * math.pi  / 180))  * speed,
  y = (math.sin(angle * math.pi  / 180)) * speed
  }
end
function moveindirection(sprite,speed,angle)
  sprite.x = (math.cos(angle * math.pi  / 180))  * speed
  sprite.y = (math.sin(angle * math.pi  / 180)) * speed
end
