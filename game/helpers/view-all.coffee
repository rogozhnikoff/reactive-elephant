__ ?= {}

__.prepareStylesToDom = (styles) ->
  return _(styles).reduce((acc, value, key) ->
    if typeof value is 'number' and value isnt 0
      acc[key] = "#{value}px"
    return acc
  , {})

__.getCoordsFromPoint = (pos, sizeX) ->
  return {
  x: pos % sizeX
  y: Math.floor(pos / sizeX)
  }

__.getObjectByCoords = (objects, coords) ->
  return objects.find (object) ->
    return _.isEqual(object.coords, coords)
