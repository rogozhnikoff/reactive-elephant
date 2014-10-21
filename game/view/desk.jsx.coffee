`/** @jsx React.DOM */`

Desk = React.createClass
  propTypes:
    size: Array
    objects: Array
    deskPx: Object
    tilePx: Object

  getInitialState: ->
    return {
      shadows: []
    }

  createTile: (n) ->
    {objects, size, tilePx} = @props
    {shadows} = @states

    tyleCoords = __.getCoordsFromPoint(n, size[0])
    highlight = shadows.find (shadow) -> _.isEqual(shadow.position, tyleCoords)
    object = __.getObjectByCoords(objects, tyleCoords)

    return `<Tile
        tilePx={tilePx}
        coords={tyleCoords}
        object={object}
        highlight={highlight}
      />`

  render: ->
    {size, deskPx} = @props

    tiles = _(size[0] * size[1]).times(@createTile.bind(@))

    return `<div style={deskPx}>
        {tiles}
      </div>`