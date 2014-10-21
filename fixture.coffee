{
  tasks: [
    {
      type: 'right'
      visited: true
      current: false
    }
    {
      type: 'down'
      visited: true
      current: false
    }
    {
      type: 'left'
      visited: false
      current: true
    }
    {
      type: 'up'
      visited: false
      current: false
    }
  ]

  desk: {
    size: {
      x: 0
      y: 0
    }
    objects: [
      {
        type: 'animal' || 'block'
        img: '<img />'
        name: ''
        coords: {
          x: 0
          y: 0
        }
      }
      ...
    ]
  }

  elephant: {
    coords: {
      x: 0
      y: 0
    }
    status: ''
  }
}

class Game
  pushCoords: (coords) ->
    [
      {
        x: 0
        y: 0
        percent: 60
      }
      {
        x: 0
        y: 0
        percent: 20
      }
    ]