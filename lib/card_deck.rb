require_relative '../lib/playing_card'
class CardDeck

  attr_reader :cards

  def initialize
    @cards=PlayingCard::SUITS.flat_map do |suit|
      PlayingCard::RANKS.map do |rank|
        PlayingCard.new(rank, suit)
      end
    end
  end

  def cards_left
    @cards.length
  end

  def take_top_card
    @cards.shift
  end

  def shuffle
    shuffled=@cards.shuffle
    while shuffled==@cards
      shuffled=@cards.shuffle
    end

    @cards=shuffled
  end
end
