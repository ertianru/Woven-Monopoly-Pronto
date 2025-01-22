# The Dice class simulates dice rolls based on predefined values from a JSON file.
class Dice
    # @return [Array<Integer>] the array of predefined dice rolls
    attr_reader :dice_rolls

    # Initializes a new Dice object.
    #
    # @param dice_rolls_file_path [String] the file path to the JSON file containing dice rolls
    def initialize(dice_rolls_file_path)
        @dice_rolls = JSON.parse(File.read(dice_rolls_file_path))
    end

    # Returns the dice roll for a given turn number.
    #
    # @param turn_num [Integer] the current turn number
    # @return [Integer] the dice roll for the given turn number
    def roll(turn_num)
        @dice_rolls[turn_num % @dice_rolls.length]
    end

    # Checks if the game has ended based on the turn number.
    #
    # @param turn_num [Integer] the current turn number
    # @return [Boolean] true if the game has ended, false otherwise
    def end?(turn_num)
        turn_num >= @dice_rolls.length
    end
end
