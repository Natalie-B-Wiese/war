require_relative '../lib/server_game'
require_relative '../lib/war_game'

describe ServerGame do
  describe '#initialize' do
    # initialize(client1, client2, game_type=WarGame)
    let(:client1) {"first client"}
    let(:client2) {"second client"}
    let(:game_type) {WarGame}

    it 'assigns @client1 to client1 parameter' do
      game=described_class.new(client1, client2, game_type)
      expect(game.client1).to eq client1
    end

    it 'assigns @client2 to client2 parameter' do
      game=described_class.new(client1, client2, game_type)
      expect(game.client2).to eq client2
    end

    it 'creates a new game of specified type and assigns it to @game' do
      game=described_class.new(client1, client2, game_type)
      expect(game.game).to be_a(game_type)
    end

  end

end