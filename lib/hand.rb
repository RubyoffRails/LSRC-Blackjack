require_relative "./deck"

class Hand
  
  attr_reader :cards
    
  def initialize
    @cards = []
  end
  
  def hit!(deck)
    @cards << deck.deal!
  end
  
  def value
    cards.inject(0) {|total, card| total += card.value}
  end
  
  def busted?
    value > 21
  end
  
  def playable?
    value > 0 && !busted?
  end
end

class DealerHand < Hand
  def play!(deck)
    if value < 16
      hit!(deck)
      play!(deck)
    end
  end
end