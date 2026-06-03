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
    let(:client1_socket) {MockWarSocketClient()}
    # initialize(client1, client2, game_type=WarGame)
    let(:client1) {MockClient.new('socket', 'Client 1')}
    let(:client2) {MockClient.new('socket', 'Client 2')}
    let(:clients) {[client1, client2]}
    let(:game_type) {WarGame}

    it 'assigns @clients to clients parameter' do
      game=described_class.new(clients, game_type)
      expect(game.clients).to eq clients
    end

    it 'creates a new game of specified type and assigns it to @game' do
      game=described_class.new(clients, game_type)
      expect(game.game).to be_a(game_type)
    end

  end

  describe '#clients_ready?' do
    let(:client1) {MockClient.new('socket', 'Client 1')}
    let(:client2) {MockClient.new('socket', 'Client 2')}
    let(:game_type) {WarGame}
    let(:server_game) {ServerGame.new([client1, client2], game_type)}

    context 'when all clients are not ready' do
      it 'returns false' do
        

        # server_game.clients[0].is_ready=false
        # server_game.clients[1].is_ready=false

        # result=server_game.clients_ready?

        # expect(result).to eq false
      end
      
    end

    context 'when first client is not ready and second one is' do
      it 'returns false' do
        server_game.clients[0].is_ready=false
        server_game.clients[1].is_ready=true

        result=server_game.clients_ready?

        expect(result).to eq false
        
      end
    end

    context 'when all clients are ready' do

      it 'calls check_ready! on all clients' do
        server_game.clients[0].is_ready=true
        server_game.clients[1].is_ready=true

        expect(server_game.clients[0]).to receive(:check_ready!)
        expect(server_game.clients[1]).to receive(:check_ready!)

        server_game.clients_ready?
        
      end

      it 'returns true' do
        server_game.clients[0].is_ready=true
        server_game.clients[1].is_ready=true

        result=server_game.clients_ready?

        expect(result).to eq true
        
      end
      
    end
    
  end

end