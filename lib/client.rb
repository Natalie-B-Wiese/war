require 'socket'

class Client

  attr_reader :socket, :name
  attr_accessor :is_ready, :is_message_sent

  def initialize(socket, name)
    @socket=socket
    @name=name
    @is_ready=false
    @is_message_sent=false
  end

  def puts(message)
    socket.puts(message)
  end

  def ready?
    !!@is_ready
  end

  def received_message?
    !!@is_message_sent
  end


  def check_ready!
    return if ready?
    socket.puts 'Are you ready?' unless received_message?
    self.is_message_sent=true
    read_socket
    self.is_ready = (@output!='')
  end

  def read_socket
    @output=socket.read_nonblock(1000)
  rescue IO::WaitReadable
    @output=''
  end


end