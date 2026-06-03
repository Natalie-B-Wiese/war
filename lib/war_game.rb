require_relative 'war_player'
require_relative 'card_deck'

class WarGame
  NUM_PLAYERS = 2
  attr_reader :player1, :player2, :deck

  def initialize(player1_name = 'Player 1', player2_name = 'Player 2')
    @player1 = WarPlayer.new(player1_name)
    @player2 = WarPlayer.new(player2_name)
    @deck = CardDeck.new
  end

  def start
    deck.shuffle
    deal
  end

  def cards_on_table_s(cards_on_table)
    cards_on_table_s = ''
    cards_on_table[0...-1].each do |card|
      cards_on_table_s += "#{card}, "
    end
    cards_on_table_s += 'and a ' unless cards_on_table.length == 1

    cards_on_table_s += cards_on_table[-1].to_s

    cards_on_table_s
  end

  def play_round(cards_on_table = [])
    winning_player = round_winner

    if winning_player.nil?
      handle_round_tie(cards_on_table)
    else
      handle_round_winner(winning_player, opposite_player(winning_player), cards_on_table)
    end
  end

  def handle_round_tie(cards_on_table)
    cards_on_table.push(player1.take_top_card)
    cards_on_table.push(player2.take_top_card)
    play_round(cards_on_table)
  end

  def handle_round_winner(winning_player, losing_player, cards_on_table)
    losing_card = losing_player.take_top_card
    winning_card = winning_player.take_top_card

    cards_on_table.push(losing_card)
    cards_s = cards_on_table_s(cards_on_table)

    cards_on_table.push(winning_card)

    # add the cards to the winning player
    winning_player.add_cards(cards_on_table)

    "#{winning_player.name} took a #{cards_s} with a #{winning_card}"
  end

  def deal
    until deck.cards_left.zero?
      player1.add_card(deck.take_top_card)
      player2.add_card(deck.take_top_card)
    end
  end

  def round_winner
    p1_value = player1.top_card_value
    p2_value = player2.top_card_value

    if p1_value > p2_value
      player1
    elsif p2_value > p1_value
      player2
    end
  end

  # returns the opposite player to the passed in player
  def opposite_player(player)
    return player2 if player == player1
    return player1 if player == player2

    nil
  end

  def winner
    return player2 if player1.card_count.zero?
    return player1 if player2.card_count.zero?

    nil
  end
end
