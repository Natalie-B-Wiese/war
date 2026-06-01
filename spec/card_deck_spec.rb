require_relative '../lib/card_deck'
require_relative '../lib/playing_card'


describe 'CardDeck' do
  it 'Should have 52 cards when created' do
    deck = CardDeck.new
    expect(deck.cards_left).to eq 52
  end

  it 'should deal the top card' do
    deck = CardDeck.new
    card = deck.deal
    expect(card).to_not be_nil
    expect(card).to be_a PlayingCard
    expect(card).to respond_to(:rank)

    expect(deck.cards_left).to eq 51
  end

  it 'deal gives a unique card each time' do
    deck = CardDeck.new
    card1 = deck.deal
    card2 = deck.deal
    expect(card1).not_to eq card2
  end

end
