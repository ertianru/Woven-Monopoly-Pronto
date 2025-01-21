class Board
    attr_accessor :spaces, :players, :dice_rolls, :game_over
    attr_reader :turn_num

    def initialize(spaces, players, dice_rolls)
        @spaces = spaces
        @players = players
        @dice_rolls = dice_rolls
        @turn_num = 0
    end

    def start_game
        @turn_num = 0
        until @game_over || turn_num > @dice_rolls.length
            player = @players[@turn_num % @players.length]
            take_turn(player)
            @turn_num += 1
        end
    end

    private

    def take_turn(player)
        roll = @dice_rolls[@turn_num % @dice_rolls.length]

        player.position = (player.position + roll) % @spaces.length
        @spaces[player.position].land_on(player)
    end
end
