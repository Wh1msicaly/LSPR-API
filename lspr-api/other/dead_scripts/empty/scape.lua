-- love.load = load() , love.update = update() etc...
--[[

    All images, sounds or other love2d objects, should be made in scopes
    are global. duplicate sprites will be overwritten so unique names are needed
    for other scapes

    unless, you localize the variables by following this format.

    but if you wish not to use a localized format you can use the format in
    game2.lua

]]
local game = {}
function game.load()
  game.circle = createsprite(0,100,"rectangle")
end
function game.update()
  game.circle .x = game.circle.x + 1
end
function game.draw()

end


-- Make sure this is accurate
-- if not it will not work correctly you must return load,draw,update
-- functions even if there empty.
return {load = game.load,update = game.update,draw = game.draw,}
