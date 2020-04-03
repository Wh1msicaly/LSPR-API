function createcamera()
  return  {
    zoom = 1,
    x = 0,
    y = 0,
    enabletext = true,
    hidden = {},
    useshaders = true,
    hidefromcamera = hidefromcamera,
    orgin = {
      x = 0,
      y = 0,
    }
  }
end
function hidefromcamera(camera,add)
  if add._type == _sprite then
    camera.hidden[#camera.hidden+1] = add.id
  end
  if add._type == _group then
    for i=1,add.length do
      camera.hidden[#camera.hidden+1] = get(add,i).id
    end
  end
end
function setcamera(camera)
  _gamecamera = camera
end
function getcamera()
  return _gamecamera
end
function cameraval(var,camera)
  return var * (1 / camera.zoom)
end
