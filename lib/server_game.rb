class ServerGame
  attr_reader :client1, :client2, :game

  def initialize(client1, client2, game_type=WarGame)
    @client1=client1
    @client2=client2

    @game=game_type.new
  end

  #  war_runner code:
  #   game.start

  #   until game.winner do
  #     player_ready?

  #     puts game.play_round
  #   end
  #   puts "Winner: #{game.winner.name}"

end