toCoords = (str) ->
  switch str
    when 'up' then {x: 0, y: 1}
    when 'down' then {x: 0, y: -1}
    when 'left' then {x: -1, y: 0}
    when 'right' then {x: 1, y: 0}

toFront = (state, tasks, desk) ->
  {
    state: state
    task: ( ->
      arr = []
      for task, i in tasks
        arr.push {
          name: task
          visited: state.taskIndex > i
          current: state.taskIndex is i
        }
      return arr
      )()
    desk: desk
  }

$.ajax('game/logic/fixture.json').done (data) ->
  state = data.elephant
  tasks = data.tasks

  window.mainstream = (new Bacon.Bus())

  okStream = mainstream.filter((ev) -> _.isEqual(toCoords(tasks[state.taskIndex]), ev)).map( (ev) ->
    {
      x: ev.x
      y: ev.y
      taskIndex: 1
      status: 'Ok'
    })

  wrongStream = mainstream.filter((ev) -> !_.isEqual(toCoords(tasks[state.taskIndex]), ev)).map( () ->
    {
    x: 0
    y: 0
    taskIndex: 0
    status: 'Bad boy'
    })

  getState = okStream.merge(wrongStream).scan(data.elephant, (obj1, obj2) ->
    {
    x: obj1.x + obj2.x
    y: obj1.y + obj2.y
    taskIndex: obj1.taskIndex + obj2.taskIndex
    status: obj2.status
    }
  ).onValue((obj) ->
      state = obj
      toFront(state,tasks,data.desk)
  )
