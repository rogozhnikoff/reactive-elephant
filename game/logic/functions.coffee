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
  @distance: (a,b) -> Math.pow(a.x - b.x, 2) + Math.pow(a.y - b.y, 2)

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
  initialState = _.extend(data.elephant, {time: new Date(), position: Vector2d.fromArray(data.elephant.position)})


  window.fromMurad = new Bacon.Bus()
  state = (new Bacon.Bus()).toProperty(initialState)

  steps = fromMurad.map((newCoords) -> Vector2d.fromArray(newCoords)).combine(state, (a,b) ->
    newCoords: a
    oldCoords: b.position
    taskDirection: Vector2d.fromString data.tasks[b.taskIndex]
  )

  toFar = steps.filter (ev) -> Vector2d.distance(ev.oldCoords, ev.newCoords) > 1
    .map (ev) ->
      message = switch Vector2d.distance(ev.oldCoords, ev.newCoords)
        when 2 then 'diagonal'
        else 'to far'
      {
        taskIndex: 0
        status: message
        position: Vector2d.zero()
        timeStamp: new Date()
      }
    .toEventStream()

  possibleMoves = steps.filter (ev) -> Vector2d.distance(ev.oldCoords, ev.newCoords) is 1

  okStream = possibleMoves.filter (ev) -> Vector2d.isEqual ev.newCoords, Vector2d.add(ev.oldCoords, ev.taskDirection)
    .map (ev) ->
      {
      taskIndex: 1
      status: 'Ok'
      position: ev.newCoords
      timeStamp: new Date()
      }
    .toEventStream()

  mistake = possibleMoves.filter (ev) -> !Vector2d.isEqual ev.newCoords, Vector2d.add(ev.oldCoords, ev.taskDirection)
    .map (ev) ->
      {
      taskIndex: 1
      status: 'not your task'
      position: ev.newCoords
      timeStamp: new Date()
      }
    .toEventStream()

  toFar.merge(mistake).merge(okStream).scan initialState, (a,b) ->
      {
      taskIndex: a.taskIndex + b.taskIndex
      status: b.status
      position: Vector2d.add(a.position, b.position)
      timeStamp: b.timeStamp
      }
    .onValue (data) ->
      console.log '----', 'summary', data
      #state.push data

  ###
  stepsStream = fromMurad.map(Vector2d.fromArray)
  okStream =
    stepsStream
      .filter ((ev1,ev2) ->
        console.log '----', ev1,ev2
        Vector2d.fromString(tasks[_.last(states).taskIndex]).equals(ev1)
      )
      .map( (vector) ->
        {
          position: vector
          taskIndex: 1
          status: 'Ok'
          time: new Date()
        })

  state = stepsStream
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
    )

  state.onValue((obj) ->
        console.log '----', 133, obj.position
        states.push obj
        toFront(obj,tasks,data.desk)
    )

  ###
