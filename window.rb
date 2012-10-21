require 'curses'
class Window < Curses::Window
  @@window = 1
  include Curses
  noecho
  def initialize
    if @@window = 1
      @window = Curses::Window.new(Curses.lines/2,0,0,0)
    else
      @window = Curses::Window.new(Curses.lines/2,0,Curses.lines,0)
    end
    @window.scrollok(true)
  end
end