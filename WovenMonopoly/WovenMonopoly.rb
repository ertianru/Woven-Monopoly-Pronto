require 'json'
require_relative 'go'
require_relative 'property'
require_relative 'board'

class WovenMonopoly
    attr_accessor :board

    def initialize(spaces_file_path, players, dice_rolls_file_path)
        @board = Board.new(load_spaces(spaces_file_path), players,
                           JSON.parse(File.read(dice_rolls_file_path)))
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
                spaces << Property.new(s['name'], s['price'], s['color'])
            end
        end

        spaces
    end
end

if __FILE__ == $0
    spaces_fp = 'C:\Users\oohpi\OneDrive\Documents\GitHub\Woven-Monopoly-Pronto\WovenMonopoly\data\board.json'
    rolls_1_fp = 'C:\Users\oohpi\OneDrive\Documents\GitHub\Woven-Monopoly-Pronto\WovenMonopoly\data\board.json'
    # rolls_2_fp = 'C:\Users\oohpi\OneDrive\Documents\GitHub\Woven-Monopoly-Pronto\WovenMonopoly\data\board.json'
    players = %w[
        Peter
        Billy
        Charlotte
        Sweedal
    ]
    # Property.new(spaces_data[0])

    WovenMonopoly.new(spaces_fp, players, rolls_1_fp)
end
