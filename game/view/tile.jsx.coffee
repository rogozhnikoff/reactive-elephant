`/** @jsx React.DOM */`


Tile = React.createClass
  propTypes:
    tilePx: Number
    coords: React.PropTypes.arrayOf(Number)
    highlight: React.PropTypes.shape
      position: React.PropTypes.arrayOf(Number)
      percent: Number

    object: React.PropTypes.shape
      type: React.PropTypes.oneOf([
        'animal'
        'block'
      ])
      img: String
      name: String
      coords: React.PropTypes.arrayOf(Number)

  getInitialState: ->
    return {
      highlight: off,
      hasObject: @props.object?
    }

  classSet: ->
    return React.addons.classSet
      'tile': true
      'tile-filled': @state.hasObject
      'tile-empty': not @state.hasObject
      'is-highlight': @state.highlight?

  getStyles: ->
    {tilePx, coords, highlight} = @props

    return {
      left: coords[0] * tilePx
      top: coords[1] * tilePx
      width: tilePx
      height: tilePx
      backgroundColor: "rgba(0, 0, 0, #{(highlight.percent * .5) / 100})"
    }

  renderObject: ->
    {object} = @props
    return unless object?

    classSet = React.addons.classSet
      'object': yes
      'object-animal': object.type is 'animal'
      'object-block': object.type is 'block'

    return `<img
        class={classSet}
        alt={object.name}
        src={object.img}
        />`

  render: ->
    object = @renderObject() || ''

    return `<div
      class={this.classSet()}
      style={this.getStyles()}
      >
      {object}
    </div>`