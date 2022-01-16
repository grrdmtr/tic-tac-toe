require_relative '../lib/tic_tac_toe'

# Refactoring old code by TDD method

describe TicTacToe do

  subject(:player) { Player.new('Ash', 'X')}
  subject(:game) { described_class.new('Ash', 'Pikachu') }

  describe '#check_winner' do

    it 'sends message to check winner' do
      expect(@player_1).to receive(:check_winner).once
      check_winner(@player_1)
    end
  end

end
