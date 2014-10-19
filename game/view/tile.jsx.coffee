`/** @jsx React.DOM */`

React.PropTypes.Coords = React.PropTypes.shape
  x: Number
  y: Number

Tile = React.createClass
  propTypes:
    highlight: String

    size: Number

    coords: React.PropTypes.Coords

    object: React.PropTypes.shape
      type: React.PropTypes.oneOf([
        'animal'
        'block'
      ])
      img: String
      name: String
      coords: React.PropTypes.Coords

  getInitialState: ->
    return {
      highlight: off,
      hasObject: @props.object?
    }

  classes: ->
    return React.addons.classSet
      'tile': true
      'tile-filled': @state.hasObject
      'tile-empty': not @state.hasObject
      'is-highlight': @state.highlight?

  getStyles: ->
    return {
      width: @props.size
      height: @props.size
    }

  renderObject: ->
    {object} = @props
    return unless object?

    classes = 'object object-' + object.type
    return `
    <img class={classes} alt={object.name} src={object.img} />
    `

  render: ->
    return `
    <div class={this.classes()} style={this.getStyles()}>
      {this.renderObject() || ''}
    </div>
    `