


#LSPR API
[![Documentation Status](https://readthedocs.org/projects/demoidcheck/badge/?version=latest)](https://demoidcheck.readthedocs.io/en/latest/?badge=latest)

Lspr-api is a basic api used for creating game by zr0-games colloberators.
Open sourcing is good regardless of quality of code,  just to help ourselfs out.

##Lspr-api libaries used

[Bump](https://github.com/kikito/bump.lua) 
A collision detection library for Lua
[Inspect](https://github.com/kikito/inspect.lua) 
Human-readable representation of Lua tables https://github.com/kikito/inspect.lua
[Moonshine](https://github.com/vrld/moonshine) 
Postprocessing effect repository for LÖVE
[Simplescale](https://github.com/tomlum/simpleScale) 
A simple library for scaling games made in love2d to any screen size.
<br>
--------
> Quick directory

[TOCM]

<br>
How to get lspr-api working in your project

Extract the folder to the same directory as your main.lua


Main.lua :
```lua
 function love.load()
 	Require "lspr-api"
 end,
```

Thats it! it should work now!

for baisc shapes do  and runing exmaples pelase do. in load()
```lua
 lspr.getdefaultshapes()
 lsworld.dorender = true
 lsworld.compatablitymode = true
```

**Table of Contents**
<br>
Need to find something?  Look here

[TOC]
## Consepts 
<br>
###Addition

an addition is basically a value that can be either a group or a sprite,

the function can detect the difference so there is no need to read the group 

<br>
###Drawtype
a draw type is basically just the method you use to draw the sprite

see drawing [example-drawdebugshapes](#draw debug shapes around sprites)  for a example of a drawtype

you essentially just read a group or the entire world and draw accordingly.

this allows for other libaries to be used without having to edit lspr-code 
this is the manual stuff that i was talking about.

information thats necessary for a drawtype is what shapes are for.
<br>
###Game Size vs Window Size 
Not all screensizes all the same lets say we render, a point to 250,250 on a 300x300 screen. It looks fine until we open the game on a  a 200x200 screen and the point is now  cropped.

We have to make a game where the gamesize is always 300x300, 

And the windowsize scales up or down to match that,

LSPR.simplescale will work for that
<br>
##  How to begin 
### Step 1 :  including lspr-api
first require lspr-api 
 
```lua
	function love.load 
		require "lspr-api"
	end
```
<br>
setup lsworld to your desired settings, this is important because it will determine
your future functionality and can limit it.
 
```lua
	function love.load 
		require "lspr-api"
		lsworld.dorender = true
		lsworld.compatablitymode = false 
	end
```
<br>

### Step 2 :  creating drawtype then rendering sprite
create a drawtype or some type of render method 
 
```lua
	function love.load 
		 require "lspr-api"
		 lsworld.dorender = true
		 lsworld.compatablitymode = false 
		
		 addshape("arc",{
    	 ondraw = function(sprite,camera)
         love.graphics.arc(sprite.mode, sprite.position.x, sprite.position.y, sprite.radius, sprite.angle1, sprite.angle2)
   		 end,
    	 -- radius
    	 radius = 5,
    	 width = 20,
    	 height = 20,
    	 -- starting angles
    	 angle1 = math.rad(0),
    	 angle2 = math.rad(0),
    	 mode = "fill",
  	})
		
	end

```
<br>
create a sprite, then bam! you made something appear on the screen
 
```lua
  -- create sprite with drawtype "arc"
  arc = createsprite(100,100,"arc")
  arc.radius = 10
  arc.velocity.x = 3
```
<br>

##  Examples
### draw debug shapes around sprites 
 this is not only example how to create a drawtype it is also a way of being able to view 
  ta  for sprites.
```lua
  -- read world
  lsworld:read(function(sprite)
    love.graphics.push()
    love.graphics.setColor(0, 1, 0, 0.5)
	-- attempt to use as global values as possible to prevent error (make sure all shaeps have width and height
    love.graphics.rectangle("line", sprite.position.x, sprite.position.y, sprite.width, sprite.height)
    love.graphics.setFont(_font)
    love.graphics.print(sprite.shape ,sprite.position.x,sprite.position.y)
    love.graphics.pop()
    love.graphics.reset()
  end)
```
##  Variables
 ###Vector 
A value that consist of an x and a y 

equal to {x,y}
<br>
 ###lspr 
  lspr values that are not actually stored but more of an example
  
| lspr          | Meaning                                           |
|---------------|---------------------------------------------------|
| internalvalue | A peferably unmodified value that lspr-api uses.  |
 ###lsworld 
Changes the way lspr-api works globally. 

| Lsworld            | Meaning                                                                   |
|--------------------|---------------------------------------------------------------------------|
| compatabilitymode  | a boolean which makes old code runnable with defaultdrawtypes.            |
| lock               | Lock to that pixel only works withlspr.docamera()                         |
| ticks              | How many frames sprites have been updated                                 |
| method : Read()    | read just like group:read(), but instead its all sprites in the spriteset |
 ###Camera
 camera values 
	
| Lsworld            | Meaning                                                                   |
|--------------------|---------------------------------------------------------------------------|
| compatabilitymode  | a boolean which makes old code runnable with defaultdrawtypes.            |
| lock               | Lock to that pixel only works withlspr.docamera()                         |
| ticks              | How many frames sprites have been updated                                 |
| method : Read()    | read just like group:read(), but instead its all sprites in the spriteset |
 ###Timer 
 
this is very useful for crafting particle sequenceing excertra whatever you need a timer for,

| Timer   | Meaning                                                                                                 |
|---------|---------------------------------------------------------------------------------------------------------|
| timer   | The actual value of the timer as it ticks down                                                          |
| active  | this happens when the timer is done, if it doesnt loop <br>then this value will be active until it does |
| loop    | Loop the value once the timer has ended                                                                 |
| Running | the timer is reaching active                                                                            |
| enabled | the timer ticks down                                                                                    |
| method  | see timer:reset()                                                                                       |
 ###Sprite
Sprite is essentially just a point with infromation on how to draw to the (drawtype), 
the name doesnt really reflect its reality,

The sprite has a couple default values

####Sprite info table.
| Sprite          | Meaning                                                                                                                                                                                                                              |
|-----------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Position.(X,Y)  | Location of the sprite, can be modified directly<br>or set with vec(),                                                                                                                                                               |
| Velocity.(X,Y)  | Velocity is the current motion moved every frame, <br>modified by deltatime already.                                                                                                                                                 |
| Last.(X,Y)      | Last Position, used for collisions and callbacks.                                                                                                                                                                                    |
| Shape           | Instruction to drawtype, or render seperating diffrent types of sprites.<br>they can be ignored or used directly with LSPR-API to automatically complete<br>rendering.  This value is just a string but to create one see newShape() |
| id              | Index location                                                                                                                                                                                                                       |
| visible         | To be rendered (will ignore lsworld:read() )                                                                                                                                                                                         |
| Internal Values | _reserved ( phys _ particle compatability ) lsworld ignore                                                                                                                                                                           |

 <br>
 ###Shape
 a shape essentialy tells the sprite how to reach the  drawtype,
 
 These are not actual value names but still explain parameter values,
 
 they are not stored in the same location and must be obtained with get
 commands, 
####Shape info table.
 | Shape        | Meaning                                                                                                            |
|--------------|--------------------------------------------------------------------------------------------------------------------|
| shapename    | What to refer to the shape as                                                                                      |
| contents     | an object merged with the sprite so that those values<br>can be modified abd used with the drawtype for rendering. |
| drawfunction | used by default shapes depracted unwriteable                                                                                   |

do not! and i repeat do not fucking make complex shapes just rendering
not functionallity make another parent object for that.
 <br>
 ###Group
 
 holds a ton of sprites for shared functionality or creation of a large amount.
####Group info table.
| Group  | Meaning                                                    |
|---------|------------------------------------------------------------|
| length  | How many sprites good for not going over on<br> [group:get()](#group:get)  |
| methods | see [group:read()](#group:read) [group:add()](#group:add) etc,                              |

 <br>
 ###Collection

  actually holds groups sounds dumbs but actually very useful.
 ####Collection info table.
| Collection  | Meaning                                                    |
|---------|------------------------------------------------------------|
| methods | see collection:read collection:add etc,                              |

 <br>

<br><br><br>
## Functions 

some functions are included here as compability is converted 
<br><br>
### Sprite module 
<br>

####Createsprite
 `createsprite( x , y , shape )`

 Creates a sprite object,  defaults shape to _object

returns [sprite](#Sprite)
<br>
####Vec
 `vec( x , y )`

makes a  .(x,y) value see  [spritetable](#Sprite info table.)

returns [vector](#Vector)
<br>
####Getspriteorginxy
  `getspriteorginxy( sprite  , place )`

Get orgin of sprite return as the draw final draw postion  
 
returns [vector](#Vector)
<br>
####Getspriteorgin
  `getspriteorgin( sprite  , place )`

Get orgin of sprite return as values instead of setting
 
returns [vector](#Vector) 
<br>
####Autosizesprite
  `autosizesprite( sprite )`

 Automatically size sprite based on image
 
 modifies [sprite](#Sprite)
sprite.width 
sprite.height
<br>  
####Copysprite
  `copysprite( sprite )`

makes copy of sprite, that does not point to eachother
 
returns [sprite](#Sprite)
<br>  
### Velocity
<br>
####veloslide
  `veloslide( sprite , decreasement )`

Slowly halts velocity 
 
modfies [sprite](#Sprite)
<br>  
####moveveloindirection
  `moveveloindirection( sprite , speed , angle )`

 Sets  velocity in the direction of an angle
 
modfies [sprite](#Sprite)
<br>  
####multmoveveloindirection
  `multmoveveloindirection( sprite , speed , angle )`

 Adds onto current  velocity in the direction of an angle
 
modifies [sprite](#Sprite)
<br>  


### Numbers 

####Pointto
  `pointto( sprite , x , y )`

sets rotation value of sprite to direction
 
modifies [sprite](#Sprite)
<br>  
####getanglevalues
  `getanglevalues( angle , speed )`

gets a vector for moving in that direction
 
returns [vector](#Vector)
<br>  
####Range
  `range( value , minimum , maximum  )`

maintains value within range
 
return Number
<br>  
####Round (real round not ciel)
`round(  value )`

 rounds value
 
returns number
<br>  
### Timer 

####createtimer
  ` createtimer( time )`

 Creates a timer
 
returns [timer](#Timer)
<br> 
####timer:reset()
  `timer:reset()`

resets the timers value to default
#####create timer and reset when finished ( you could just use loop)
```lua 
 timer = createtimer( 10 )
	
	update  = function() 
		if timer.active then 
			timer:reset()
		end
	end
```
although timer.loop bool does the same thing this is just an example
modfies [timer](#Timer)
<br> 

### Animation
REQUIRES ANIMATION DRAWTYPE TO WORK steal source code to modify.
### Camera
####createcamera
  `createcamera()`

creates a camera
 
returns [camera](#Camera)
<br>  
####hidefromcamera
  `hidefromcamera( camera , additon )`

see [addition](#addition)
adds to the cameras hiddenlist 
 
modfies [lspr.internalvalue](#lspr)
<br>  
####setcamera
  `setcamera(camera)`

sets the current camera retrived on getcamera() 
or default rendering. 
 
modfies [lspr.internalvalue](#lspr)
<br>  
####getcamera
  `getcamera(  )`

gets the currently loaded camera
 
returns [camera](#Camera)
<br>  
### View 

### Scapes

### Physics
Conversion needed
### Particle 
Conversion needed
### General 

round()
isempty()


### Pixel

<br>  
### Group/Collection 
<br>
####Creategroup
  `creategroup()`

 creates group 
 
 returns [group](#Group)
<br>  

#### group:add
`group:add( sprite )`

Adds sprite to group
<br>

 modifes [sprites](#Sprite) in [group](#Group)
 and indexes  [sprites](#Sprite) 

#####Modifing sprite before adding to group 
```lua
local vaporcloud = creategroup()

for i=1,10 do
  -- make sprite
  local sprite = createsprite( 0,i * 100 , "vapor" )
  sprite.width = 100
  sprite.height = 100 
  sprite.thickness = 0.4
  
  vaporcloud:add(sprite)
end
```
baiscally local the sprite becasue the sprite can be acessed later when read.
<br>
#####Adding sprite to group from existing variable
```lua
-- create sprite
player = createsprite(100,groundy , "image")
-- create group
local world = creategroup()
-- add to group 
world:add(player)
-- add existing sprites over
blocks:read(function(sprite)
	world:add(sprite)
end)
-- modify after adding 
player.position.x = player.position.x + 1

```
regardles of adding to group if a variable pointer is aviable it can still be modifed
<br>
#### group:read
`group:read( function )`

Reads sprite inside group
<br>

 modifes [sprites](#Sprite) in [group](#Group)
 and indexes  [sprites](#Sprite) 
 
  ##### Reading values from group using read
```lua
  group:read(function(sprite)
    -- modify sprite 
	sprite.position = vec(100,100)
  end)
```

Goes one by one and modifes all sprites that have been added to the group
<br>
#### group:get
`group:get( number )`

Gets index of sprite from group
<br>

 modifes [sprites](#Sprite) in [group](#Group)
 and indexes  [sprites](#Sprite) 

#####Getting sprite from group by index number
```lua
 local group = creategroup()
 
 group:add(createsprite())
 
 local sprite = group:get(1)
```
this is overall good for things like bullets when you only want to get one at a time.



<br>



<br>
#### Createcollection
  `createcollection()`
  
creaters collection

 returns [collection](#Collection) 
 
<br>  
#### collection:add
`collection:add( group )`

adds group to collection
<br>

 modifes [groups](#Group) in [collection](#Collection)
 and indexes  [sprites](#Sprite)  , [groups](#Group) 

 ##### Adding group to collection
```lua
local clouds = creategroup()
local birds = creategroup()

local sky = createcollection() 

sky:add(clouds)
sky:add(birds)
```
very simular to adding to groups expect when read returns other groups
<br>  
#### collection:read
`collection:read ( function )`

adds group to collection
<br>

 modifes [groups](#Group) in [collection](#Collection)
 and indexes  [sprites](#Sprite)  , [groups](#Group) 

 ##### reading groups within collection
```lua
collection:read(function(group)
	group:read(function(sprite)
	-- modify sprite
	sprite.velocity = vec(30,2)
	end)
end)

```

#### collection:get
`collection:get ( number )`

GETS SPRITEN FROMINDEX ID (DEPRACTED order system_
)
<br>
 ### shapes
<br>
####lspr.addshape
  `lspr.addshape( shapename , contents ) `

see [shapeinfo](#Shape) to understand clearly, creates shape content if dorender enabled
must have a ondraw function.

`contents = {}` `shapname = string`
 
modifies [shapes](#Shape)
<br>  







####lspr.getcontents
  `lspr.getcontents( shape )`

gets contents from shape
 
returns [shape.contents](#Shape)
<br>  


####lspr.getdrawfunction
  `lspr.getdrawfunction( shape )`

gets drawfunction from shape

ondraw functions will not show up here!!!
depracted storage of drawfunction will be removed

see [shapeinfo](#Shape)
 
returns [shape.drawfunction](#Shape)
<br>  




####lspr.addcontentstoshape
  `lspr.addcontentstoshape( shape , content )`

merges addition content to shape

see [shapeinfo](#Shape)
 
returns [sprite](#Sprite)
<br>  



####lspr.docamera
  `lspr.docamera( camera , sprite )`

 does the same camera as the default drawtypes
 
method [drawtype](#Drawtype)
<br>  







####file
  ` (  )`

 cib
 
returns [sprite](#Sprite)
<br>  

