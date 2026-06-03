class ServerGame
  attr_reader :clients, :game

  def initialize(clients, game_type=WarGame)
    @clients=clients
    @game=game_type.new
  end


  def clients_ready?
    clients.each do |client|
      client.check_ready!
      return false unless client.ready?
    end
    true
  end

  # untested
  def start
    game.start
  end

  # untested
  def play_round
    game.play_round
  end

  #  war_runner code:
  #   game.start

  #   until game.winner do
  #     player_ready?

  #     puts game.play_round
  #   end
  #   puts "Winner: #{game.winner.name}"

end