Dir["lib/*.rb"].each {|file| require_relative file}

deck = Deck.build
puts "OH HAI"
puts deck.cards.take(2)