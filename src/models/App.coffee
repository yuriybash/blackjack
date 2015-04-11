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
    @get('dealerHand').on('blackjack', @blackJackFunction, @)
    @get('dealerHand').on('stand', @standFunction, @)
    @get('dealerHand').on('bust', @bustFunction, @)


  bustFunction: (arg)->
    if arg
      alert "DEALER BUSTED"
    else
      alert "PLAYER BUSTED"
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on('bust', @bustFunction, @)
    @get('playerHand').on('blackjack', @blackJackFunction, @)
    @get('dealerHand').on('blackjack', @blackJackFunction, @)
    @get('dealerHand').on('stand', @standFunction, @)
    @get('dealerHand').on('bust', @bustFunction, @)


  blackJackFunction: (arg) ->
    if arg
      alert "DEALER HIT BLACKJACK"
    else
      alert "PLAYER HIT BLACKJACK"
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on('bust', @bustFunction, @)
    @get('playerHand').on('blackjack', @blackJackFunction, @)
    @get('dealerHand').on('blackjack', @blackJackFunction, @)
    @get('dealerHand').on('stand', @standFunction, @)
    @get('dealerHand').on('bust', @bustFunction, @)


  standFunction: ->
    # console.dir(@get('dealerHand').scores)
    # console.dir(@get('playerHand').scores)
    # flips first card over, updates score
    @get('dealerHand').first().flip();
    while @get('dealerHand').validScore('min') <= 17
      @get('dealerHand').hit()
    if @get('dealerHand').validScore('min') > 21 then @bustFunction(true)


