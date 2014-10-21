`/** @jsx React.DOM */`

Game = React.createClass
  propTypes:
    bind: React.PropTypes.func
    push: React.PropTypes.func

  componentWillMount: ->
    @props.bindTo((data) =>
      @setState _.extend({}, data, {dataTaken: yes})
    )

    window.addEventListener('resize', @handleResize.bind(@))

    return @

  getInitialState: ->
    return {
      dataTaken: no
      wSizePx: @getWindowSizePx()

      # fixture
      elephant: {
        coords: [0, 1]
        status: ''
      }
      desk: {
        size: [0, 1]
        objects: [
          {
            type: 'animal' || 'block'
            img: '<img />'
            name: ''
            coords: [0, 1]
          }
          '...'
        ]
      }
      tasks: [
        {
          type: 'right'
          visited: true
          current: false
        }
        '...'
      ]

    }

  getSizesPx: () ->
    {size} = @state.desk
    {wSizePx} = @state

    tileSizePx = Math.min(wSizePx.height / size[1], wSizePx.width / size[0])

    return {
      desk:
        width: tileSizePx * size[0]
        height: tileSizePx * size[1]

      tile: tileSizePx
    }

  getWindowSizePx: ->
    return {
      width: window.innerWidth
      height: window.innerHeight
    }

  handleResize: ->
    @setState wSizePx: @getWindowSizePx()
    return @

  dragElephant: ({type, elephantEl}) ->
    # should we cached this params?
    tilePx = @getSizes().tile
    position = __.getRelativePosition(elephantEl, @refs.desk.getDOMNode())
    shadows = __.getShadows
      left: position.left
      top: position.top
      long: tilePx

    @refs.desk.setState({shadows})

    @props.push shadows[0].position if type is 'end'

    return @

  classSet: ->
    return React.addons.classSet
      'container': yes

  render: ->
    return `<div>Loading...</div>` unless @state.dataTaken

    {desk, elephant, tasks} = @state
    sizesPx = @getSizesPx()

    return `<div class={this.classSet()}>

        <Desk
          ref='desk'
          size={desk.size}
          objects={desk.objects}
          deskPx={sizesPx.desk}
          tilePx={sizesPx.tile}
          />

        <Elephant
          coords={elephant.coords}
          status={elephant.status}
          sizePx={sizesPx.tile}
          dragElephant={this.dragElephant}
          />

        <Tasks
         model={tasks}
         />

      </div>`




class Game
  onValue: -> console.log('onValue')
  pushCoords: -> console.log('pushCoords')

do ->
  game = new Game()
  React.renderComponent(`<Game bindTo={game.onValue} push={game.pushCoords} />`, document.getElementById('game-container'))