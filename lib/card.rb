class Card

  attr_reader :suit, :value
  
  def self.build(args)
    suit = args.fetch(:suit)
    value = args.fetch(:value)
    card_map = card_map(args.fetch(:card_map, {}))
    klass = card_map.fetch(value, Card)
    klass.new(args)
  end
  
  def self.card_map(extra_params)
    defaults = {:jack => FaceCard,
      :queen => FaceCard, 
      :king => FaceCard, 
      :ace => Ace}
    defaults.merge(extra_params)
  end
  
  def self.valid_card?(card)
    card.respond_to?(:suit) && card.respond_to?(:value)
  end
  
  def initialize(args)
    @suit = args.fetch(:suit)
    @value = args.fetch(:value)
  end
  
  def to_s
    "#{@value}-#{@suit}"
  end

end

class FaceCard < Card
  def value
    10
  end
  def to_s
    "#{@value[0].upcase}-#{@suit}"
  end
end

class Ace < FaceCard
  def value
    11
  end
end