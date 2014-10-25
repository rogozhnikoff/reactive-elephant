`/** @jsx React.DOM */`

@Tasks = React.createClass
  propTypes:
    model: React.PropTypes.arrayOf(React.PropTypes.shape({
      type: String
      visited: Boolean
      current: Boolean
    }))

  createTask: (task, i, tasks) ->
    classSet = React.addons.classSet
      'task': yes

      'task-primary': i is 0
      'task-secondary': i > 0

      'task-up': task.type is 'up'
      'task-right': task.type is 'right'
      'task-left': task.type is 'left'
      'task-down': task.type is 'down'

    return `<i className={classSet} />`

  render: ->
    return `<div className='tasks'>
        {this.props.model.map(this.createTask)}
      </div>`