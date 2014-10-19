`/** @jsx React.DOM */`

Elephant = React.createClass
  propTypes:
    dragElephant: Function
    coords: Object
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
    type = ev.type[4..]  # start, move, end

    @props.dragElephant
      type: type
      position: @props.getPositionOfElephant()

  getStyles: ->
    return {
      width: @props.sizePx
      height: @props.sizePx
    }

  render: ->
    return `
    <div
      class={this.getClasses()}
      styles={this.getStyles()}
      draggable="true"

      onDragStart={this.dragHandle}
      onDragMove={this.dragHandle}
      onDragEnd={this.dragHandle}
      />
    `