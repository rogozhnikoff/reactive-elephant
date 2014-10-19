`/** @jsx React.DOM */`
class Game
  pushCoords: ->

  onValue: ->


{renderComponent, createClass} = React

Game = createClass
  componentWillMount: ->
    @props.bind((data) ->
      @setState({dataTaken: yes})
      @setState(data)
    )

  getInitialState: ->
    return {
      dataTaken: no
    }

  render: ->
    return `<div>Loading...</div>` unless @state.dataTaken

    {desk, elephant, tasks} = @state

    return `
      <div>
        <Desk size={desk.size} objects={desk.objects} />
        <Elephant coords={elephant.coords} status={elephant.status} />
        <Tasks model={tasks} />
      </div>
    `

Desk = createClass
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

animals = objects.filter(type: 'animal').map (animal) ->
  return `<Animal img={animal.img} name={animal.name} coords={animal.coords} />`

blocks = objects.filter(type: 'block').map (block) ->
  return `<Block img={block.img} name={block.name} coords={block.coords} />`

Tile = createClass
  render: ->
    return `
    <div class='tile'>

    </div>
    `

Animal = createClass
  getInitialState: ->
    return {
      highlight: off
    }

  render: ->

Block = createClass
  getInitialState: ->
  render: ->

Elephant = createClass
  getInitialState: ->
  render: ->

Tasks = createClass
  getInitialState: ->
  render: ->

prepareStylesToDom = (styles) ->
  return _(styles).reduce((acc, value, key) ->
    if typeof value is 'number' and value isnt 0
      acc[key] = "#{value}px"
    return acc
  , {})

getCoordsFromPoint = (pos, sizeX) ->
  return {
    x: pos % sizeX
    y: Math.floor(pos / sizeX)
  }

getObjectByCoords = (objects, coords) ->
  return objects.find (object) ->
    return _.isEqual(object.coords, coords)
do ->
  game = new Game()
  renderComponent(`<Game bind={game.onValue} />`, document.getElementById('container'))