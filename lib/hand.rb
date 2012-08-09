require_relative "./deck"

class Hand
  
  attr_reader :cards
    
  def initialize(first, second)
    @cards = [first, second]
  end
  
  def hit!(deck)
    @cards << deck.deal!
  end
  
  def value
    @cards.inject(0) {|total, card| total += card.value}
  end
  
  def busted?
    value > 21
  end
end