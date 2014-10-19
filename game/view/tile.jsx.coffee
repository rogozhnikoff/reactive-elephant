`/** @jsx React.DOM */`


Tile = React.createClass
  propTypes:
    coords: React.PropTypes.shape
      x: React.PropTypes.number
      y: React.PropTypes.number

    object: React.PropTypes.shape
      type: React.PropTypes.oneOf([
        'animal'
        'block'
      ])
      img: React.PropTypes.string
      name: React.PropTypes.string
      coords: React.PropTypes.shape
        x: React.PropTypes.number
        y: React.PropTypes.number

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
      'is-highlight': @state.highlight

  getStyle: ->
    return {
      width: 0
      height: 0
    }

  renderObject: ->
    {object} = @props
    return unless object?

    classes = 'object object-' + object.type
    return `
    <img class={classes} alt={object.name} src={object.img} />
    `

  render: ->
    styles = __.prepareStylesToDom(this.getStyle())

    return `
    <div class={this.classes()} style={styles}>
      {this.renderObject() || ''}
    </div>
    `