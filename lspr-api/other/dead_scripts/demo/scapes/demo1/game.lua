-- love.load = load() , love.update = update() etc...
--[[

    All images, sounds or other love2d objects, should be made in main to
    remain global variables. otherwise the will only work in this (scope in lua)

]]
function load()

  width = love.graphics.getWidth()
  love.physics.setMeter(74)
  physicsworld = createworld(0, 9.81*64, true)

    --
    --  Lspr below
    --
    --
    camera = getcamera()
    -- declare tilesize
    tilesize = round(width/18);
    -- make
    world = creategroup()
    --[[
    {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    ]]
    levels = {
      {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
      {5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
      {3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
      {1,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
      {1,1,0,3,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0},
      {1,1,1,1,1,1,1,1,1,0,0,2,1,0,0,0,0,0,0},
      {1,1,0,0,0,0,0,0,0,0,2,1,1,0,0,0,0,0,0},
      {1,1,0,0,0,0,0,0,0,2,1,1,1,0,0,0,0,0,0},
      {1,1,3,0,0,1,1,1,1,1,1,1,1,0,0,0,0,0,0},
      {1,1,1,3,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0},
      {1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
      {1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
      {0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
      {0,0,0,1,1,3,0,0,0,0,0,1,1,0,0,0,0,0,0},
      {0,0,0,1,1,1,3,0,0,0,0,1,1,0,0,0,0,0,0},
      {0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0},
      {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
      {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    }
    --
    --      Images
    --
    bngimage , boximg , lslopeimg  , rslopeimg , boxbreakimg , particleimg , winimg = img("background.png") , pximg("box.png") , pximg("lslope.png") , pximg("rslope.png") , pximg("boxbreak.png") , pximg("particle.png") , img("win.png")



    background = createsprite(0,0,"image")
    background.image = bngimage
    autosizesprite(background)
    background.scalex = width*1/background.width
    background.scaley = width*1/background.width

    player = createsprite(tilesize/2,tilesize);
    player.radius = tilesize/2.2
    player.color.b = 0;
    player.color.g = 0;
    addphystosprite(player,physicsworld,"dynamic")


    loadlevel()
    particles = creategroup()
    breakparticles = createparticlesystem(particles)
    breakparticles.speed = {100,200}
    breakparticles.angle = {0,360}
    breakparticles.faderate = 0.2;
    breakparticles.oncreate = function(sprite)
      sprite.width = 4
      sprite.height = 4
      setshape(sprite,"image")
      sprite.image = particleimg
        sprite.phys.body:setActive(true)
    end
    breakparticles.onexit = function(sprite)
      sprite.phys.body:setActive(false)
    end
    breakparticles:addparticles(100,function(sprite)
      sprite.x =-10000;
      sprite.width = 4
      sprite.height=  4
      addphystosprite(sprite,physicsworld,"dynamic")
      setshape(sprite,"rectangle")
      sprite.phys.body:setActive(false)
    end)
end
function update()
  particles:read(function(sprite)
    sprite.velocity.y = sprite.velocity.y + 2
  end)
  world:read(function(sprite)
    if istouchpoint(sprite,love.mouse.getX(),love.mouse.getY()) then
      if sprite.blocktype == "break" then
        breakparticles:spawnparticles(20,sprite.x,sprite.y)
        setphyspos(sprite,sprite.x,sprite.y-100)
        sprite.phys.body:setActive(false)
      end
    end
  end)
end
function draw()

end
function getlefttrianglepoints(size)
  return {size, 0, 0, size, size, size}
end
function getrighttrianglepoints(size)
  return {0, 0, 0, size, size, size}
end

function loadlevel()
  for x=1,18 do
    for y=1,18 do
     cx = (x * tilesize)-tilesize
     cy = (y * tilesize)-tilesize
     tilenum = levels[y][x]
     if tilenum == 1 then
       world:add(createsprite(cx,cy,"image"))
       block = world:get(world.length)
       block.image = boximg
       block.width = tilesize;
       block.height = tilesize;
       block.blocktype = "normal"
       addphystosprite(block,physicsworld,"static")
       setshape(block,"image")
       setspritesizefromimage(block,tilesize,tilesize)
       setspriteorgin(block,sprite_center)
     end
     if tilenum == 2 then
       world:add(createsprite(cx,cy,"polygon"))
       block = world:get(world.length)
       block.points = getlefttrianglepoints(tilesize)
       block.width = tilesize;
       block.height = tilesize;
       block.blocktype = "slope"
       addphystosprite(block,physicsworld,"static")
       setshape(block,"image")
       block.image = lslopeimg
       setspritesizefromimage(block,tilesize,tilesize)
       --setspriteorgin(block,sprite_center)
     end
     if tilenum == 3 then
       world:add(createsprite(cx,cy,"polygon"))
       block = world:get(world.length)
       block.points = getrighttrianglepoints(tilesize)
       block.width = tilesize;
       block.height = tilesize;
       block.blocktype = "slope"
       addphystosprite(block,physicsworld,"static")
       setshape(block,"image")
       block.image = rslopeimg
       setspritesizefromimage(block,tilesize,tilesize)
       --setspriteorgin(block,sprite_center)
     end
     if tilenum == 4  then
       setphyspos(player,cx+(tilesize/2),cy+(tilesize/2))
     end
     if tilenum == 5 then
       world:add(createsprite(cx,cy,"image"))
       block = world:get(world.length)
       block.image = boxbreakimg
       block.width = tilesize;
       block.height = tilesize;
       block.blocktype = "break"
       addphystosprite(block,physicsworld,"static")
       setshape(block,"image")
       setspritesizefromimage(block,tilesize,tilesize)
       setspriteorgin(block,sprite_center)
     end
    end
  end
end
--[[Dont delete this line, this returns the functions back to the scape. ]]return {load = load,update = update,draw = draw,}
