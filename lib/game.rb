class Game
  MAX_TURNS = 9
  def initialize
    @board = %w[1 2 3 4 5 6 7 8 9]
    @choices = %w[1 2 3 4 5 6 7 8 9]
    @winning_options = [%w[1 2 3], %w[4 5 6], %w[7 8 9], %w[1 4 7], %w[2 5 8], %w[3 6 9], %w[1 5 9], %w[3 5 7]]
    start_game
  end

  private

  def start_game
    set_up_game
    draw_start_message
    take_turns
  end

  def set_up_game
    @player1 = Player.new('Player 1', 'x')
    @player2 = Player.new('Player 2', 'o')
    @current_player = @player1
    @turns = 0
    @winner = nil
  end

  def draw_start_message
    puts ' '
    puts 'Hi there, how about a quick game of tic, tac, toe?'
    puts 'Its a two player game, player 1 starts'
    puts ''
  end

  def draw_board
    puts '-----------------------'
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts '---+---+---'
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts '---+---+---'
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    puts ' '
  end

  def take_turns
    until @winner
      get_player_choice
      check_result
      prepare_new_turn
    end
  end

  def get_player_choice
    puts '-----------------------'
    puts "#{@current_player.name} make your choice (#{@current_player.sign})"
    draw_board
    loop do
      this_choice = gets.chomp
      if @choices.include?(this_choice) && this_choice != @player1.sign && this_choice != @player2.sign
        update_choices(this_choice)
        break
      else
        puts 'Please choose one of the available choices on the board'
      end
    end
  end

  def update_choices(choice)
    @board[choice.to_i - 1] = @current_player.sign
    @choices -= [choice]
    @current_player.add_choice(choice)
  end

  def check_result
    @winning_options.each do |option|
      next unless option.all? { |element| @current_player.choices.include?(element) }

      draw_board
      puts '-----------------------'
      puts "#{@current_player.name.upcase} (#{@current_player.sign}) WINS!!!!!!!"

      @winner = @current_player
    end
  end

  def prepare_new_turn
    @turns += 1
    if @turns == MAX_TURNS
      draw_board
      puts "It's a draw - The Game is over"
      @winner = "It's a draw"
    else
      @current_player = if @current_player == @player1
                          @player2
                        else
                          @player1
                        end
    end
  end
end
