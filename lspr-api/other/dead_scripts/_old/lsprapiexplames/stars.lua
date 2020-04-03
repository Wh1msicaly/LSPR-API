function love.load()
  require "lspr-api"
  initall()
  camera = getcamera()
  stars = creategroup()
  for i=1,10000 do
    stars:add(createsprite(math.random(-4000,4000),math.random(-4000,4000)))
    star = stars:get(i)
    star.distance = math.random(1,50)/10
    star.radius = star.distance/1.7
  end
end

function love.update(dt)

  if love.keyboard.isDown("d") then
    camera.x = camera.x + 1
  end
  if love.keyboard.isDown("a") then
    camera.x = camera.x - 1
  end
  if love.keyboard.isDown("w") then
    camera.y = camera.y - 1
  end
  if love.keyboard.isDown("s") then
    camera.y = camera.y + 1
  end
  updateall(dt)
end

function love.draw()
  loadviews()
end
