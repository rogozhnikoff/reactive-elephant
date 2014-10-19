`/** @jsx React.DOM */`

### где-то там...
class Game
  pushCoords: ->
  onValue: ->
###

Game = React.createClass
  propTypes:
    bind: Function

  componentWillMount: ->
    @props.bind((data) ->
      state = _.extend({}, data, {dataTaken: yes})
      @setState(state)
    )

    window.addEventListener('resize', @handleResize.bind(@))

    return @

  getInitialState: ->
    return {
      dataTaken: no
      shadowPosition: null
      wSizePx: @getWindowSizePx()
    }

  getSizes: () ->
    {size} = @state.desk
    {wSizePx} = @state

    tileSizePx = Math.min(wSizePx.height / size.y, wSizePx.width / size.x)

    deskSizePx =
      width: tileSizePx * size.x
      height: tileSizePx * size.y

    return {
      desk: deskSizePx
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

  dragElephant: ({type, position}) ->
    # should we cached this params?
    tilePx = @getSizes().tile

    @refs.desk.setState
      shadows: __.getShadows
        left: position.left
        top: position.top
        long: tilePx

    return @

  getPositionOfElephant: ->
    # @enh: @refs.desk.getDOMNode() can be cached, like wSizePx
    return __.getRelativePosition(@refs.elephant.getDOMNode(), @refs.desk.getDOMNode())

  render: ->
    return `<div>Loading...</div>` unless @state.dataTaken

    {desk, elephant, tasks, shadowPosition, shadows} = @state
    sizesPx = @getSizes()

    return `
      <div>

        <Desk
          ref='desk'
          size={desk.size}
          objects={desk.objects}
          shadows={shadows}
          deskPx={sizesPx.desk}
          tilePx={sizesPx.tile}
          />

        <Elephant
          ref='elephant'
          coords={elephant.coords}
          status={elephant.status}
          sizePx={sizesPx.tile}
          dragElephant={this.dragElephant}
          getPositionOfElephant={this.getPositionOfElephant}
          />

        <Tasks ref='tasks' model={tasks} />

      </div>
    `



do ->
  game = new Game()
  React.renderComponent(`<Game bind={game.onValue} push={game.pushCoords} />`, document.getElementById('container'))