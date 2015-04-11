class window.CardView extends Backbone.View
  className: 'card'

  template: _.template '<img src="img/cards/<%= rankName %>-<%= suitName %>.png">'

  initialize: ->
    @render()
    @model.on 'flip', @render, @

  render: ->
    console.log("CARD RERENDERED")
    @$el.children().detach()
    @$el.html @template @model.attributes
    @$el.addClass 'covered' unless @model.get 'revealed'

