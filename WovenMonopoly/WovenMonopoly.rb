require 'json'
require_relative 'go'
require_relative 'property'
require_relative 'board'
require_relative 'player'

class WovenMonopoly
    attr_reader :board

    def initialize(spaces_file_path, player_names, dice_rolls_file_path)
        @board = Board.new(load_spaces(spaces_file_path), load_player(player_names),
                           JSON.parse(File.read(dice_rolls_file_path)))
    end

    def start_game
        @board.start_game
    end

    private

    def load_spaces(spaces_file_path)
        spaces_json = JSON.parse(File.read(spaces_file_path))

        spaces = []
        spaces_json.each do |s|
            case s['type']
            when 'go'
                spaces << Go.new(s['name'])
            when 'property'
                spaces << Property.new(s['name'], s['price'], s['color'], 2)
            end
        end

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
