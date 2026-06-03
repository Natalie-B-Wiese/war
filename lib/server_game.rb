class ServerGame
  attr_reader :clients, :game

  def initialize(clients, game_type=WarGame)
    @clients=clients
    @game=game_type.new
  end


  def clients_ready?
    clients.each do |client|
      client.check_ready!
    end
    clients.all? {|client| client.ready? }
  end

  # returns the array of clients that are ready
  def ready_clients
    clients.select {|client| client.ready? }
  end

  # Should this jsut be part of the initailize method of this server game?
  def start
    game.start
  end


  def try_play_round
    if clients_ready?
      clients.each {|client| client.puts "Both players are ready!"}
      play_round
    else
      ready_clients.each do |client|
        client.puts("Waiting for remaining players to confirm...")
      end
    end
  end

  # untested
  def winner
    game.winner
  end

  private
  def play_round
    game.play_round
  end

end