`/** @jsx React.DOM */`
class Game
  pushCoords: ->

  onValue: ->


{renderComponent, createClass} = React

Game = createClass
  getInitialState: ->

  render: ->
    game = @props.game.get()

    return `
      <div>
        <Desk size={game.desk.size} objects={game.desk.objects} />
        <Elephant />
        <Tasks />
      </div>
    `

Desk = createClass
  getInitialState: ->
  render: ->

Elephant = createClass
  getInitialState: ->
  render: ->

Tasks = createClass
  getInitialState: ->
  render: ->



do ->
  game = new Game()
  renderComponent(`<Game game={game} />`, document.getElementById('container'))
