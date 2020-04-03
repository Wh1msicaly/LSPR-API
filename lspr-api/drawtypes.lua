lspr.shapes = {}
lspr.shapename = {}
lspr.shapecontents = {}
lspr.universalcontent = {}

function lspr.getdrawfunction(shape)
  for i=1,#lspr.shapes do
    currentshape = lspr.shapename[i]
    if currentshape == shape then
      return lspr.shapes[i]
    end
  end
  return function(self) end
end

function lspr.getcontents(shape)
  for i=1,#lspr.shapes do
    currentshape = lspr.shapename[i]
    if currentshape == shape then
      return table.copy(lspr.shapecontents[i])
    end
  end
  return  {}
end
function lspr.addcontentstoshape(shape,content)
  for i=1,#lspr.shapes do
    currentshape = lspr.shapename[i]
    if currentshape == shape then
      merge(lspr.shapecontents[i],content)
    end
  end

end
function lspr.docamera(camera,sprite)
    love.graphics.scale(lsworld.lock * camera.zoom , lsworld.lock * camera.zoom)
    love.graphics.translate(((-1) * ((camera.x + camera.orgin.x)))  + sprite.orgin.x ,((-1 ) * ((camera.y + camera.orgin.y) * sprite.distance))  + sprite.orgin.y)
end
function lspr.addshape(shape,contents)
  lspr.shapes[#lspr.shapes+1] = function()end
  lspr.shapename[#lspr.shapename+1] = shape
  lspr.shapecontents[#lspr.shapecontents+1] = table.copy(contents)
end
function lspr.updatedrawtype(sprite,shape)
  sprite.ondraw = lspr.getdrawtype(shape)
end

-- alternate name
function setshape(sprite,shape)
  lspr.updatedrawtype(sprite,shape)
end
function addshape(sprite,func,contents)
  lspr.addshape(sprite,func,contents)
end

























function lspr.getdefaultshapes()
  lspr.shapes = {
    -- rect
    function(sprite,camera)
      love.graphics.push()
      love.graphics.setColor(sprite.color.r,sprite.color.g,sprite.color.b,sprite.color.alpha)
      love.graphics.scale(lsworld.lock * camera.zoom, lsworld.lock * camera.zoom)
  love.graphics.translate(((-1) * ((camera.x + camera.orgin.x) * sprite.distance))  - sprite.orgin.x ,((-1 ) * ((camera.y + camera.orgin.y) * sprite.distance))  - sprite.orgin.y)
      love.graphics.rectangle(sprite.mode, round(sprite.x / lsworld.lock), round(sprite.y / lsworld.lock),sprite.width, sprite.height )
      love.graphics.pop()
    end,
    -- text
    function(sprite,camera)
      if camera.enabletext then
        love.graphics.push()
        love.graphics.setColor(sprite.color.r,sprite.color.g,sprite.color.b,sprite.color.alpha)
        love.graphics.setFont(sprite.font)
  love.graphics.translate(((-1) * ((camera.x + camera.orgin.x) * sprite.distance))  - sprite.orgin.x ,((-1 ) * ((camera.y + camera.orgin.y) * sprite.distance))  - sprite.orgin.y)
        love.graphics.print(sprite.text,sprite.x,sprite.y,sprite.rotation,sprite.scale,sprite.scale)
        love.graphics.pop();
      end
    end,
    -- textf
    function(sprite,camera)
      if camera.enabletext then
        love.graphics.push()
        love.graphics.setColor(sprite.color.r,sprite.color.g,sprite.color.b,sprite.color.alpha)
        love.graphics.setFont(sprite.font)
  love.graphics.translate(((-1) * ((camera.x + camera.orgin.x) * sprite.distance))  - sprite.orgin.x ,((-1 ) * ((camera.y + camera.orgin.y) * sprite.distance))  - sprite.orgin.y)
        love.graphics.printf(sprite.text,sprite.x,sprite.y,sprite.limit,sprite.align)
        love.graphics.pop()
      end
    end,
    -- image
    function(sprite,camera)
      love.graphics.push()
      love.graphics.setColor(sprite.color.r,sprite.color.g,sprite.color.b,sprite.color.alpha)
      love.graphics.scale(lsworld.lock * camera.zoom, lsworld.lock * camera.zoom)
      love.graphics.translate(((-1) * ((camera.x + camera.orgin.x) * sprite.distance))  - (sprite.orgin.x - (sprite.width)/2) ,((-1 ) * ((camera.y + camera.orgin.y) * sprite.distance))  - (sprite.orgin.y -  (sprite.height)/2))
      love.graphics.draw(sprite.image, math.floor(sprite.x / lsworld.lock), math.floor(sprite.y / lsworld.lock),math.rad(sprite.rotation),sprite.scalex,sprite.scaley,(sprite.width/sprite.scalex)/2,(sprite.height/sprite.scaley)/2)
      love.graphics.pop()
    end,
    -- animation
    function(sprite,camera)
      love.graphics.push()
      love.graphics.setColor(sprite.color.r,sprite.color.g,sprite.color.b,sprite.color.alpha)
      love.graphics.scale(lsworld.lock * camera.zoom , lsworld.lock * camera.zoom)
  love.graphics.translate(((-1) * ((camera.x + camera.orgin.x) * sprite.distance))  - sprite.orgin.x ,((-1 ) * ((camera.y + camera.orgin.y) * sprite.distance))  - sprite.orgin.y)
      sprite.anum = math.floor(sprite.animation.currentTime / sprite.animation.duration * #sprite.animation.quads) + 1
      if sprite.animation.quads[sprite.anum] ~= nil then
        love.graphics.draw(sprite.animation.spriteSheet, sprite.animation.quads[sprite.anum], math.floor(sprite.x / lsworld.lock), math.floor(sprite.y / lsworld.lock), 0, sprite.scale,sprite.scale)
      end
      love.graphics.pop()
    end,
    -- poly
    function(sprite,camera)
      love.graphics.push()
      love.graphics.setColor(sprite.color.r,sprite.color.g,sprite.color.b,sprite.color.alpha)
      love.graphics.scale(lsworld.lock * camera.zoom , lsworld.lock * camera.zoom)
      love.graphics.translate(((-1) * ((camera.x + camera.orgin.x) * sprite.distance))  - sprite.orgin.x ,((-1 ) * ((camera.y + camera.orgin.y) * sprite.distance))  - sprite.orgin.y)
      love.graphics.polygon("fill", sprite.phys.body:getWorldPoints(sprite.phys.shape:getPoints()))
      love.graphics.pop()
    end,
    -- circle
    function(sprite,camera)
      love.graphics.push()
      love.graphics.setColor(sprite.color.r,sprite.color.g,sprite.color.b,sprite.color.alpha)
      love.graphics.scale(lsworld.lock * camera.zoom, lsworld.lock * camera.zoom)
      love.graphics.translate(((-1) * ((camera.x + camera.orgin.x) * sprite.distance))  - sprite.orgin.x ,((-1 ) * ((camera.y + camera.orgin.y) * sprite.distance))  - sprite.orgin.y)
      love.graphics.circle(sprite.mode, math.floor(sprite.x / lsworld.lock), math.floor(sprite.y / lsworld.lock), sprite.radius )
      love.graphics.pop()
    end,
    -- polygon
    function (sprite,camera)
      love.graphics.push()
      love.graphics.setColor(sprite.color.r,sprite.color.g,sprite.color.b,sprite.color.alpha)
      love.graphics.scale(lsworld.lock * camera.zoom, lsworld.lock * camera.zoom)
      love.graphics.translate(((-1) * (((camera.x - sprite.x) + camera.orgin.x) * sprite.distance))  - sprite.orgin.x ,((-1 ) * (((camera.y - sprite.y) + camera.orgin.y) * sprite.distance))  - sprite.orgin.y)
      love.graphics.polygon(sprite.mode, sprite.points)
      love.graphics.pop()
    end
  }
  lspr.shapename = {"rectangle","text","textf","image","animation","poly","circle","polygon"}
  lspr.shapecontents = {
    -- rect
    {
      width = 10,
      height = 10,
    },
    -- text
    {
      text = "This is the deafault text",
      font = nil,
      limit = 60,
      width = 10,
      height = 10,
      align = "center",
    },
    -- textf
    {
      text = "This is the deafault text",
      font = nil,
      limit = 60,
      width = 10,
      height = 10,
      align = "center",
    },
    -- image
    {
      width = 10,
      height = 10,
      image = "nonexistant",
      rotation = 0,
    },
    -- animation
    {

    },
    -- poly
    {

    },
    -- circle
   {
     radius = 5,
   },
    -- polygon
   {
     points = {0,10,10,10,10,20,30,30,40,10}
   },
  }

  lspr.universalcontent = {
    scalex = 1,
    scaley = 1,
    velocity = {
      x = 0,
      y = 0,
      max = 0,
    },
    orgin = {
      x = 0,
      y = 0,
    },
    color = {
      r = 1,
      g = 1,
      b = 1,
      alpha = 1,
    },
    _type = _sprite,
    _subtype = _nonphys,
    mode = "fill",
    visible = true,
    distance = 1,
    rotation = 0,
    overlap,
  }
end
