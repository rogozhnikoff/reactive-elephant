`/** @jsx React.DOM */`
@Tile = React.createClass
  propTypes:
    tilePx: React.PropTypes.number
    sizeDeskX: React.PropTypes.number
    shadows: React.PropTypes.array
    highlight: React.PropTypes.shape
      position: React.PropTypes.arrayOfNumber
      percent: React.PropTypes.number

    getObject: React.PropTypes.func
    getShadow: React.PropTypes.func

  getInitialState: ->
    return {
      highlight: off,
      hasObject: @props.object?
      isHover: no
    }

  componentWillMount: ->
    {key, sizeDeskX} = @props

    console.log '123', __.getCoordsFromPoint(key, sizeDeskX)
    @setState
      coords: __.getCoordsFromPoint(key, sizeDeskX)

  componentWillReceiveProps: ->
#    @setState:
#      highlight:

  classSet: ->
    return React.addons.classSet
      'tile': true
      'tile-filled': @state.hasObject
      'tile-empty': not @state.hasObject
      'is-highlight': @state.highlight?

  getStyles: ->
    {tilePx, highlight} = @props
    {isHover, coords} = @state

    highlight = @props.getShadow({coords})

    return {
      left: coords[0] * tilePx
      top: coords[1] * tilePx
      width: tilePx
      height: tilePx
      borderColor: if isHover then 'red' else 'black'
      backgroundColor: if highlight? then "rgba(255, 192, 203, #{highlight.percent})" else null
    }

  onMouseEnter: (ev) ->
    @setState
      isHover: yes

  onMouseLeave: (ev) ->
    @setState
      isHover: no

  renderObject: ->
    {isHover, coords} = @state
    object = @props.getObject({coords})
    return unless object?

    classSet = React.addons.classSet
      'object': yes
      'object-animal': object.type is 'animal'
      'object-block': object.type is 'block'
      'object-hover': isHover

    img = "static/image/object/#{object.img || 'empty'}.gif"

    return `<img
        className={classSet}
        alt={object.name}
        src={img}
        />`

  render: ->
    object = @renderObject() || ''

    return `<div
        className={this.classSet()}
        style={this.getStyles()}
        onMouseEnter={this.onMouseEnter}
        onMouseLeave={this.onMouseLeave}
      >
      {object}
    </div>`