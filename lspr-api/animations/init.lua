-- createanimation  based off of love2d
function createanimation(image, width, height, duration)
    local animation = {}
    animation.spriteSheet = image
    animation.quads = {}
    animation.width = width
    animation.height = height
    animation.pause = false
    animation.looped = false
    animation.loop =  true
    animation.setanimation = setanimation
    for y = 0, image:getHeight() - height, height do
        for x = 0, image:getWidth() - width, width do
            table.insert(animation.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
        end
    end
    animation.duration = duration or 1
    animation.currentTime = 0
    return animation
end
-- setanimation sprite
function setanimation(sprite,animation)
  local _idm = lspr_checkforid(animationidlist,sprite.id)
  if _idm == 0 then
    print("WARNING ANIMATION ")
    print("  Duplication | Duplicates will not be ignored, they will be reset ")
    print("  new addition warning will removed in future version")
    sprite.shape = "animation"
    sprite.animation = table.copy(animation)
    sprite.anum = 0
    animationidlist[_idm] = sprite.id
  end
  sprite.shape = "animation"
  setshape(sprite,"animation")
  sprite.animation = table.copy(animation)
  sprite.anum = 0
  animationidlist[#animationidlist+1] = sprite.id
end

--  load animations
function updateanimations(dt)
  for i=1,#animationidlist do
      spritelist[_spriteset][animationidlist[i]].animation.looped = false
    if spritelist[_spriteset][animationidlist[i]].animation.pause then
    else
      spritelist[_spriteset][animationidlist[i]].animation.currentTime = spritelist[_spriteset][animationidlist[i]].animation.currentTime + dt
      if spritelist[_spriteset][animationidlist[i]].animation.currentTime >= spritelist[_spriteset][animationidlist[i]].animation.duration then
        spritelist[_spriteset][animationidlist[i]].animation.currentTime = spritelist[_spriteset][animationidlist[i]].animation.currentTime - spritelist[_spriteset][animationidlist[i]].animation.duration
        spritelist[_spriteset][animationidlist[i]].animation.looped = true
        if spritelist[_spriteset][animationidlist[i]].animation.loop then else
          spritelist[_spriteset][animationidlist[i]].animation.pause = true
        end
      end
    end
  end
end
