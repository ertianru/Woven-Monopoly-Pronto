class Dice
    attr_reader :dice_rolls

    def initialize(dice_rolls_file_path)
        @dice_rolls = JSON.parse(File.read(dice_rolls_file_path))
    end

    def roll(turn_num)
        @dice_rolls[turn_num % @dice_rolls.length]
    end

    def end?(turn_num)
        turn_num >= @dice_rolls.length
    end
end
