function love.load()
  lsprapi = "lspr-api";require (lsprapi)
  initall();
  --[[
      using initall(), updateall() , and  loadviews()[draw],

      allows you to run lspr instead of using scapes, orginally. this was the only way
      and in the future you may be able to change spritesets without changing the scape.
      but it hasent been implemted yet.


  ]]


  --[[

            this is a drawtype for  creating a shape for arcs,

            default include "rectangle","text","textf","image","animation","poly","circle","polygon"
  ]]
  addshape("arc",function(sprite,camera)
    -- do camera isnt really nessary here because the camera isnt being modified but this still
    lspr.docamera(camera,sprite)
    love.graphics.arc(sprite.mode, sprite.x, sprite.y, sprite.radius, sprite.angle1, sprite.angle2)
  end,
  {
    -- radius
    radius = 5,
    -- starting angles
    angle1 = math.rad(0),
    angle2 = math.rad(0),
  })

  -- create sprite with drawtype "arc"
  arc = createsprite(100,100,"arc")
  arc.radius = 10
 --[[set velocity ]]
  arc.velocity.x = 30



end


function love.update(dt)
  -- incriment angle2
    arc.angle2 = arc.angle2 + 0.1
    -- if more than 363 (+3 for delay) reset
    if math.deg(arc.angle2) > 363 then
      arc.angle2 = 0;
    end
    -- inverese velocity on bounderies
    if arc.x > love.graphics.getWidth() then
      arc.velocity.x = -30
    end
    if arc.x < 0 then
      arc.velocity.x = 30
    end
  --[[required]] updateall(dt)
end

function love.draw()
  --[[required]]loadviews()
end
