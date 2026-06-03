require 'socket'
require_relative '../lib/war_socket_server'

require_relative '../lib/server_game'
require_relative '../lib/war_game'
require_relative '../lib/client'
require_relative 'mock_war_socket_client'

describe ServerGame do
  before(:each) do
    @clients = []
    @server = WarSocketServer.new
    @server.start
    sleep 0.1 # Ensure server is ready for clients
  end

  after(:each) do
    @server.stop
    @clients.each do |client|
      client.close
    end
  end

  describe '#initialize' do
    let(:client1_socket) { MockWarSocketClient() }
    let(:client1) { 'client1' }
    let(:client2) { 'client2' }
    let(:clients) { [client1, client2] }
    let(:game_type) { WarGame }

    it 'assigns @clients to clients parameter' do
      game = described_class.new(clients, game_type)
      expect(game.clients).to eq clients
    end

    it 'creates a new game of specified type and assigns it to @game' do
      game = described_class.new(clients, game_type)
      expect(game.game).to be_a(game_type)
    end
  end
end
