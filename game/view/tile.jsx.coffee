`/** @jsx React.DOM */`
@Tile = React.createClass
  propTypes:
    tilePx: React.PropTypes.number
    coords: React.PropTypes.arrayOfNumber
    highlight: React.PropTypes.shape
      position: React.PropTypes.arrayOfNumber
      percent: React.PropTypes.number

    object: React.PropTypes.shape
      type: React.PropTypes.oneOf([
        'animal'
        'block'
      ])
      img: React.PropTypes.string
      name: React.PropTypes.string
      coords: React.PropTypes.arrayOfNumber

  getInitialState: ->
    return {
      highlight: off,
      hasObject: @props.object?
      isHover: no
    }

  classSet: ->
    return React.addons.classSet
      'tile': true
      'tile-filled': @state.hasObject
      'tile-empty': not @state.hasObject
      'is-highlight': @state.highlight?

  getStyles: ->
    {tilePx, coords, highlight} = @props
    {isHover} = @state

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
    {object} = @props
    return unless object?

    classSet = React.addons.classSet
      'object': yes
      'object-animal': object.type is 'animal'
      'object-block': object.type is 'block'

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