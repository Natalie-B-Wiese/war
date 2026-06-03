require 'socket'

class Client
  attr_reader :socket, :name
  attr_accessor :is_ready, :is_message_sent, :is_waiting_message_sent

  def initialize(socket, name)
    @socket = socket
    @name = name
    @is_ready = false
    @is_message_sent = false
    @is_waiting_message_sent = false
  end

  def reset_variables
    @is_message_sent = false
    @is_ready = false
    @is_waiting_message_sent = false
  end

  def puts(message)
    socket.puts(message)
  end

  def ready?
    !!@is_ready
  end

  def try_send_waiting_for_player_message
    puts 'Waiting for remaining players to confirm...' unless received_waiting_message?
    self.is_waiting_message_sent = true
  end

  def received_message?
    !!@is_message_sent
  end

  def received_waiting_message?
    !!@is_waiting_message_sent
  end

  def check_ready!
    return if ready?

    socket.puts 'Are you ready? ->' unless received_message?
    self.is_message_sent = true
    self.is_ready = !read_socket.empty?
  end

  def read_socket
    socket.read_nonblock(1000)
  rescue IO::WaitReadable
    ''
  end
end
