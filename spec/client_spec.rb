require 'socket'
require_relative '../lib/war_socket_server'

require_relative '../lib/client'

require_relative '../lib/server_game'
require_relative '../lib/war_game'
require_relative 'mock_war_socket_client'
require_relative 'mock_war_socket'

# initialize(socket, name)
# Sets @socket to socket
# sets @name to name
# initializes is_ready and is_message_sent to false
describe Client do
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
    let(:socket) { MockWarSocket.new }
    let(:client) { Client.new(socket, 'Player 1') }

    # @clients.push client1
    # @server.accept_new_client('Player 1')
    # expect(client1.capture_output).to match /welcome/i

    it 'sets socket correctly' do
      expect(client.socket).to eq socket
    end
    it 'sets name correctly' do
      expect(client.name).to eq 'Player 1'
    end

    it 'sets is_ready to false' do
      expect(client.is_ready).to eq false
    end

    it 'sets is_message to false' do
      expect(client.is_message_sent).to eq false
    end
  end

  # puts (message)
  describe '#puts' do
    let(:socket) { MockWarSocket.new }
    let(:client) { Client.new(socket, 'Player 1') }

    # prints the specified message to the socket by using a puts
    it 'calls puts to the socket' do
      message = 'Hello world'
      expect(socket).to receive(:puts).with(message)
      client.puts(message)
    end
  end

  # ready?
  # returns true if @is_ready is true
  # returns false if @is_ready is false
  describe '#ready?' do
    let(:socket) { MockWarSocket.new }
    let(:client) { Client.new(socket, 'Player 1') }

    context 'when is_ready is false' do
      it 'returns false' do
        client.is_ready = false
        result = client.ready?
        expect(result).to eq false
      end
    end

    context 'when is_ready is true' do
      it 'returns true' do
        client.is_ready = true
        result = client.ready?
        expect(result).to eq true
      end
    end
  end

  describe '#received_message?' do
    let(:socket) { MockWarSocket.new }
    let(:client) { Client.new(socket, 'Player 1') }

    context 'when is_message_sent is false' do
      it 'returns false' do
        client.is_message_sent = false
        result = client.received_message?
        expect(result).to eq false
      end
    end

    context 'when is_message_sent is true' do
      it 'returns true' do
        client.is_message_sent = true
        result = client.received_message?
        expect(result).to eq true
      end
    end
  end
end
