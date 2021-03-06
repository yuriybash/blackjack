class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->


  hit: ->
    @add(@deck.pop())
    if(@scores()[0] > 21)
      @trigger "bust", @isDealer
    else if((@scores()[0] is 21) or (@scores()[1] is 21))
      @trigger "blackjack", @isDealer


  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]


  validScore:(arg) ->
    scores = @scores()
    if arg is 'max'
      if scores[1] < 22 then return scores[1]
      else return scores[0]
    else
      scores[0]

  stand: ->
    @trigger 'stand'

