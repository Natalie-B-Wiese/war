require 'socket'
require_relative '../lib/war_socket_server'

class MockWarSocketClient
  attr_reader :socket
  attr_reader :output

  def initialize(port)
    @socket = TCPSocket.new('localhost', port)
  end

  def provide_input(text)
    @socket.puts(text)
  end

  def capture_output(delay=0.1)
    sleep(delay)
    @output = @socket.read_nonblock(1000) # not gets which blocks
  rescue IO::WaitReadable
    @output = ""
  end

  def close
    @socket.close if @socket
  end
end

describe WarSocketServer do
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

  it "is not listening on a port before it is started"  do
    @server.stop
    expect {MockWarSocketClient.new(@server.port_number)}.to raise_error(Errno::ECONNREFUSED)
  end

  it 'clients get a welcome message' do
    client1=MockWarSocketClient.new(@server.port_number)
    @clients.push client1
    @server.accept_new_client('Player 1')
    expect(client1.capture_output).to match /welcome/i

  end

  it "all players get a starting message when the second client joins" do
    client1 = MockWarSocketClient.new(@server.port_number)
    @clients.push(client1)
    @server.accept_new_client("Player 1")
    client1.capture_output
    
    client2 = MockWarSocketClient.new(@server.port_number)
    @clients.push(client2)
    @server.accept_new_client("Player 2")

    @server.create_game_if_possible
    expect(client1.capture_output).to match /starting/i
    expect(client2.capture_output).to match /starting/i

  end

  it "accepts new clients and starts a game if possible" do
    client1 = MockWarSocketClient.new(@server.port_number)
    @clients.push(client1)
    @server.accept_new_client("Player 1")
    @server.create_game_if_possible
    expect(@server.games.count).to be 0


    client2 = MockWarSocketClient.new(@server.port_number)
    @clients.push(client2)
    @server.accept_new_client("Player 2")
    @server.create_game_if_possible
    expect(@server.games.count).to be 1
  end

  # Add more tests to make sure the game is being played
  # For example:
  #   make sure the mock client gets appropriate output
  #   make sure the next round isn't played until both clients say they are ready to play
  #   ...

  describe '#clients_ready?' do
    let(:client1) {MockWarSocketClient.new(@server.port_number)}
    let(:client2) {MockWarSocketClient.new(@server.port_number)}
      
    before do
      @clients.push client1
      @server.accept_new_client('Player 1')

      @clients.push client2
      @server.accept_new_client('Player 2')

    end

    context 'when both clients are not ready' do
      it 'returns false' do
        @server.clients[0].is_ready=false
        @server.clients[1].is_ready=false

        result=@server.clients_ready?

        expect(result).to eq false
      end
      
    end

    context 'when one client is not ready and one is' do
      it 'returns false' do
        @server.clients[0].is_ready=false
        @server.clients[1].is_ready=true

        result=@server.clients_ready?

        expect(result).to eq false
        
      end
    end

    context 'when all clients are ready' do

      it 'calls check_ready! on all clients' do
        @server.clients[0].is_ready=true
        @server.clients[1].is_ready=true

        expect(@server.clients[0]).to receive(:check_ready!)
        expect(@server.clients[1]).to receive(:check_ready!)

        @server.clients_ready?
        
      end

      it 'returns true' do
        @server.clients[0].is_ready=true
        @server.clients[1].is_ready=true

        result=@server.clients_ready?

        expect(result).to eq true
        
      end
      
    end
    

    

    




  end


end
