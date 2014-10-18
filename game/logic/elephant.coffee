class coords
  constructor: (@x, @y) ->

class elephant
  constructor: (@position, @status) ->

vectorAdd = (pos, vect) ->
  new coords(pos.x + vect.x, pos.y + vect.y)

$ ->
  elephant = new elephant(new coords(2,3), 'new el')
  okStream = $('#ok').asEventStream('click').map

###
  es = $(document).asEventStream('keyup')
  keysEv = es.filter((ev) => ev.keyCode >= 37 and ev.keyCode <= 40).map((ev) =>
    switch ev.keyCode
      when 37 then new coords(-1, 0)
      when 38 then new coords(0, 1)
      when 39 then new coords(1, 0)
      when 40 then new coords(0, -1)
  ).scan(elephant.position, (oldP, newP) ->
    vectorAdd(oldP, newP)
  ).onValue((data) => console.log data)
###
