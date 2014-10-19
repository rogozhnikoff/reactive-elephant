`/** @jsx React.DOM */`

Desk = React.createClass
  propTypes:
    size: Object
    objects: Array

  getWindowSizePx: ->
    return {
      width: window.innerWidth
      height: window.innerHeight
    }
  handleResize: ->
    @setState wSizePx: @getWindowSizePx()

  componentWillMount: ->
    window.addEventListener('resize', @handleResize.bind(@))

  getInitialState: ->
    return {
      wSizePx: @getWindowSizePx()
    }

  getSquareSizePx: (size) ->
    {wSizePx} = @state

    # todo: ...
    return {
      width: 0
      height: 0
    }

  getTileSize: (screenSizePx, size) ->
    # todo: ...
    return {
      width: 0
      height: 0
    }

  getSizes: () ->
    {size} = @props

    squareSizePx = @getSquareSizePx(size)
    tileSizePx = @getTileSizePx(squareSizePx, size)

    return {
      square: squareSizePx
      tile: tileSizePx
    }

  render: ->
    {objects, size} = @props

    sizesPx = @getSizes()

    tiles = _(size.x * size.y).times((n)->
      coords = getCoordsFromPoint(n, size.x)
      object = getObjectByCoords(objects, coords) || null
      return `<Tile coords={coords} object={object} />`
    )

    return `
      <div style={prepareStylesToDom(squarePx)}>
        {tiles}
      </div>
    `