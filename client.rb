require 'socket'
require 'curses'
Curses.noecho
# our window
window1 = Curses::Window.new(Curses.lines/2, 0, 0, 0)
window2 = Curses::Window.new(Curses.lines/2, 0, Curses.lines/2, 0)
window1.scrollok(true)
window2.scrollok(true)

s = TCPSocket.new *ARGV


# read input
Thread.new do
  loop do
    byte = Curses.getch

    # and write to curses in top window
    if byte == "\x7F" || byte == 127
      window1.addch "\ch"
    else
      window1.addch byte
    end

    window1.addch "\n" if byte == "\n"
    window1.refresh

    s.putc byte
  end
end

# client will read bytes in from server
while byte = s.read(1) # Read lines from server
  if byte == "\x7F" || byte == 127
    window2.addch "\ch"
  else
    window2.addch byte
  end
  window2.refresh
  # alert us on ESC i.e. PING
  `say hello are you there?` if byte == "\e"
end
