require 'socket'

class WarSocketServer
  NUM_PLAYERS_PER_GAME=2

  def initialize
  end

  def port_number
    3336
  end

  def games
    @games ||= []
  end

  def start
    @server = TCPServer.new(port_number)
  end

  def clients
    # if instance variable exists return it, otherwise set it to []
    @clients ||= []
  end

  def accept_new_client(player_name = "Random Player")
    client = @server.accept_nonblock
    clients << client
    # associate player and client
    client.puts 'Welcome to War!'
  rescue IO::WaitReadable, Errno::EINTR
    puts "No client to accept"
  end

  def create_game_if_possible
    return unless clients.count == NUM_PLAYERS_PER_GAME

    clients.each do |client|
      client.puts 'War is starting...'
    end

    # check if there are two clients
    games << 1

  end

  def stop
    @server.close if @server
  end
end
