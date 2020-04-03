function love.load()
    require "lspr-api"
    t = createsprite(t,love.graphics.getWidth()/2,0,"rectangle")
    t.height = 2
    t.width = 2
    plat = creategroup();
    for i=1,10000 do
      add(plat,createsprite(nil,pxllockvalue(math.random(0,love.graphics.getWidth())),600-math.random(0,100000),"rectangle"))
    end
end

function love.update(dt)
  if love.keyboard.isDown("w") then
    t.velocity.y  = - 90
  end
  if love.keyboard.isDown("d") then
    t.x = t.x + 1
  end
  if love.keyboard.isDown("a") then
    t.x = t.x - 1
  end
  if not t.overlap then t.velocity.y = t.velocity.y + 1 end
  -- always be on bottom
  platforms()
  updatesprites(dt)
  updateanimations(dt)
end

function love.draw()
  loadsprites()
end

function platforms()
  for i=1,plat.length do
    plati = get(plat,i)
    plati.y = plati.y - 0.1
    plati.width = 1
    plati.height = 1
    if plati.y < 0 then
      plati.y = plati.y + love.graphics.getHeight();
    end
    collide(t,plati)
  end
end
