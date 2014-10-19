toCoords = (str) ->
  switch str
    when 'up' then [0, 1]
    when 'down' then [0, -1]
    when 'left' then [-1, 0]
    when 'right' then [1, 0]

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
distance = (coords) ->
  Math.pow(coords[0],2) + Math.pow(coords[1],2)

wrongDir = (status) ->
  {
  position: [0, 0]
  taskIndex: 0
  status: status
  time: new Date()
  }

$.ajax('game/logic/fixture.json').done (data) ->
  state = [_.extend(data.elephant, {time: new Date()})]
  tasks = data.tasks

  window.mainstream = (new Bacon.Bus())
  okStream = mainstream.filter((ev) -> _.isEqual(toCoords(tasks[_.last(state).taskIndex]), ev)).map( (ev) ->
    {
      position: ev
      taskIndex: 1
      status: 'Ok'
      time: new Date()
    })

  wrongStream = mainstream.filter((ev) -> !_.isEqual(toCoords(tasks[_.last(state).taskIndex]), ev))
  ###
    .map( () ->
      {
      position: [0, 0]
      taskIndex: 0
      status: 'Bad boy'
      time: new Date()
      })
  ###
  wrongStream.filter((ev) -> distance(ev) is 1).map( () -> wrongDir('Неправильний напрямок'))
    .merge(wrongStream.filter((ev) -> distance(ev) is 2).map( () -> wrongDir('Не ходи по діагоналі')))
    .merge(wrongStream.filter((ev) -> distance(ev) > 2).map( () -> wrongDir('Не можна ходи далі однієї клітинки')))
    .merge(okStream)
    .scan(state[0], (obj1, obj2) ->
      {
      position: [obj1[0] + obj2[0], obj1[1] + obj2[2]]
      taskIndex: obj1.taskIndex + obj2.taskIndex
      status: obj2.status
      time: obj2.time
      }
    ).onValue((obj) ->
        state.push obj
        console.log '----', 123, obj
        toFront(obj,tasks,data.desk)
    )
