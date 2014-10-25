`/** @jsx React.DOM */`

@Desk = React.createClass
  propTypes:
    size: React.PropTypes.array
    objects: React.PropTypes.array
    deskPx: React.PropTypes.object
    tilePx: React.PropTypes.number

  getInitialState: ->
    return {
      shadows: []
    }

  # todo: it must be cached
  getPosition: ->
    {offsetTop, offsetLeft} = @getDOMNode()
    return {offsetTop, offsetLeft}

  createTile: (n) ->
    {objects, size, tilePx} = @props
    {shadows} = @state

    tyleCoords = __.getCoordsFromPoint(n, size[0])
    highlight = _(shadows).find((shadow) -> _.isEqual(shadow.position, tyleCoords))
    object = __.getObjectByCoords(objects, tyleCoords)

    return `<Tile
      ref={'tile-' + n}
      tilePx={tilePx}
      coords={tyleCoords}
      object={object}
      highlight={highlight}
      />`

  classSet: ->
    React.addons.classSet
      'desk': yes

  render: ->
    {size, deskPx} = @props

    tiles = _(size[0] * size[1]).times(@createTile.bind(@)).value()

    return `<div style={deskPx} className={this.classSet()}>
        {tiles}
      </div>`