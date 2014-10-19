toCoords = (str) ->
  switch str
    when 'up' then {x: 0, y: 1}
    when 'down' then {x: 0, y: -1}
    when 'left' then {x: -1, y: 0}
    when 'right' then {x: 1, y: 0}

$ ->
  $.ajax('game/logic/fixture.json').done (data) ->
    console.log '----', data
    state = data.elephant
    tasks = data.tasks

    okStream = $('#ok').asEventStream('click').map(() ->
      {
      x: 1
      y: 0
      taskIndex: 1
      status: 'Ok'
      })

    wrongStream = $('#wrong').asEventStream('click').map(() ->
      {
      x: 0
      y: 0
      taskIndex: 0
      status: 'Bad boy'
      })

    okStream.merge(wrongStream).scan(data.elephant, (obj1, obj2) ->
      {
        x: obj1.x + obj2.x
        y: obj1.y + obj2.y
        taskIndex: obj1.taskIndex + obj2.taskIndex
        status: obj2.status
      }
    ).onValue((obj) -> console.log '----', obj)


    test = (new Bacon.Bus())

    mainstream = test.filter((ev) -> toCoords(tasks[state.taskIndex]) == ev)

    test.push({x:10})

###
    es = $(document).asEventStream('keyup')
    keysEv = es.filter((ev) => ev.keyCode >= 37 and ev.keyCode <= 40).map((ev) =>
      switch ev.keyCode
        when 37 then {x: -1, y: 0}
        when 38 then {x: 0, y: 1}
        when 39 then {x: 1, y: 0}
        when 40 then {x: 0, y: -1}
    )###
