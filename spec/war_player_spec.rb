require_relative '../lib/war_player'
require_relative '../lib/playing_card'


describe 'WarPlayer' do
  it 'has a name and cards' do
    player = WarPlayer.new('Natalie')
    expect(player.name).to eq 'Natalie'
    #expect(player.cards).to be_an Array
    expect(player.cards).to be_empty
  end

  describe '#add_card' do
    it 'adds a card to the bottom' do
      player=WarPlayer.new('Natalie')
      card1=PlayingCard.new('3', 'Diamonds')
      card2=PlayingCard.new('5', 'Hearts')

      player.add_card(card1)
      expect(player.cards[0]).to eq(card1)

      player.add_card(card2)
      expect(player.cards[1]).to eq(card2)
    end
  end

  describe '#take_top_card' do
    it 'returns a card object' do
      
    end
    
  end

end