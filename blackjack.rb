Dir["lib/*.rb"].each {|file| require_relative file}

deck = Deck.build
deck.shuffle!
puts "OH HAI"
puts deck.cards.take(2)