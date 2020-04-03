-- love.load = load() , love.update = update() etc...
--[[

    All images, sounds or other love2d objects, should be made in scopes
    are global. duplicate sprites will be overwritten so unique names are needed
    for other scapes

    unless, you localize the variables by following the format in game.lua

    but if you wish not to use a localized format you can still use this

]]

function load()
  circle = createsprite(0,100,"circle")
end
function update()
  circle .x = circle.x + 3
end
function draw()

end
-- Make sure this is accurate
return {load = load,update = update,draw = draw,}
