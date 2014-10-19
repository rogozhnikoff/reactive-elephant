`/** @jsx React.DOM */`

Elephant = React.createClass
  propTypes:
    coords: React.PropTypes.object
    status: React.PropTypes.oneOf(['wait', 'success', 'fail'])

  getInitialState: ->
    return {

    }

  getClasses: ->
    return React.addons.classSet
      'elephant': yes
      'elephant-idle': @props.status is 'wait'
      'elephant-jump': @props.status is 'success'
      'elephant-boom': @props.status is 'fail'

  render: ->
    return `
    <div class={this.getClasses()} />
    `