`/** @jsx React.DOM */`

@Game = React.createClass
  propTypes:
    bindTo: React.PropTypes.func
    push: React.PropTypes.func

  componentWillMount: ->
    @props.bindTo((data) =>
      state = _.extend({}, data, {dataTaken: yes})
      @setState(state)
    )

    window.addEventListener('resize', @handleResize.bind(@))

    return @

  getInitialState: ->
    return {
      dataTaken: no
      wSizePx: @getWindowSizePx()
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

  dragElephant: ({type, elephantOffset}) ->
    # should we cached this params?
    tilePx = @getSizesPx().tile

    position = __.getRelativePosition
      parent: @refs.desk.getPosition()
      child: elephantOffset

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


    return `<div className={this.classSet()}>
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

do ->
  core = new Core()
  React.renderComponent(`<Game bindTo={core.onValue} push={core.pushCoords} />`, document.getElementById('game-container'))