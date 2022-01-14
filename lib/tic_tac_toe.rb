# class Player
#   attr_accessor :name

#   def initialize(player_number)
#     set_name(player_number)
#   end

#   def set_name(player_number)
#     puts "What is your name?"
#     @name = gets.chomp 
#   end
# end


class Game
  @@board = Array.new
  @@players1_choice = Array.new
  @@players2_choice = Array.new
  @@winner = false
  @@round = 0

  def initialize(player_1, player_2)
    @player_1 = player_1
    @player_2 = player_2
    p @first_row = [1, 2, 3]
    p @second_row = [4, 5, 6]
    p @third_row = [7, 8, 9]
    @@board.push(@first_row, @second_row, @third_row)
    player_1_choice()
  end

  def cell_select(player)
    @num = 0
    until @num.between?(1,9)
      puts "#{player} choose a cell between 1 and 9"
      @num = gets.chomp.to_i
    end
    @num
  end

  def player_1_choice()

    cell_select(@player_1)

    @@board.each_with_index do |row, index|
      row.each_with_index do |cell, i|
        if cell != @num
          cell = cell
        elsif cell == @num
          row[i] = 'X'
          @@players1_choice.push([index,i])
        end
      end
    end
    @@round +=1
    display_board()
    check_winner()
    if @@winner == false && @@round < 9
      player_2_choice()
    else
      p "It's a draw!"
    end
  end

  def player_2_choice()

    cell_select(@player_2)

    @@board.each_with_index do |row, index|
      row.each_with_index do |cell, i|
        if cell != @num
          cell = cell
        elsif cell == @num
          row[i] = 'O'
          @@players2_choice.push([index,i])
        end
      end
    end
    @@round +=1
    display_board()
    check_winner()
    if @@winner == false && @@round < 9
      player_1_choice()
    else
      p "It's a draw!"
    end
  end

  def display_board()
    @@board.each { |row| p row }
  end

  def check_winner()
    @solutions = [[[0,0],[1,0],[2,0]],
                  [[0,0],[1,1],[2,2]],
                  [[0,0],[0,1],[0,2]],
                  [[0,1],[1,1],[2,1]],
                  [[0,2],[1,2],[2,2]],
                  [[0,2],[1,1],[2,0]],
                  [[1,0],[1,1],[1,2]],
                  [[2,0],[2,1],[2,2]]]
    
    @solutions.each do |solution|
      winner_1 = 0
      @@players2_choice.each do |choice|
        if solution.include? choice
          winner_1 +=1
        end
        if winner_1 == 3
          p "#{@player_2} wins!"
          @@winner = true 
        end
      end
    end

    @solutions.each do |solution|
      winner_1 = 0
      @@players1_choice.each do |choice|
        if solution.include? choice
          winner_1 +=1
        end
        if winner_1 == 3
          p "#{@player_1} wins!"
          @@winner = true
        end
      end 
    end
  end
end

game = Game.new('Dima','Paula')
