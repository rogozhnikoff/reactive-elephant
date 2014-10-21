__ = {}

__.prepareStylesToDom = (styles) ->
  return _(styles).reduce((acc, value, key) ->
    if typeof value is 'number' and value isnt 0
      acc[key] = "#{value}px"
    return acc
  , {})

__.getCoordsFromPoint = (pos, sizeX) ->
  return [
      pos % sizeX
      Math.floor(pos / sizeX)
  ]

__.getObjectByCoords = (objects, coords) ->
  return objects.find (object) ->
    return _.isEqual(object.coords, coords)

__.getShadows = ({left, top, long}) ->
  LEFT = Math.floor(left / long)
  TOP = Math.floor(top / long)

  LEFTp = 1 - (left % long) / long
  TOPp = 1 - (top % long) / long

  return _.sortBy([
    {
      position: [LEFT, TOP]
      percent: LEFTp * TOPp
    }
    {
      position: [LEFT + 1, TOP]
      percent: (1 - LEFTp) * TOPp
    }
    {
      position: [LEFT, TOP + 1]
      percent: LEFTp * (1 - TOPp)
    }
    {
      position: [LEFT + 1, TOP + 1]
      percent: (1 - LEFTp) * (1 - TOPp)
    }
  ], 'percent').value()


__.getRelativePosition = (child, parent) ->
  return {
    top: child.offsetTop - parent.offsetTop
    left: child.offsetLeft - parent.offsetLeft
  }
