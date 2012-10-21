require 'socket'
require 'curses'
Curses.noecho
# our window
window1 = Curses::Window.new(Curses.lines/2, 0, 0, 0)
window2 = Curses::Window.new(Curses.lines/2, 0, Curses.lines/2, 0)
window1.scrollok(true)
window2.scrollok(true)

server = TCPServer.new *ARGV
client = server.accept

# get input
Thread.new do
  loop do
    window2.addstr "client connected\n"
    window2.refresh
    loop do
      # get input from user
      byte = Curses.getch

      # and write to curses in top window
      if byte == "\x7F" || byte == 127
        window1.addch "\ch"
      else
        window1.addch byte
      end

      window1.addch "" if byte == "\n"
      window1.refresh

      client.putc byte

    end
  end
end
# get data from client
while byte = client.read(1)
  if byte == "\x7F" || byte == 127
    window2.addch "\ch"
  else
    window2.addch byte
  end

  window2.refresh
end


