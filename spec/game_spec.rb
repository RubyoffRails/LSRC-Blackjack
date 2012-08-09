require_relative "../lib/game"

describe Game do
  subject { Game.new(Deck.build)}
  before { subject.start }
  
  it "should have a player hand" do
    subject.player_hand.should be_playable
    subject.player_hand.cards.count.should eq(2)
  end
  it "should have a dealers hand" do
    subject.dealer_hand.should be_playable
    subject.dealer_hand.cards.count.should eq(2)
  end
  it "all the cards should equal 52" do
    total_count = subject.dealer_hand.cards.count + 
                  subject.player_hand.cards.count +
                  subject.remaining_card_count
    total_count.should eq(52)
  end

  it "should create and shuffle a deck on start" do
    mock_deck = mock(:deck)
    mock_deck.should_receive(:shuffle!)
    Game.new(mock_deck)
  end

  it "should allow player to hit" do
    expect {
      subject.hit!
    }.to change(subject.player_hand, :value)    
  end
  it "should not allow player to hit when not playable" do
    subject.player_hand.stub(:playable?) { false }
    expect {
      subject.hit!
    }.to raise_error(Game::InvalidPlay)
  end
  it "should allow player to stand" do
    subject.player_hand.stub(:value) { 18 }
    subject.stand!
    subject.player_score.should eq(18)
  end
  
  it "should play the dealers hand" do
    subject.should_receive(:play_dealer_hand!)
    subject.dealer_hand.stub(:value) { 18 }
    subject.stand!
    subject.dealer_score.should eq(18)
  end

  describe "#winner" do
    
    it "knows dealer won" do
      subject.stub(:player_score) { 18 }
      subject.stub(:dealer_score) { 19 }
      subject.winner.should eq(:dealer)
    end
    
    it "knows player won" do
      subject.stub(:player_score) { 19 }
      subject.stub(:dealer_score) { 16 }
      subject.winner.should eq(:player)
    end
    
    it "knows player busted" do
      subject.stub(:player_score) { 22 }
      subject.stub(:dealer_score) { 16 }
      subject.winner.should eq(:dealer)
    end
    
    it "knows ties" do
      subject.stub(:player_score) { 18 }
      subject.stub(:dealer_score) { 18 }
      subject.winner.should eq(:push)
    end
  end
end