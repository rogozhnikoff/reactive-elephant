`/** @jsx React.DOM */`

icon = React.createClass
  render: ->
    classNames = do ->
      # todo: we should check "what typeof/instanceof return React.addons.classSet" istead
      if _.isObject(@props.icClass)
        return React.addons.classSet(@props.icClass)
      else
        return @props.icClass

    return `<i class=classNames />`

Tasks = React.createClass
  propTypes:
    model: React.PropTypes.arrayOf(React.PropTypes.shape({
      type: String
      visited: Boolean
      current: Boolean
    }))

  createTask: (task, i, tasks) ->
    classNames = React.addons.classSet
      'task': yes
      'task-primary': i is 0
      'task-secondary': i > 0

    return `
      <icon ic-class=classNames />
    `

  render: ->
    return @props.model.map(@createTask)