lspr.info = {
  version = "0.80d-20",
  fix ="Fix of collection and close to complete atom snippets",
}
print("LSPR | v" .. lspr.info.version .. " running.")
print("   " .. lspr.info.fix)
--
--
--
--
--        MADE BY TH3RON , AKUBUIRO
--
--
sprite_center , sprite_lefttop , sprite_righttop , sprite_leftbottom ,
sprite_rightbotton , correct_width , _group , _collection , _sprite , _phys , _nonphys , _particle
= 0x1, 0x2 , 0x3 , 0x4 , 0x5 , 0x6 , 0x7 , 0x8 , 0x9 , 0x10 , 0x11 , 0x12
spritelist , animationidlist , tempspritelist , timerlist , viewlist , worldlist , particlesystemlist
= {{}} ,{} , {{}} ,{} ,{},{},{}
_gamecamera , _gameview , _gameworld , _meter , _font =
{} , {} , {} , 50 , love.graphics.newFont("lspr-api/font.ttf",10)
lsworld = {
  ticks = 0,
  culling = false,
  lock = 1,
  dorender = false,
  read = getallsprites,
  compatabilitymode = true,
}
print("========")
print(lspr)
print(lsworld)
local camera = createcamera()
local view =  createview(love.graphics.getWidth()*2,love.graphics.getHeight()*2,camera)
_gamecamera = camera
_gameview = view
love.physics.setMeter(_meter)
--
--
--
-- updateall
--
--
function updateall(dt)
  updatesprites(dt)
  updateanimations(dt)
  updatetimers(dt)
  updateworlds(dt)
end
