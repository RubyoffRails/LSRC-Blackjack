require_relative "./hand"

class Game
  class InvalidPlay < StandardError; end

  attr_reader :player_hand, :dealer_hand, :player_score, :dealer_score
  def initialize(deck)
    @deck = deck
    @deck.shuffle!
    @player_hand = Hand.new
    @dealer_hand = DealerHand.new
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
  
  def hit!
    raise InvalidPlay.new "Hand not playable" unless @player_hand.playable?
    @player_hand.hit!(@deck)
  end
  
  def stand!
    @player_score = @player_hand.value
    play_dealer_hand!
    @dealer_score = @dealer_hand.value
  end
  
  def winner
    if player_score > 21
      :dealer
    elsif dealer_score > 21
      :player
    elsif player_score > dealer_score
      :player
    elsif player_score == dealer_score
      :push
    else
      :dealer
    end
  end
  
  def play(display_output, get_input)
    while true do
      display_output << "Your hand!: #{player_hand.cards}\n"
      display_output << "Hit or no? (Y/N)\n"
      command = get_input.gets
      if command =~ /Y/i
        hit!
      else
        stand!
        break
      end
    end
    display_output << "Dealer hand!: #{dealer_hand.cards}\n"
    display_output << winner << "\n"
  end
  
  private
  
  def play_dealer_hand!
    @dealer_hand.play!(@deck)
  end
end