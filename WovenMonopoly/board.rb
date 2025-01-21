class Board
    attr_accessor :spaces, :players, :dice_rolls
    attr_reader :turn_num, :properties, :curr_player

    def initialize(spaces, players, dice_rolls)
        @spaces = spaces
        @players = players
        @dice_rolls = dice_rolls
        @turn_num = 0
        @curr_player = @players[@turn_num % @players.length]
    end

    def start_game
        until @curr_player.bankrupt? || turn_num > @dice_rolls.length
            # begin
            @curr_player = @players[@turn_num % @players.length]
            take_turn(@curr_player)
            # rescue BankruptError => e
            #     puts "#{player.name} is bankrupt (#{player.money})"
            #     @game_over = true
            # end

            @turn_num += 1
        end
        puts "#{@curr_player.name} is bankrupt"
        puts @curr_player
        puts 'Game Over'
    end

    private

    def take_turn(player)
        roll = @dice_rolls[@turn_num % @dice_rolls.length]

        player.position = (player.position + roll) % @spaces.length
        @spaces[player.position].land_on(player)
    end
end
