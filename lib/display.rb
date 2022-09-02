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
    5.downto(0) do |y|
      7.times do |x|
        position = @board..state[x, y]
        print '⦿'.red.on_light_black if position == 1
        print '⦿'.yellow.on_light_black if position == 2
        print '◯'.white.on_light_black if position == 0
      end
    end
  end

  def message_que
    @que ||= []
  end

  def messages
    {
      welcome: "Welcome to Connect 4, get 4 in a Row to win",
      turn_instructions: "#{@current_player == 1 ? 'Red' : 'Yellow'} Players turn",
      input_instructions: "Enter a column number 1 to 7",
      invalid_input: "Oops! Enter a number 1 to 7",
      invalid_turn: "That column's full! Try another",
      win: "#{@current_player == 1 ? 'Red' : 'Yellow'} Player Wins!"
    }
  end
end