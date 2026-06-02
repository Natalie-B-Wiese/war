require_relative '../lib/card_deck'
require_relative '../lib/playing_card'


describe 'CardDeck' do
  it 'Should have 52 cards when created' do
    deck = CardDeck.new
    expect(deck.cards_left).to eq 52
  end

  describe '#take_top_card' do
    it 'returns the top card' do
      deck = CardDeck.new
      card = deck.take_top_card
      expect(card).to_not be_nil
      expect(card).to be_a PlayingCard
      expect(card).to respond_to(:rank)
    end

    it 'gives a unique card each time' do
      deck = CardDeck.new
      card1 = deck.take_top_card
      card2 = deck.take_top_card
      expect(card1).not_to eq card2
    end

  end

  describe '#cards_left' do
    it 'returns 52 on full deck' do
      deck = CardDeck.new
      expect(deck.cards_left).to eq 52
    end
    it 'returns cards_left for non-full deck' do
      deck = CardDeck.new
      deck.take_top_card
      deck.take_top_card
      deck.take_top_card
      expect(deck.cards_left).to eq 49
    end
  end

  describe '#shuffle' do
    it 'shuffles the array' do
      non_shuffled=CardDeck.new
      shuffled=CardDeck.new
      shuffled.shuffle

      expect(non_shuffled.cards).not_to eq shuffled.cards
    end
  end

end
