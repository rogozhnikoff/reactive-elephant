`/** @jsx React.DOM */`

@Desk = React.createClass
  propTypes:
    size: React.PropTypes.array
    objects: React.PropTypes.array
    deskPx: React.PropTypes.object
    tilePx: React.PropTypes.number

  getInitialState: ->
    return {
      shadows: []
    }

  render: ->
    {size} = @props

    return `<div style={this.styleSet()} className={this.classSet()}>
        {_(size[0] * size[1]).times(this.createTile.bind(this)).value()}
    </div>`

  createTile: (n) ->
    {tilePx} = @props
    {size, shadows} = @state

    return `<Tile
      ref={'tile-' + n}
      key={n}

      tilePx={tilePx}
      sizeDeskX={size[0]}

      getShadow={this.getShadow}
      getObject={this.getObject}
    />`

  styleSet: ->
    {deskPx} = @props
    return _.extend {}, deskPx, {
      # ... styles
    }

  # todo: it must be cached
  getPosition: ->
    {offsetTop, offsetLeft} = @getDOMNode()
    return {offsetTop, offsetLeft}

  getShadow: ({coords}) ->
    return _(@state.shadows).find (shadow) -> _.isEqual(shadow.position, coords)

  getObject: ({coords}) ->
    return __.getObjectByCoords(@props.objects, coords)


  classSet: ->
    React.addons.classSet
      'desk': yes