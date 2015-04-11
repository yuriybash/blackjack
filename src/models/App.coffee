# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()

    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on('bust', @bustFunction, @)
    @get('playerHand').on('blackjack', @blackJackFunction, @)
    @get('playerHand').on('stand', @standFunction, @)

  bustFunction: (arg)->
    alert("SOMEONE BUSTED")
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on('bust', @bustFunction, @)
    @get('playerHand').on('blackjack', @blackJackFunction, @)

  blackJackFunction: ->
    alert("SOMEONE HIT BLACKJACK")
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on('bust', @bustFunction, @)
    @get('playerHand').on('blackjack', @blackJackFunction, @)

  standFunction: ->
    # console.dir(@get('dealerHand').scores)
    # console.dir(@get('playerHand').scores)
    # flips first card over, updates score
    @get('dealerHand').first().flip();
    while @get('dealerHand').validScore('max') <= @get('playerHand').validScore('max')
      @get('dealerHand').hit()
      if(@get('dealerHand').validScore('max') is 21 or (@get('dealerHand').validScore('min')) is 21) then @blackJackFunction()
      if(@get('dealerHand').validScore('min') > 21) then @bustFunction()
    if(@get('dealerHand').validScore('max') < @get('playerHand').validScore('max')) then alert("player wins")
