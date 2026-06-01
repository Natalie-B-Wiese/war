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
    @deck.shuffle
  end

  def deal
    while @deck.cards_left>0
      @player1.add_card(@deck.take_top_card)
      @player2.add_card(@deck.take_top_card)      
    end
  end

  def round_winner
    p1_value=@player1.top_card_value
    p2_value=@player2.top_card_value

    if p1_value>p2_value
      return @player1    
    elsif p2_value>p1_value
      return @player2
    else
      return nil
    end
  end

  def winner
    return @player2 if (@player1.card_count==0)
    return @player1 if (@player1.card_count==0)
  end
    
end 
