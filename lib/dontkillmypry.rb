
class Pry
  def self.pry_in_use=(value)
    @pry_in_use = value
  end

  def self.pry_in_use
    @pry_in_use ||= false
  end
end

Pry.config.hooks.add_hook(:before_session, :pry_in_use) do
  Pry.pry_in_use = true
end

Pry.config.hooks.add_hook(:after_session, :pry_in_use) do
  Pry.pry_in_use = false
end

module Capybara::Poltergeist
  class WebSocketServer
    # Block until the next message is available from the Web Socket.
    # Raises Errno::EWOULDBLOCK if timeout is reached.
    def receive
      start = Time.now

      until @messages.any?
        raise Errno::EWOULDBLOCK if not debugging and (Time.now - start) >= timeout
        begin
          IO.select([socket], [], [], select_timeout) or raise Errno::EWOULDBLOCK
        rescue
          raise unless debugging
        end
        data = socket.recv(RECV_SIZE)
        break if data.empty?
        driver.parse(data)
      end

      @messages.shift
    end

    def debugging
      Pry.pry_in_use
    end

    def select_timeout
      if debugging
        nil
      else
        timeout
      end
    end
  end
end
