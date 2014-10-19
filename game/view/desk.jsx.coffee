`/** @jsx React.DOM */`

Desk = React.createClass
  propTypes:
    size: Object
    objects: Array
    shadows: Array
    deskPx: Object
    tilePx: Object

  getInitialState: ->
    return {
      wSizePx: @getWindowSizePx()
      shadows: null
    }

  createTile: (n) ->
    {objects, size, tilePx} = @props
    {shadows} = @states

    tyleCoords = __.getCoordsFromPoint(n, size.x)
    object = __.getObjectByCoords(objects, tyleCoords)

#    shadowCoords = do ->
#      if _.isEqual(tyleCoords, elephantCoords)
#        return elephantCoords
#      else if _.isObject(shadow)
#        return _.pluck(shadow, 'x', 'y').value()
#      else
#        return shadow

#    shadow.type ?= 'current' if shadowCoords?
#    highlight = shadow.type if shadowCoords?

    return `<Tile coords={tyleCoords} object={object} size={sizesPx.tile} highlight={highlight} />`

  render: ->
    {size, deskPx} = @props

    tiles = _(size.x * size.y).times(@createTile.bind(@))

    return `
    <div style={deskPx}>{tiles}</div>
    `