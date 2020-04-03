
--
--
--
-- collection
--
--
function createcollection()
  local temp_collection = {
    _type = _collection,
    -- indivual sprites group
    groups = {},
    -- save all of the sprites id
    spriten = {},
    -- length of the group
    length = 0,

    add = add,
    get = get,
    read = readgroup,
    wipe = wipe 
  }
-- return into array
return temp_collection
end
--
--
--  seteachvisible
--
--
function seteachvisible(group,bool)
  if group == nil then
    error("Function cannot format text",2)
  end
  for i=1,group.length do
    get(group,i).visible = bool
  end
end
--
--
--  groups
--
--
--
function creategroup()
  local temp_group = {
    _type = _group,
    -- save all of the sprites id
    spriten = {},
    -- length of the group
    length = 0,

    add = add,
    get = get,
    read = readgroup,
    wipe = wipe
  }
  -- return into array
  return temp_group
end
--
--
--   touch bond group
--
--
function isanygrouptouchboundsprite(group,sprite,ofx,ofy)
  local con = false
  for i=1,group.length do
    if istouchbound(sprite,get(group,i),ofx,ofy) then
     con =  true
    end
  end
  return con
end
--
--
--
-- touch group
--
function isanygrouptouchsprite(group,sprite)
  local con = false
  for i=1,group.length do
    sprite2 = get(group,i)
    if istouch(sprite2,sprite) then
     con =  true
    end
  end
  return con
end
--
-- add to group
--
--
function add(group,addition)
  -- if not exist the used createsprite
  -- else sprite does exist get its id

    --- add to a agroup
    if group._type == _group then
      --
      --  ACTUAL VALUES group = group
      --                addition = sprites


      -- if addition isnt defined
      if addition == nil then
        -- then add to  the spritelist
        group.spriten[#group.spriten+1] = #spritelist[_spriteset]
        print("ERROR GET ")
        print("  Group | Should have an identifer (added a nil sprite)")
        print("  Future versions will not have this")
      else
        -- else add the sprite instead
        group.spriten[#group.spriten+1] = addition.id
      end
      -- increase the length
      group.length = group.length + 1
      return;
    end


    -- add to a collection
    if group._type == _collection then
      --
      --  ACTUAL VALUES group = collection
      --                addition =  group

      if addition == nil then
        -- give error  message
        print("ERROR GET ")
        print("  Collection | Should have an identifer ")
        print("  return without addition")
        return
      else
        table.deepinsert(group.spriten,addition.spriten)
        group.length  = group.length + 1
        group.groups[#group.groups+1] = addition
      end
      return;
    end

    --
    if group._type ~= nil then
    print("ERROR GET ")
    print("  [0x" + group._type +"] | cannot use add()")
    else
      print("ERROR GET ")
      print("  [Unknown] | Could not find a type for this group ")
      print("  this may be nil.")
    end

end
--
--
-- remove
--
--
 function remove(group,num)
   table.remove(group.spriten,num)
   group.length = group.length -1
end
function wipe(group)

  if isempty(group) then
    print("ERROR GET ")
    print("  Group | The group doesnt exist ")
    print("  return with nil table")
    return {}
  end

  if group._type == _group then

    group.spriten = {}
    group.length = 0

  end

  if group._type == _collection then
    group.spriten = {}
    group.length = 0
    group.groups = {}

  end

end
function get(group,num)
  if num == nil then num = 1; end
  -- check if the type of the get is a grou[]
  if isempty(group) then
    print("ERROR GET ")
    print("  Group | The group doesnt exist ")
    print("  return with nil table")
    return {}
  end
  if group._type == _group then
    -- errors need to be updated
    if isempty(group.spriten[num]) then
      print("ERROR GET ")
      print("  Group | The value " .. num .. " is above the groups length which is" .. group.length)
      print("  return with nil table")
      return {}
    end
    -- return acording to its spritenumbers (pointers)
    return spritelist[_spriteset][group.spriten[num]]
  end
  -- for collections
  if group._type == _collection then
    if isempty(group.groups[num]) then
      print("ERROR GET ")
      print("  Collection | The value " .. num .. " is above the groups length which is" .. group.length)
      print("  return with nil table")
      return {}
    end
    return group.groups[num]
  end
end
--
--   getfromid
--
--
function getfromid(id)
 return  spritelist[_spriteset][id]
end

function readgroup(group,readfunc)
  if group.length == nil then
    print("fukk")
    return;
  end
  for i=1,group.length do
    _storedsprite = get(group,i)
    if _storedsprite ~= nil then readfunc(_storedsprite) end
  end
end
