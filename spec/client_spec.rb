require 'socket'

require_relative '../lib/client'

class MockSocket
  def puts(message)
    return message
  end

  def read_nonblock(bytes)
    return true
  end
end

#initialize(socket, name)
  #Sets @socket to socket
  #sets @name to name
  # initializes is_ready and is_message_sent to false
describe Client do
  describe '#initialize' do
    let(:socket) { 'socket' }
    let(:client) {Client.new(socket, 'Player 1')}

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
    let(:socket) { MockSocket.new }
    let(:client) {Client.new(socket, 'Player 1')}

    # prints the specified message to the socket by using a puts
    it 'calls puts to the socket' do
      result=client.puts('Hello world')
      expect(result).to eq 'Hello world'
    end

  end

  # ready?
  # returns true if @is_ready is true
  # returns false if @is_ready is false
  describe '#ready?' do
    let(:socket) { MockSocket.new }
    let(:client) {Client.new(socket, 'Player 1')}

    context 'when is_ready is false' do
      it 'returns false' do
        client.is_ready=false
        result=client.ready?
        expect(result).to eq false
      end
    end

    context 'when is_ready is true' do
      it 'returns true' do
        client.is_ready=true
        result=client.ready?
        expect(result).to eq true
      end
    end
    
  end

  describe '#received_message?' do
    let(:socket) { MockSocket.new }
    let(:client) {Client.new(socket, 'Player 1')}

    context 'when is_message_sent is false' do
      it 'returns false' do
        client.is_message_sent=false
        result=client.received_message?
        expect(result).to eq false
      end
    end

    context 'when is_message_sent is true' do
      it 'returns true' do
        client.is_message_sent=true
        result=client.received_message?
        expect(result).to eq true
      end
    end
    
  end

  # check_ready!
  # if the player is not ready, it prints 'Are you ready?' to the socket
  # It makes is_message_sent to true
  # It updates is_ready based on read_socket
  describe '#check_ready!' do
    let(:socket) { MockSocket.new }
    let(:client) {Client.new(socket, 'Player 1')}

    context 'if the player is not ready and has not received a message' do
      it 'prints Are you ready? to the socket' do
        client.is_ready=false
        client.is_message_sent=false

        expect(socket).to receive(:puts).with('Are you ready?')
        client.check_ready!
      end

      it 'sets is_message_sent to true' do
        client.is_ready=false
        client.is_message_sent=false
        client.check_ready!

        expect(client.is_message_sent).to eq true
      end

      it 'updates is_ready to be value of read_socket' do
        client.is_ready=false
        client.is_message_sent=false
        client.check_ready!
        expect(client.is_ready).to eq true
      end
    end

    context 'if the player is not ready and has received a message' do
      it 'does not print Are you ready? to the socket' do
        client.is_ready=false
        client.is_message_sent=true

        expect(socket).to_not receive(:puts).with('Are you ready?')
        client.check_ready!
      end

      it 'updates is_ready to be value of read_socket' do
        client.is_ready=false
        client.is_message_sent=true
        client.check_ready!
        expect(client.is_ready).to eq true
      end
    end

    context 'if the player is ready' do
      it 'does not print Are you ready? to the socket' do
        client.is_ready=true

        expect(socket).to_not receive(:puts).with('Are you ready?')
        client.check_ready!
      end

      it 'does not call read_socket' do
        client.is_ready=true

        expect(client).to_not receive(:read_socket)
        client.check_ready!
      end

    end

  end


  # TODO: read_socket ?????
  # reads the socket.
  # Returns an output of '' if no output on the socket

end



  