# The Player class represents a player in the Monopoly game.
# It manages the player's name, money, properties, and position on the board.
class Player
    # @return [String] the name of the player
    # @return [Integer] the amount of money the player has
    # @return [Hash] the number of properties owned by the player, grouped by color
    # @return [Integer] the player's position on the board
    attr_accessor :name, :money
    attr_reader :properties_num_by_color, :position

    # Initializes a new Player object.
    #
    # @param name [String] the name of the player
    # @param money [Integer] the starting amount of money for the player (default is 16)
    # @param position [Integer] the starting position of the player on the board (default is 0)
    def initialize(name, money = 16, position = 0)
        @name = name
        @money = money
        @properties_num_by_color = {}
        @position = position
    end

    # Buys a property for the player.
    #
    # @param price [Integer] the price of the property
    # @param color [String] the color group of the property
    # @return [void]
    def buy_property(price, color)
        @money -= price
        @properties_num_by_color[color] ||= 0
        @properties_num_by_color[color] += 1
    end

    # Deducts money from the player's total.
    #
    # @param money [Integer] the amount of money to deduct
    # @return [void]
    def deduct_money(money)
        @money -= money
    end

    # Adds money to the player's total.
    #
    # @param money [Integer] the amount of money to add
    # @return [void]
    def receive_money(money)
        @money += money
    end

    # Gets the number of properties owned by the player of a specific color.
    #
    # @param color [String] the color group of the properties
    # @raise [Error] if the player does not own any properties of the specified color
    # @return [Integer] the number of properties owned by the player of the specified color
    def get_num_owned_properties_color(color)
        if @properties_num_by_color[color].nil?
            raise Error, "Player does not own any properties of color #{color}"
        end

        @properties_num_by_color[color]
    end

    # Moves the player on the board based on the roll of the dice.
    #
    # @param roll [Integer] the number rolled on the dice
    # @param board_size [Integer] the size of the board
    # @return [void]
    def move(roll, board_size)
        @position = (@position + roll) % board_size
    end

    # Checks if the player is bankrupt.
    #
    # @return [Boolean] true if the player has less than 0 money, false otherwise
    def bankrupt?
        money < 0
    end

    # Returns a string representation of the player.
    #
    # @return [String] a string containing the player's name, money, and position
    def to_s
        "    Player: #{@name}\n    Money: #{@money}\n    Position: #{@position}"
    end
end
