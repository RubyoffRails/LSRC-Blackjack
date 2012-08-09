require_relative "./card"

class Deck
  class BadInputError < StandardError; end
  
  attr_reader:cards
  
  def initialize
    @cards = []
  end

  def << (card)
    raise BadInputError.new("YOU HAVE FAILED") unless valid_card?(card)
    @cards << card
  end
  
  def valid_card?(card)
    card.respond_to?(:suit) && card.respond_to?(:value)
  end
  
  def self.build
    deck = new
    [:club, :diamond, :heart, :spade].each do |suit|
      possibles = [2,3,4,5,6,7,8,9,10,:jack, :queen, :king, :ace]
      possibles.each do |value|
        deck << Card.build(suit: suit, value: value)
      end
    end
    deck
  end
  
  def shuffle!
    cards.shuffle
  end
end