require 'json'
require_relative 'dice'
require_relative 'board'
require_relative 'player'

class WovenMonopoly
    attr_reader :board, :turn_num, :curr_player, :dice, :players

    def initialize(spaces_file_path, player_names, dice_rolls_file_path)
        @board = Board.new(spaces_file_path)
        @players = load_players(player_names)
        @dice = Dice.new(dice_rolls_file_path)
        @turn_num = 0
        @curr_player = get_current_player
    end

    def start_game
        until @curr_player.bankrupt? || dice.end?(@turn_num)
            @curr_player = get_current_player
            take_turn(@curr_player)

            @turn_num += 1
        end

        puts "#{@curr_player.name} is bankrupt"
        puts @curr_player
        puts '=================================================================='
        puts 'Game Over'

        winner = determine_winner
        puts '=================================================================='
        puts "Winner is\n#{winner}"
        puts '=================================================================='
        puts 'Standings'
        @players.each do |player|
            space = @board.get_space(player.position)
            puts player
            puts "    Space: #{space.name}"
            puts "\n"
        end

        { winner: winner, standings: @players }
    end

    private

    def determine_winner
        winner = nil
        money = 0
        @players.each do |player|
            if player.money > money
                winner = player
                money = player.money
            end
        end
        winner
    end

    def get_current_player(turn_num = @turn_num)
        @players[turn_num % @players.length]
    end

    def take_turn(player)
        roll = @dice.roll(@turn_num)
        puts "#{player.name}'s rolls #{roll}"

        prev_pos = @curr_player.position
        @curr_player.move(roll, @board.size)

        @board.pass_go(player) if @curr_player.position < prev_pos
        @board.land_on(player)
    end

    def load_players(player_names)
        players = []
        player_names.each do |player_name|
            players << Player.new(player_name)
        end

        players
    end
end

if __FILE__ == $0
    # spaces_fp = 'C:\Users\oohpi\OneDrive\Documents\GitHub\Woven-Monopoly-Pronto\WovenMonopoly\data\board.json'
    # rolls_fp = 'C:\Users\oohpi\OneDrive\Documents\GitHub\Woven-Monopoly-Pronto\WovenMonopoly\data\rolls_1.json'
    # rolls_fp = 'C:\Users\oohpi\OneDrive\Documents\GitHub\Woven-Monopoly-Pronto\WovenMonopoly\data\rolls_2.json'
    players = %w[Peter Billy Charlotte Sweedal]
    spaces_fp = ARGV[0]
    rolls_fp = ARGV[1]

    wm_game = WovenMonopoly.new(spaces_fp, players, rolls_fp)
    wm_game.start_game
end
