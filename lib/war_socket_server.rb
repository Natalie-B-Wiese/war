require 'socket'
require_relative 'server_game'
require_relative 'client'
require_relative 'war_game'

class WarSocketServer

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
    client_socket = @server.accept_nonblock
    client=Client.new(client_socket, player_name)

    clients << client
    # associate player and client
    client.puts 'Welcome to War!'
  rescue IO::WaitReadable, Errno::EINTR
    puts "No client to accept"
  end

  def create_game_if_possible
    return unless clients.count == WarGame::NUM_PLAYERS

    clients.each do |client|
      client.puts 'War is starting...'
    end

    new_game=ServerGame.new([clients[0], clients[1]], WarGame)
    games << new_game

    return new_game

  end

  def run_game(game)
    game.start
    game.try_play_round
  end

  


  def stop
    @server.close if @server
  end
end
