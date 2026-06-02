class WarPlayer
  attr_reader :name, :cards
  
  def initialize(name)
    @name=name
    @cards=[]
  end

  def add_card(card)
    @cards.push(card)
  end

  

end 
