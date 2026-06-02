class WarPlayer
  attr_reader :name, :cards
  
  def initialize(name)
    @name=name
    @cards=[]
  end

  def top_card
    @cards[0]
  end
  
  def top_card_value
    top_card.value
  end

  def add_card(card)
    @cards.push(card)
  end

  def take_top_card
    @cards.shift
  end
  

  def card_count
    @cards.length
  end

end 
