lspr.error = {}
lspr.error.throws = {"get"}
lspr.error.respones = {"Get([self:group],number)"}
function lspr.dispconflicterror(place,thing,line1,line2)
  if place == nil then place =  "" end
  if thing == nil then place =  "" end
  if line1 == nil then line1 =  "" end
  if line2 == nil then line2 =  "" end

  print("ERROR " .. place)
  print("  " .. thing .. " | " .. line1)
  print("  " .. line2)

  error(place .. thing .. " | " .. line1 .. line2)
end
function lspr.dispconflictwarning(place,thing,line1,line2)
  if place == nil then place =  "" end
  if thing == nil then place =  "" end
  if line1 == nil then line1 =  "" end
  if line2 == nil then line2 =  "" end

  print("WARNING " .. place)
  print("  " .. thing .. " | " .. line1)
  print("  " .. line2)
end
function dologs()
end
