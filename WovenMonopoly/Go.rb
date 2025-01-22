require_relative 'space'

# Represents the "Go" space on a Monopoly board.
# When a player lands on or passes this space, they receive a specified amount of money.
#
# @attr_reader [Integer] go_money The amount of money a player receives when they land on or pass this space.
class Go < Space
    # Initializes a new Go space.
    #
    # @param [String] name The name of the space.
    # @param [Integer] go_money The amount of money a player receives when they land on or pass this space. Defaults to 1.
    def initialize(name, go_money = 1)
        super(name)
        @go_money = go_money
    end

    # Handles the event when a player lands on or passes this space.
    #
    # @param [Player] player The player who lands on or passes this space.
    # @return [void]
    def land_on(player)
        puts "#{player.name} passed by #{@name} ($#{player.money})"
        player.receive_money(@go_money)
        puts player
    end
end
