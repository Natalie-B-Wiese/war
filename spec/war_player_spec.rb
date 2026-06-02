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
    it 'returns top card object' do
      player=WarPlayer.new('Natalie')
      card1=PlayingCard.new('A', 'Spades')
      card2=PlayingCard.new('K', 'Hearts')
      player.add_card(card1)
      player.add_card(card2)

      result=player.take_top_card
      expect(result).to eq card1
    end

    it 'removes card from cards' do
      player=WarPlayer.new('Natalie')
      card1=PlayingCard.new('A', 'Spades')
      card2=PlayingCard.new('K', 'Hearts')
      player.add_card(card1)
      player.add_card(card2)

      player.take_top_card
      result=player.card_count
      expect(result).to eq 1
    end
    
  end

  describe '#top_card' do
    it 'returns top card object' do
      player=WarPlayer.new('Natalie')
      card1=PlayingCard.new('A', 'Spades')
      card2=PlayingCard.new('K', 'Hearts')
      player.add_card(card1)
      player.add_card(card2)

      result=player.top_card
      expect(result).to eq card1
    end
    
  end

  describe '#top_card_value' do
    it 'returns value of top card object' do
      player=WarPlayer.new('Natalie')
      card1=PlayingCard.new('2', 'Spades')
      card2=PlayingCard.new('K', 'Hearts')
      player.add_card(card1)
      player.add_card(card2)

      result=player.top_card_value
      expected_value=card1.value
      expect(result).to eq expected_value
    end
    
  end

  describe '#card_count' do
    context 'when the player has no cards' do
      it 'returns 0' do
        player=WarPlayer.new('Natalie')
        result=player.card_count
        expect(result).to eq 0
      end
    end

    context 'when there is 1 card' do
      it 'returns 1' do
        player=WarPlayer.new('Natalie')
        player.add_card(PlayingCard.new('A', 'Spades'))

        result=player.card_count
        expect(result).to eq 1
      end
    end

    context 'when there are many cards' do
      it 'returns correct number' do
        player=WarPlayer.new('Natalie')
        player.add_card(PlayingCard.new('A', 'Spades'))
        player.add_card(PlayingCard.new('J', 'Diamonds'))
        player.add_card(PlayingCard.new('3', 'Hearts'))

        result=player.card_count
        expect(result).to eq 3
      end
    end
  end

end