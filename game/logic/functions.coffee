class Vector2d
  ## Static

  # zero :: () -> Coords
  @zero: () -> new Vector2d(0, 0)

  # fromString :: String -> Coords
  @fromString: (str) ->
    arr = switch str
      when 'up' then [0, 1]
      when 'down' then [0, -1]
      when 'left' then [-1, 0]
      when 'right' then [1, 0]
      else throw "Undefined string #{str}"

    Vector2d.fromArray arr

  # fromArray :: Array[Int] -> Coords
  @fromArray: (arr) -> new Vector2d(arr[0], arr[1])

  # add :: (Coords, Coords) -> Coords
  @add: (a, b) -> new Vector2d(a.x + b.x, a.y + b.y)

  # distance :: Coords -> Int
  @distance: (a) -> Math.pow(a.x, 2) + Math.pow(a.y, 2)

  @isEqual: (a, b) -> a.x == b.x && a.y == b.y

  # Public
  constructor: (@x, @y) ->

  equals: (b) -> Vector2d.isEqual(@, b)

  notEquals: (b) -> !Vector2d.isEqual(@, b)

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
  tasks = data.tasks
  states = [{
    position: Vector2d.fromArray data.elephant.position
    taskIndex: data.elephant.taskIndex
    status: data.elephant.status
    time: new Date()
  }]
  ###
  # fromMurad :: Bus[Array[Int]]
  fromMurad = new Bacon.Bus()

  fromMurad.flatMap (coords) -> Bacon.fromArray coords

  # stepNumber :: Bus[Int]
  window.stepNumber = new Bacon.Bus()

  # task :: EventStream[Task]
  task = stepNumber.map (step) ->  data.tasks[step]

  # Bus[Array[Int]]
  window.mainstream = new Bacon.Bus()

  # EventStream[Vector2d]
  window.coords = mainstream.map(Vector2d.fromArray)

  state = (new Bacon.Bus())
    .toProperty _.extend(data.elephant, {time: new Date()})

  lastOp = () -> Vector2d.fromString(tasks[_.last(state).taskIndex])
  ###

  # fromMurad :: Bus[Array[Int]]
  window.fromMurad = new Bacon.Bus()

  stepsStream = fromMurad.map(Vector2d.fromArray)
  okStream =
    stepsStream
      .filter ((ev) -> Vector2d.fromString(tasks[_.last(states).taskIndex]).equals(ev))
      .map( (vector) ->
        {
          position: vector
          taskIndex: 1
          status: 'Ok'
          time: new Date()
        })

  stepsStream
    .filter((ev) -> Vector2d.fromString(tasks[_.last(states).taskIndex]).notEquals(ev))
    .map (vector) ->
      message = switch Vector2d.distance vector
        when 1 then 'Неправильний напрямок'
        when 2 then 'Не ходи по діагоналі'
        else 'Не можна ходи далі однієї клітинки'
      {
        position: Vector2d.zero()
        taskIndex: 0
        status: message
        time: new Date()
      }

    .merge(okStream)
    .scan(states[0], (obj1, obj2) ->
      {
      position: Vector2d.add(obj1.position, obj2.position)
      taskIndex: obj1.taskIndex + obj2.taskIndex
      status: obj2.status
      time: obj2.time
      }
    ).onValue((obj) ->
        states.push obj
        console.log '----', 123, obj
        toFront(obj,tasks,data.desk)
    )
