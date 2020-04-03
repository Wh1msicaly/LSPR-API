function love.load()
  require "lspr-api"
  --[[
      by creating a game scape instead of writing in main. it allows,
      for menus and other screens to be switched to without writing extra
      code or having to teleport sprites around.

      but alternatively you can just not use any scapes, and just write in
      main by using initall(), updateall() , and  loadviews()[draw].


  ]]
  -- this is an example game
  stars = createscape("stars")
  -- game1, and game2 are empty and have
  -- information on how to get started in scapes.
  game2 = createscape("game2")
  game = createscape("game")

end


function love.update(dt)
  -- This is the global 'scape'
  -- in order to switch between scapes
  --[[ simplifyed function keydown ]]keydown = love.keyboard.isDown
  if keydown("1") then
    setscape(game2)
  end
  if keydown("2") then
    setscape(game)
  end
  if keydown("3") then
    setscape(stars)
  end
  updatescape(dt)
end

function love.draw()
  love.graphics.print("Press 1 , 2 , 3 to switch inbetween scapes", 50,50)
  drawscape()
end
