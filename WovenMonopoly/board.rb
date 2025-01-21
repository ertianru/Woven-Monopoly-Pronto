class Board
    attr_accessor :spaces, :players, :dice_rolls

    def initialize(spaces, players, dice_rolls)
        @spaces = spaces
        @players = players
        @dice_rolls = dice_rolls
    end
end
