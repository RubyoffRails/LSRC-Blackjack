Dir["lib/*.rb"].each {|file| require_relative file}

game = Game.new(Deck.build)
game.start

game.play($stdout, $stdin)


