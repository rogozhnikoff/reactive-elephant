`/** @jsx React.DOM */`

Elephant = React.createClass
  propTypes:
    dragElephant: Function
    coords: React.PropTypes.arrayOf(Number)
    status: React.PropTypes.oneOf([
      'wait'
      'success'
      'fail'
    ])
    sizePx: Number

  getInitialState: ->
    return {

    }

  getClasses: ->
    {status} = @props
    return React.addons.classSet
      'elephant': yes
      'elephant-idle': status is 'wait'
      'elephant-jump': status is 'success'
      'elephant-boom': status is 'fail'

  dragHandle: (ev) ->
    @props.dragElephant
      type: ev.type[4..]  # start, move, end
      elephantEl: @getDomNode()

  getStyles: ->
    return {
      width: @props.sizePx
      height: @props.sizePx
    }

  render: ->
    return `<div
      draggable

      class={this.getClasses()}
      styles={this.getStyles()}
      onDragStart={this.dragHandle}
      onDragMove={this.dragHandle}
      onDragEnd={this.dragHandle}
      />`