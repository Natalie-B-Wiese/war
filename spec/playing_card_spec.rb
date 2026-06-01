require_relative '../lib/playing_card'

describe 'PlayingCard' do
  it 'has a rank and suit' do
    card=PlayingCard.new('A', 'Spades')
    expect(card.rank).to eq 'A'
    expect(card.suit).to eq 'Spades'
  end

  it 'cards of the same rank and suit are equal' do
    card1=PlayingCard.new('A', 'Spades')
    card2=PlayingCard.new('K', 'Spades')
    card3=PlayingCard.new('A', 'Spades')

    expect(card1).not_to eq card2
    expect(card1).to eq card3
  end

  it 'should allow valid ranks' do
    expect {
      PlayingCard.new('15', 'Spades')
  }.to raise_error PlayingCard::InvalidRank  
  end

  it 'should allow valid suits' do
    expect {
      PlayingCard.new('2', 'Minecraft')
  }.to raise_error PlayingCard::InvalidSuit
  end



end
