require 'json'
require_relative 'go'
require_relative 'property'
require_relative 'board'
require_relative 'player'

class WovenMonopoly
    attr_reader :board, :turn_num, :curr_player, :dice_rolls, :players

    def initialize(spaces_file_path, player_names, dice_rolls_file_path)
        @board = Board.new(load_spaces(spaces_file_path))
        @players = load_player(player_names)
        @dice_rolls = JSON.parse(File.read(dice_rolls_file_path))
        @turn_num = 0
        @curr_player = get_current_player
    end

    def start_game
        until @curr_player.bankrupt? || turn_num > @dice_rolls.length
            @curr_player = get_current_player
            take_turn(@curr_player)

            @turn_num += 1
        end

        puts "#{@curr_player.name} is bankrupt"
        puts @curr_player
        puts 'Game Over'
    end

    private

    def get_current_player(turn_num = @turn_num)
        @players[turn_num % @players.length]
    end

    def take_turn(player)
        roll = @dice_rolls[@turn_num % @dice_rolls.length]
        @curr_player.move(roll, @board.size)
        @board.land_on(player)
    end

    def load_spaces(spaces_file_path)
        spaces_json = JSON.parse(File.read(spaces_file_path))

        spaces = []
        properties = {}
        spaces_json.each do |s|
            case s['type']
            when 'go'
                spaces << Go.new(s['name'])
            when 'property'
                # TODO: ask how much rent cost
                spaces << Property.new(s['name'], s['price'], s['colour'], s['price'])
                properties[s['colour']] ||= 0
                properties[s['colour']] += 1
            end
        end

        Property.properties_num_by_color(properties)

        spaces
    end

    def load_player(player_names)
        players = []
        player_names.each do |player_name|
            players << Player.new(player_name)
        end

        players
    end
end

if __FILE__ == $0
    spaces_fp = 'C:\Users\oohpi\OneDrive\Documents\GitHub\Woven-Monopoly-Pronto\WovenMonopoly\data\board.json'
    rolls_1_fp = 'C:\Users\oohpi\OneDrive\Documents\GitHub\Woven-Monopoly-Pronto\WovenMonopoly\data\rolls_1.json'
    # rolls_2_fp = 'C:\Users\oohpi\OneDrive\Documents\GitHub\Woven-Monopoly-Pronto\WovenMonopoly\data\board.json'
    players = %w[Peter Billy Charlotte Sweedal]
    # Property.new(spaces_data[0])

    wm_game = WovenMonopoly.new(spaces_fp, players, rolls_1_fp)
    wm_game.start_game
end
