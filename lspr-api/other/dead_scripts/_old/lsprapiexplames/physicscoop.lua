function love.load()
  require "lspr-api"
  love.physics.setMeter(64) --the height of a meter our worlds will be 64px
  world = createworld(world,0, 9.81*64, true) --create a world for the bodies to exist in with horizontal gravity of 0 and vertical gravity of 9.81

  --create the ground and top
  ground = createsprite(ground,0,650-10,"rectangle")
  ground.width = 650
  addphystosprite(ground,world,"static")
  ground.phys.fixture:setRestitution(0.9)

  top = createsprite(ground,0,0+0.5,"rectangle")
  top.width = 650
  addphystosprite(top,world,"static")
  top.phys.fixture:setRestitution(0.9)
  -- create the sides
  left = createsprite(ground,650-10,0,"rectangle")
  left.height = 650
  addphystosprite(left,world,"static")
  left.phys.fixture:setRestitution(0.9)

  right = createsprite(ground,0,0,"rectangle")
  right.height = 650
  addphystosprite(right,world,"static")
  -- you can add restitution or do add bounce() coming soon like setdesnity() or setfriction()
  right.phys.fixture:setRestitution(0.9)

  ball = createsprite(ball,650/2+100,650/2,"rectangle")
  ball.width = 50
  ball.height = 50
  addphystosprite(ball,world,"dynamic",3)

  ball2 = createsprite(ball,650/2-100,650/2,"rectangle")
  ball2.width = 50
  ball2.height = 50
  addphystosprite(ball2,world,"dynamic",3)

  middle = createsprite(ground,650/2,0,"rectangle")
  middle.height = 650

  boxes = creategroup()
  i2 =0
  for i=1,600 do
    add(boxes,createsprite(nil,math.random(0+12,650-12),math.random(0+12,650-12),"rectangle"))
    box = get(boxes,i)
    box.width = math.random(5,12)
    box.height = math.random(5,12)
    box.color.r =valcon(139)
    box.color.g =valcon(69)
    box.color.b =valcon(19)
  end
  addphystogroup(boxes,world)

  love.graphics.setBackgroundColor(0.41, 0.53, 0.97)
  love.window.setMode(650, 650)


  -- create cameras
  normalcamera = createcamera()
  maincamera = getcamera()
  maincamera.zoom = 0.0001
  minimap  = createcamera()
  minimap.zoom = 0.1
  p1c = createcamera()
  p2c = createcamera()
  hidefromcamera(p1c,middle)
  hidefromcamera(p2c,middle)
  hidefromcamera(minimap,middle)

  p1v = createview(p1v,love.graphics.getWidth()/2,love.graphics.getHeight(),p1c)
  p2v = createview(p2v,love.graphics.getWidth()/2,love.graphics.getHeight(),p2c)
  p2v.x = (love.graphics.getWidth()/4 ) * 2
  v3 = createview(v3,1000,1000,minimap)
  v4 = createview(c3,1000,1000,normalcamera,middle)
  v4.load = "type"
end


function love.update(dt)
  if love.keyboard.isDown("right") then
    ball.phys.body:applyForce(4000, 0)
  elseif love.keyboard.isDown("left") then
    ball.phys.body:applyForce(-4000, 0)
  elseif love.keyboard.isDown("up") then
    ball.phys.body:applyForce(0, -4000)
  elseif love.keyboard.isDown("down") then
    ball.phys.body:applyForce(0, 4000)
  end
  if love.keyboard.isDown("d") then
    ball2.phys.body:applyForce(4000, 0)
  elseif love.keyboard.isDown("a") then
    ball2.phys.body:applyForce(-4000, 0)
  elseif love.keyboard.isDown("w") then
    ball2.phys.body:applyForce(0, -4000)
  elseif love.keyboard.isDown("s") then
    ball2.phys.body:applyForce(0, 4000)
  end
 p1c.x = ball.x - (love.graphics.getWidth()/4) * 1
 p2c.x = ball2.x - (love.graphics.getWidth()/4) * 3
  -- update everything
  updateworlds(dt)
  updatesprites(dt)
end

function love.draw()
  -- load sprites would be fine but will do views so it leaves room for different addition
  loadviews()
end
