require 'json'
require_relative 'dice'
require_relative 'board'
require_relative 'player'
require 'logger'

# WovenMonopoly class represents the main game logic.
# It manages the game board, players, dice rolls, and the game flow.
class WovenMonopoly
    # @return [Board] the game board
    # @return [Integer] the current turn number
    # @return [Player] the current player
    # @return [Dice] the dice used for rolling
    # @return [Array<Player>] the list of players
    attr_reader :board, :turn_num, :curr_player, :dice, :players

    # Initializes a new game of WovenMonopoly.
    #
    # @param spaces_file_path [String] the file path to the JSON file containing the board spaces
    # @param player_names [Array<String>] the names of the players
    # @param dice_rolls_file_path [String] the file path to the JSON file containing the dice rolls
    def initialize(spaces_file_path, player_names, dice_rolls_file_path)
        @board = Board.new(spaces_file_path)
        @players = load_players(player_names)
        @dice = Dice.new(dice_rolls_file_path)
        @turn_num = 0
        @curr_player = get_current_player
    end

    # Starts the game and manages the game loop until a player goes bankrupt or the dice rolls end.
    #
    # @return [Hash] a hash containing the winner and the final standings of the players
    def start_game
        until @curr_player.bankrupt? || dice.end?(@turn_num)
            @curr_player = get_current_player
            take_turn(@curr_player)

            @turn_num += 1
        end

        winner = determine_winner
        puts_game_over_msg(winner)

        { winner: winner, standings: @players }
    end

    private

    # Outputs the game over message, including the winner and the standings of all players.
    #
    # @param winner [Player] the player who has won the game
    #
    # @return [void]
    def puts_game_over_msg(winner)
        puts "#{@curr_player.name} is bankrupt"
        puts @curr_player
        puts '=================================================================='
        puts 'Game Over'

        space = @board.get_space(winner.position)
        puts '=================================================================='
        puts "Winner is\n#{winner}"
        puts "    Space: #{space.name}"
        puts '=================================================================='
        puts 'Standings'
        @players.each do |player|
            space = @board.get_space(player.position)
            puts player
            puts "    Space: #{space.name}"
            puts "\n"
        end
    end

    # Determines the winner of the game based on the player with the most money.
    #
    # @return [Player] the player with the most money
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

    # Gets the current player based on the turn number.
    #
    # @param turn_num [Integer] the current turn number (default: @turn_num)
    # @return [Player] the current player
    def get_current_player(turn_num = @turn_num)
        @players[turn_num % @players.length]
    end

    # Manages the actions taken during a player's turn, including rolling the dice and moving the player.
    #
    # @param player [Player] the player taking the turn
    def take_turn(player)
        roll = @dice.roll(@turn_num)
        puts "#{player.name}'s rolls #{roll}"

        prev_pos = @curr_player.position
        @curr_player.move(roll, @board.size)

        @board.pass_go(player) if @curr_player.position < prev_pos
        @board.land_on(player)
    end

    # Loads the players based on the provided player names.
    #
    # @param player_names [Array<String>] the names of the players
    # @return [Array<Player>] the list of players
    def load_players(player_names)
        players = []
        player_names.each do |player_name|
            players << Player.new(player_name)
        end

        players
    end
end

# Main entry point for the game. Initializes and starts the game with the provided file paths and player names.
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
