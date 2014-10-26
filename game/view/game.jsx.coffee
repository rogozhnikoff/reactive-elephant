`/** @jsx React.DOM */`

@Game = React.createClass
  propTypes:
    bindTo: React.PropTypes.func
    push: React.PropTypes.func

  componentWillMount: ->
    @props.bindTo((data) => # ownInitialState
      @setState _.extend {}, data, {
        dataTaken: yes
      }
    )

    window.addEventListener('resize', @handleResize.bind(@))

    return @

  getSizesPx: _.memoize(({size, wSizePx}) ->
    tileSizePx = Math.min(wSizePx.height / size[1], wSizePx.width / size[0])

    return {
      desk:
        width: tileSizePx * size[0]
        height: tileSizePx * size[1]

      tile: tileSizePx
    }
  , ->
    # theoretically, is's must be fast prevent to compute sizes, based on window-size
    return btoa(JSON.stringify(arguments)) # base64 hash of arguments, for key to memoize return
  )

  getInitialState: ->
    return {
      dataTaken: no
      wSizePx: @getWindowSizePx()
    }


  getWindowSizePx: ->
    return {
      width: window.innerWidth
      height: window.innerHeight
    }

  handleResize: ->
    @setState
      wSizePx: @getWindowSizePx()
    return @

  dragElephant: _.throttle(({type, elephantOffset}) ->
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

    if type is 'end'
      @props.push {
        position: ''
        newPosition: shadows[0].position
        task: ''
      }

    return @
  , 1000 / 25)

  classSet: ->
    return React.addons.classSet
      'container': yes

  render: ->
    return `<div>Loading...</div>` unless @state.dataTaken
    {desk, elephant, tasks, size, wSizePx} = @state

    sizes = @getSizesPx {size, wSizePx}

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