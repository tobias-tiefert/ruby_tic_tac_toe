class Game
  MAX_TURNS = 9
  def initialize
    @board = %w[1 2 3 4 5 6 7 8 9]
    @choices = %w[1 2 3 4 5 6 7 8 9]
    @winning_options = [%w[1 2 3], %w[4 5 6], %w[7 8 9], %w[1 4 7], %w[2 5 8], %w[3 6 9], %w[1 5 9], %w[3 5 7]]
  end

  def start_game
    set_up_game
    draw_start_message
    play_game
  end

  def play_game
    take_turns until game_over?
    display_result
  end

  def display_result
    draw_board
    if @winner.nil?
      puts "It's a draw - The Game is over"
    else
      puts '-----------------------'
      puts "#{@winner.name.upcase} (#{@winner.sign}) WINS!!!!!!!"
    end
  end

  def game_over?
    @winner.nil? && @turns < MAX_TURNS ? false : true
  end

  def player_choice
    loop do
      this_choice = gets.chomp
      return this_choice if @choices.include?(this_choice)

      puts 'Please choose one of the available choices on the board'
    end
  end

  def update_choices(choice, player)
    @board[choice.to_i - 1] = player.sign
    @choices -= [choice]
    player.add_choice(choice)
  end

  def check_result(player)
    return unless player_won?(player)

    @winner = player
  end

  def player_won?(player)
    @winning_options.each do |option|
      return true if option.all? { |element| player.choices.include?(element) }
    end
    false
  end

  def prepare_new_turn
    @turns += 1
    @current_player = @turns.even? ? @player1 : @player2
  end

  def set_up_game
    @player1 = Player.new('Player 1', 'x')
    @player2 = Player.new('Player 2', 'o')
    @current_player = @player1
    @turns = 0
    @winner = nil
  end

  private

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
    display_promt
    update_choices(player_choice, @current_player)
    check_result(@current_player)
    prepare_new_turn
  end

  def display_promt
    puts '-----------------------'
    puts "#{@current_player.name} make your choice (#{@current_player.sign})"
    draw_board
  end
end
