class @Core
  onValue: (@pullCallback) ->
    setTimeout(=>
      @pullCallback({
        elephant: {
          coords: [0, 1]
          status: 'success'
        }
        desk: {
          size: [5, 5]
          objects: [
            {
              type: 'animal'
              img: 'rabbit'
              name: 'Rabbit Bob'
              coords: [1, 4]
            }
            {
              type: 'block'
              img: 'bomb'
              name: 'Some Block Name'
              coords: [3, 1]
            }
          ]
        }
        tasks: [
          {
            type: 'right'
            visited: true
            current: false
          }
          {
            type: 'right'
            visited: true
            current: false
          }
        ]
      })
    , 1000)
  pushCoords: -> console.log('pushCoords', arguments)