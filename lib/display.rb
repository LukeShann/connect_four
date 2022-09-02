require 'colorize'

module Display
  def message(message)
    message_que.push(message)
    message_que.shift if message_que.length > 3
    display
  end

  def display
    system "clear"
    display_board

    message_que.each do |message|
      puts messages[message].blue
    end
  end

  def display_board
    1.upto(7) { |i| print ' '.on_black, i.to_s.light_magenta.on_black, ' '.on_black }
    puts
    5.downto(0) do |y|
      7.times do |x|
        position = @board.state[x][y]
        print ' '.on_black
        print '⦿'.light_red.on_black if position == 1
        print '⦿'.yellow.on_black if position == 2
        print '●'.black.on_black if position == 0
        print ' '.on_black
      end
      puts
    end
  end

  def message_que
    @que ||= []
  end

  def messages
    {
      welcome: "Welcome to Connect 4, get 4 in a Row to win",
      turn_instructions: "#{@current_player == 1 ? 'Red' : 'Yellow'} Player's turn",
      input_instructions: "Enter a column number 1 to 7",
      invalid_input: "Oops! Enter a number 1 to 7",
      invalid_turn: "That column's full! Try another",
      win: "#{@current_player == 1 ? 'Red' : 'Yellow'} Player Wins!"
    }
  end
end