require_relative 'space'

# The Property class represents a property space on the Monopoly board.
# It inherits from the Space class.
class Property < Space
    # Class variable to store the number of properties by color
    # Used to determine if a player owns all properties of a color group
    @@properties_num_by_color = {}

    # @return [Integer] the price of the property
    # @return [String] the color group of the property
    # @return [Player, nil] the owner of the property, or nil if unowned
    # @return [Integer] the base rent of the property
    attr_reader :price, :color, :owner, :rent

    # Initializes a new Property object
    #
    # @param name [String] the name of the property
    # @param price [Integer] the price of the property
    # @param color [String] the color group of the property
    # @param rent [Integer] the base rent of the property
    def initialize(name, price, color, rent)
        super(name)
        @price = price
        @color = color
        @rent = rent
    end

    # Sets the number of properties by color
    #
    # @param properties_num_by_color [Hash] a hash mapping color groups to the number of properties in that group
    def self.properties_num_by_color(properties_num_by_color)
        @@properties_num_by_color = properties_num_by_color
    end

    # Handles the event of a player landing on the property
    #
    # @param player [Player] the player who lands on the property
    def land_on(player)
        puts "#{player.name} lands on #{@name}"

        if @owner.nil?
            puts "#{@name} is unowned"
            puts "#{player.name} ($#{player.money}) bought #{@name}"

            handle_purchase(player)

            puts self
        else
            puts "#{@name} is owned by #{@owner.name}"
            puts "#{player.name} ($#{player.money}) pays rent to #{@owner.name} ($#{@owner.money})"

            handle_rent(player)

            puts "    #{player.name} ($#{player.money})"
            puts "    #{@owner.name} ($#{@owner.money})"
        end
    end

    # Returns a string representation of the property
    #
    # @return [String] a string representation of the property
    def to_s
        "    Property: #{@name}\n    Price: #{@price}\n    Color: #{@color}\n    Owner: #{@owner.name} ($#{@owner.money})\n    Rent: #{@rent}"
    end

    private

    # Handles the purchase of the property by a player
    #
    # @param player [Player] the player who buys the property
    def handle_purchase(player)
        player.buy_property(@price, @color)
        @owner = player
    end

    # Handles the payment of rent by a player to the owner of the property
    #
    # @param player [Player] the player who pays the rent
    def handle_rent(player)
        validate_properties_num_by_color

        rent = @rent
        if @owner.get_num_owned_properties_color(@color) == @@properties_num_by_color[@color]
            rent *= 2
        end

        player.deduct_money(rent)
        @owner.receive_money(rent)
    end

    # Validates that the properties_num_by_color class variable has been initialized
    #
    # @raise [RuntimeError] if properties_num_by_color is not initialized
    def validate_properties_num_by_color
        return unless @@properties_num_by_color.nil?

        raise 'Properties_num_by_color not initialized'
    end
end
