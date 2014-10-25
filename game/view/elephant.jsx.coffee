`/** @jsx React.DOM */`

@Elephant = React.createClass
  propTypes:
    dragElephant: React.PropTypes.func
    coords: React.PropTypes.arrayOfNumber
    status: React.PropTypes.oneOf([
      'wait'
      'success'
      'fail'
    ])
    sizePx: React.PropTypes.number

  getInitialState: ->
    return {
      dragging: no
    }

  getClasses: ->
    {status} = @props
    {dragging} = @state
    return React.addons.classSet
      'elephant': yes
      'elephant-drag': dragging
      'elephant-idle': status is 'wait'
      'elephant-jump': status is 'success'
      'elephant-boom': status in [
        'wrong-direction'
        'not-diagonal'
        'only-one'
      ]

  dragHandle: (ev) ->
    {nativeEvent} = ev
    {offsetX, offsetY} = nativeEvent

    eventName = nativeEvent.type[4..]

    @setState
      dragging: eventName in ['start', 'move']

    @props.dragElephant
      type: eventName  # start, move, end
      elephantOffset: {
        offsetTop: offsetY
        offsetLeft: offsetX
      }

  getStyles: ->
    return {
      width: @props.sizePx
      height: @props.sizePx
    }

  render: ->
    return `<div
      draggable

      className={this.getClasses()}
      style={this.getStyles()}
      onDragStart={this.dragHandle}
      onDrag={this.dragHandle}
      onDragEnd={this.dragHandle}
      />`