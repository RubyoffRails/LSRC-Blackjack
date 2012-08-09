require_relative "./hand"

class Game
  attr_reader :player_hand, :dealer_hand
  def initialize(deck)
    @deck = deck
    @deck.shuffle!
    @player_hand = Hand.new
    @dealer_hand = Hand.new
  end
  
  def start
    2.times do 
      @player_hand.hit!(@deck)
      @dealer_hand.hit!(@deck) 
    end
  end

  def remaining_card_count
    @deck.cards.count
  end
end