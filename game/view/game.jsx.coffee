`/** @jsx React.DOM */`

### где-то там...
class Game
  pushCoords: ->
  onValue: ->
###

Game = React.createClass
  propTypes:
    bind: React.PropTypes.func

  componentWillMount: ->
    @props.bind((data) ->
      @setState({dataTaken: yes})
      @setState(data)
    )

  getInitialState: ->
    return {
      dataTaken: no
    }

  render: ->
    return `<div>Loading...</div>` unless @state.dataTaken

    {desk, elephant, tasks} = @state

    return `
      <div>
        <Desk size={desk.size} objects={desk.objects} />
        <Elephant coords={elephant.coords} status={elephant.status} />
        <Tasks model={tasks} />
      </div>
    `



do ->
  game = new Game()
  React.renderComponent(`<Game bind={game.onValue} />`, document.getElementById('container'))