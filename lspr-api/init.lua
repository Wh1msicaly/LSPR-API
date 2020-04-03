-- declare needed
lspr = {}

-- require all files
local addsuffix = "require ->"
local lsprapibasename = "lspr"
--[[require "Moduleload"                                                                                                                                                      ]]function domodulerequire(stem,module,basename)domoduleprint(basename,module);require (stem .. module)end;function domoduleprint(basename,module)print(addsuffix .. " " .. basename .. "[" .. module.."]");end;function readmodulelist(modules,stem,basename)for i=1,#modules do domodulerequire(stem,modules[i],"lspr")end;end
local stem = "lspr-api."
print("NON-LSPR Libaries")
domoduleprint("bump","bump")
domoduleprint("moonshine","moonshine")
domoduleprint("inspect","inspect")
moonshine = require 'lspr-api.moonshine'bump = require "lspr-api.bump"inspect = require "lspr-api.inspect"
print("LSPR Libaries")
local modules = {"tools","drawtypes","shader","sprites","tempsprite","camera",
                 "error","physics","group-collection","animations","view","scape","coll",
                 "timer","velocity","lspr-api"}
readmodulelist(modules,stem,lsprapibasename)

local stem = "lspr-api.special."
local modules = {"particle"}
readmodulelist(modules,stem,lsprapibasename)
