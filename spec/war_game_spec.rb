require_relative '../lib/war_game'
require_relative '../lib/war_player'
require_relative '../lib/card_deck'


describe 'WarGame' do
  
  describe '#initailzie' do
    it 'creates two players and a new deck' do
      game=WarGame.new()
      expect(game.player1).to be_a(WarPlayer)
      expect(game.player2).to be_a(WarPlayer)
      expect(game.deck).to be_a(CardDeck)
    end
  end


  describe "#start" do
    it 'creates a new shuffled deck' do
      game=WarGame.new
      #allow(game.deck).to receive(:shuffle)
      #expect(game.deck).to receive(:shuffle)
      game.start
      expect(game.deck.cards_left).to_not eq 0
    end
  end

  describe '#deal' do
    it 'deals 26 cards to each player' do
      game=WarGame.new
      game.deal
      p1_cards=game.player1.cards
      p2_cards=game.player2.cards
      halfsize=((CardDeck.new).cards_left)/2

      expect(p1_cards.length).to eq halfsize
      expect(p2_cards.length).to eq halfsize
    end
  end

  describe '#round_winner' do
    context 'when player 1 has a bigger value' do
      it 'returns player 1' do
        game=WarGame.new
        allow(game.player1).to receive(:top_card_value).and_return(10)
        allow(game.player2).to receive(:top_card_value).and_return(0)

        expect(game.round_winner).to eq game.player1
      end
    end

    context 'when player 2 has a bigger value' do
      it 'returns player 2' do
        game=WarGame.new
        allow(game.player1).to receive(:top_card_value).and_return(0)
        allow(game.player2).to receive(:top_card_value).and_return(10)

        expect(game.round_winner).to eq game.player2
      end
    end

    context 'when values are equal' do
      it 'returns nil' do
        game=WarGame.new
        allow(game.player1).to receive(:top_card_value).and_return(10)
        allow(game.player2).to receive(:top_card_value).and_return(10)

        expect(game.round_winner).to be_nil
      end
    end
  end

  describe '#winner' do
    context 'when both players still have cards' do

      it 'return nil' do  
        game=WarGame.new
        allow(game.player1).to receive(:card_count).and_return(5)
        allow(game.player2).to receive(:card_count).and_return(10)       
        result=game.winner
        expect(result).to be_nil
      end
    end

    context 'when player 1 runs out of cards' do

      it 'return player2' do
        game=WarGame.new
        allow(game.player1).to receive(:card_count).and_return(0)
        allow(game.player2).to receive(:card_count).and_return(10)
        result=game.winner
        expect(result).to eq game.player2
      end
    end

    context 'when player 2 runs out of cards' do

      it 'return player1' do
        game=WarGame.new
        allow(game.player1).to receive(:card_count).and_return(10)
        allow(game.player2).to receive(:card_count).and_return(0)

        result=game.winner
        expect(result).to eq game.player1
      end
    end
  end
  

end
