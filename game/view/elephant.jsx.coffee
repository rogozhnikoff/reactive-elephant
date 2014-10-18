`/** @jsx React.DOM */`
class Game
  pushCoords: ->

  onValue: ->


{renderComponent, createClass} = React

Game = createClass
  componentWillMount: ->
    @props.onValue (data) ->
      @setState({dataTaken: true})
      @setState(data)

  getInitialState: ->
    return {
      dataTaken: false
    }
  render: ->
    game = @props.game.get()

    return `<div>Loading...</div>` unless @state.dataTaken

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
  renderComponent(`<Game bind={game.onValue} />`, document.getElementById('container'))