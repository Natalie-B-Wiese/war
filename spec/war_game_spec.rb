require_relative '../lib/war_game'
require_relative '../lib/war_player'
require_relative '../lib/card_deck'

describe 'WarGame' do
  describe '#initialize' do
    context 'when no parameters are given' do
      let(:game) { WarGame.new }

      it 'creates two players and a new deck' do
        expect(game.player1).to be_a(WarPlayer)
        expect(game.player2).to be_a(WarPlayer)
        expect(game.deck).to be_a(CardDeck)
      end

      it 'first player is named Player 1' do
        expect(game.player1.name).to eq 'Player 1'
      end

      it 'second player is named Player 2' do
        expect(game.player2.name).to eq 'Player 2'
      end
    end

    context 'when one parameter is given' do
      let(:name1) { 'Jeff' }
      let(:game) { WarGame.new(name1) }

      it 'creates two players and a new deck' do
        expect(game.player1).to be_a(WarPlayer)
        expect(game.player2).to be_a(WarPlayer)
        expect(game.deck).to be_a(CardDeck)
      end

      it 'first player is named same as first parameter' do
        expect(game.player1.name).to eq name1
      end

      it 'second player is named Player 2' do
        expect(game.player2.name).to eq 'Player 2'
      end
    end

    context 'when two parameters are given' do
      let(:name1) { 'Jeff' }
      let(:name2) { 'Bob' }
      let(:game) { WarGame.new(name1, name2) }

      it 'creates two players and a new deck' do
        expect(game.player1).to be_a(WarPlayer)
        expect(game.player2).to be_a(WarPlayer)
        expect(game.deck).to be_a(CardDeck)
      end

      it 'first player is named same as first parameter' do
        expect(game.player1.name).to eq name1
      end

      it 'second player is named same as second parameter' do
        expect(game.player2.name).to eq name2
      end
    end
  end

  describe '#start' do
    let(:game) { WarGame.new }

    it 'deals the deck to the players' do
      game.start
      expect(game.deck.cards_left).to eq 0
      expect(game.player1.card_count).to_not eq 0
      expect(game.player2.card_count).to_not eq 0
    end
  end

  describe '#cards_on_table_s' do
    let(:game) { WarGame.new }

    let(:card1) { PlayingCard.new('A', 'Spades') }
    let(:card2) { PlayingCard.new('3', 'Diamonds') }
    let(:card3) { PlayingCard.new('5', 'Hearts') }

    context 'when parameter contains one card' do
      it 'returns cards[0].to_s' do
        cards = [card1]
        result = game.cards_on_table_s(cards)
        expect(result).to eq card1.to_s
      end
    end

    context 'when parameter contains two cards' do
      it 'cards are seperated with an "and a"' do
        cards = [card1, card2]
        result = game.cards_on_table_s(cards)
        expect(result).to eq "#{card1} and a #{card2}"
      end
    end

    context 'when parameter contains more than two cards' do
      it 'cards are seperated with commas and last card has an ", and a"' do
        cards = [card1, card2, card3]
        result = game.cards_on_table_s(cards)
        expect(result).to eq "#{card1}, #{card2}, and a #{card3}"
      end
    end
  end

  describe '#deal' do
    let(:game) { WarGame.new }

    it 'deals 26 cards to each player' do
      game.deal
      p1_cards = game.player1.cards
      p2_cards = game.player2.cards
      halfsize = CardDeck.new.cards_left / 2

      expect(p1_cards.length).to eq halfsize
      expect(p2_cards.length).to eq halfsize
    end
  end

  describe '#round_winner' do
    let(:game) { WarGame.new }
    context 'when player 1 has a bigger value' do
      it 'returns player 1' do
        game = WarGame.new
        winning_card = PlayingCard.new('A', 'Spades')
        losing_card = PlayingCard.new('2', 'Spades')
        game.player1.add_card(winning_card)
        game.player2.add_card(losing_card)

        expect(game.round_winner).to eq game.player1
      end
    end

    context 'when player 2 has a bigger value' do
      it 'returns player 2' do
        winning_card = PlayingCard.new('A', 'Spades')
        losing_card = PlayingCard.new('2', 'Spades')
        game.player1.add_card(losing_card)
        game.player2.add_card(winning_card)

        expect(game.round_winner).to eq game.player2
      end
    end

    context 'when values are equal' do
      it 'returns nil' do
        card1 = PlayingCard.new('A', 'Spades')
        card2 = PlayingCard.new('A', 'Hearts')
        game.player1.add_card(card1)
        game.player2.add_card(card2)

        expect(game.round_winner).to be_nil
      end
    end
  end

  describe '#winner' do
    let(:game) { WarGame.new }

    context 'when both players still have cards' do
      it 'return nil' do
        winning_card = PlayingCard.new('A', 'Spades')
        losing_card = PlayingCard.new('2', 'Spades')
        game.player1.add_card(winning_card)
        game.player2.add_card(losing_card)

        result = game.winner
        expect(result).to be_nil
      end
    end

    context 'when player 1 runs out of cards' do
      it 'return player2' do
        card = PlayingCard.new('A', 'Spades')
        game.player2.add_card(card)

        result = game.winner
        expect(result).to eq game.player2
      end
    end

    context 'when player 2 runs out of cards' do
      it 'return player1' do
        card = PlayingCard.new('A', 'Spades')
        game.player1.add_card(card)

        result = game.winner
        expect(result).to eq game.player1
      end
    end
  end

  describe '#play_round' do
    let(:game) { WarGame.new }

    context 'when player 1 higher card' do
      it 'player 1 wins the cards' do
        # GIVEN
        winning_card = PlayingCard.new('A', 'Spades')
        losing_card = PlayingCard.new('2', 'Spades')

        game.player1.add_card(winning_card)
        game.player2.add_card(losing_card)

        # WHEN
        result = game.play_round

        # THEN:
        expect(game.player1.card_count).to eq 2
        expect(game.player2.card_count).to eq 0
        expect(result).to eq 'Player 1 took a 2 of Spades with a A of Spades'
      end
    end

    context 'when player 2 higher card' do
      it 'player 2 wins the cards' do
        # GIVEN
        winning_card = PlayingCard.new('K', 'Diamonds')
        losing_card = PlayingCard.new('3', 'Hearts')

        game.player1.add_card(losing_card)
        game.player2.add_card(winning_card)

        # WHEN
        result = game.play_round

        # THEN:
        expect(game.player1.card_count).to eq 0
        expect(game.player2.card_count).to eq 2
        expect(result).to eq 'Player 2 took a 3 of Hearts with a K of Diamonds'
      end
    end

    context 'tie' do
      it 'play_round is called until a player wins and all cards are added to winning player' do
        # GIVEN
        card1 = PlayingCard.new('K', 'Diamonds')
        card2 = PlayingCard.new('K', 'Hearts')

        card3 = PlayingCard.new('2', 'Diamonds')
        winning_card = PlayingCard.new('4', 'Spades')

        game.player1.add_card(card1)
        game.player2.add_card(card2)

        game.player1.add_card(card3)
        game.player2.add_card(winning_card)

        # WHEN
        result = game.play_round

        # THEN:
        expect(game.player1.card_count).to eq 0
        expect(game.player2.card_count).to eq 4
        expect(result).to eq 'Player 2 took a K of Diamonds, K of Hearts, and a 2 of Diamonds with a 4 of Spades'
      end
    end
  end

  describe '#opposite_player' do
    let(:game) { WarGame.new }

    context 'when parameter is player 1' do
      it 'returns player 2' do
        result = game.opposite_player(game.player1)
        expect(result).to eq game.player2
      end
    end

    context 'when parameter is player 2' do
      it 'returns player 1' do
        result = game.opposite_player(game.player2)
        expect(result).to eq game.player1
      end
    end

    context 'when parameter is nil' do
      it 'returns nil' do
        result = game.opposite_player(nil)
        expect(result).to be_nil
      end
    end
  end
end
