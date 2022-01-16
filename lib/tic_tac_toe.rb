class Player
  attr_accessor :name, :choices, :sign

  def initialize(name, sign, choices = [])
    @name = name
    @choices = choices
    @sign = sign
  end
end

class Board
  attr_accessor :board

  def initialize
    @board = Array.new
    @first_row = [1, 2, 3]
    @second_row = [4, 5, 6]
    @third_row = [7, 8, 9]
    @board.push(@first_row, @second_row, @third_row)
  end

  def display_board(board)
    board.each { |row| p row }
  end
end

class TicTacToe < Board
  attr_accessor :round, :player_1, :player_2, :board

  def initialize(player_1, player_2)
    @player_1 = Player.new(player_1, 'X')
    @player_2 = Player.new(player_2, 'O')
    @round = 0
    @game_over = false
    new_game = Board.new
    @board = new_game.board
    start_game
  end

  def start_game
    while @round <= 9 && !@game_over
      make_move(@player_1)
      make_move(@player_2) if !@game_over
    end
  end

  def make_move(player)
    cell_replace(player, cell_select(player))
    update_round
    display_board(@board)
    check_winner(player)
  end

  def cell_select(player)
    num = 0
    until num.between?(1,9)
      puts "#{player.name} choose a cell between 1 and 9"
      num = gets.to_i
    end
    num
  end

  def cell_replace(player, value)
    @board.each_with_index do |row, index|
      row.each_with_index do |cell, i|
        if cell == value
          row[i] = player.sign
          player.choices.push([index,i])
        end
      end
    end
  end

  def update_round
    @round += 1
  end

  SOLUTIONS = [[[0,0],[1,0],[2,0]],
  [[0,0],[1,1],[2,2]],
  [[0,0],[0,1],[0,2]],
  [[0,1],[1,1],[2,1]],
  [[0,2],[1,2],[2,2]],
  [[0,2],[1,1],[2,0]],
  [[1,0],[1,1],[1,2]],
  [[2,0],[2,1],[2,2]]]

  def game_over(player)
    @game_over = true
    p "#{player.name} wins!"
  end

  def check_winner(player)
    SOLUTIONS.each do |solution|
      winner = 0
      player.choices.each do |choice|
        winner += 1 if solution.include? choice
      end
      game_over(player) if winner == 3
    end
  end
end

# game = TicTacToe.new('Ash', 'Pikachu')
