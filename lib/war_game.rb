require_relative 'war_player.rb'
require_relative 'card_deck.rb'


class WarGame
  attr_reader :player1, :player2, :deck

  def initialize
    @player1=WarPlayer.new('Player 1')
    @player2=WarPlayer.new('Player 2')
    @deck=CardDeck.new
  end

  def start
    deck.shuffle
    deal
  end

  def play_round(cards_on_table=[])

    winning_player=round_winner
    
    if winning_player.nil?
      cards_on_table.push(player1.take_top_card)
      cards_on_table.push(player2.take_top_card)
      play_round(cards_on_table)
    else
      losing_player=opposite_player(winning_player)
      losing_card=losing_player.take_top_card
      winning_card=winning_player.take_top_card

      cards_on_table.push(losing_card)

      cards_on_table_s=""
      cards_on_table[0...-1].each do |card|
        cards_on_table_s+="#{card}, "
      end
      cards_on_table_s+="and a " unless cards_on_table.length==1

      cards_on_table_s+=cards_on_table[-1].to_s

      cards_on_table.push(winning_card)


      # add the cards to the winning player
      cards_on_table.each do |card|
        winning_player.add_card(card)
      end
      return "#{winning_player.name} took a #{cards_on_table_s} with a #{winning_card}"
    end
  end


  def deal
    while deck.cards_left>0
      player1.add_card(deck.take_top_card)
      player2.add_card(deck.take_top_card)      
    end
  end

  def round_winner
    p1_value=player1.top_card_value
    p2_value=player2.top_card_value

    if p1_value>p2_value
      return player1    
    elsif p2_value>p1_value
      return player2
    else
      return nil
    end
  end

  # returns the opposite player to the passed in player
  def opposite_player(player)
    return player2 if player==player1
    return player1 if player==player2
    nil
  end

  def winner
    return player2 if (player1.card_count==0)
    return player1 if (player2.card_count==0)
    return nil
  end
    
end 
