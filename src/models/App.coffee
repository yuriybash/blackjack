# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on('bust', @bustFunction, this)
    @get('playerHand').on('blackjack', @blackJackFunction, this)
    @get('playerHand').on('stand', @standFunction, this)

  bustFunction: ->
    alert("YOU BUSTED")
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on('bust', @bustFunction, this)
    @get('playerHand').on('blackjack', @blackJackFunction, this)

  blackJackFunction: ->
    alert("YOU WIN")
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on('bust', @bustFunction, this)
    @get('playerHand').on('blackjack', @blackJackFunction, this)

  standFunction: ->
    # console.dir(@get('dealerHand').scores)
    # console.dir(@get('playerHand').scores)
    if (@get('dealerHand').scores()[1] < 16) then @get('dealerHand').hit()
