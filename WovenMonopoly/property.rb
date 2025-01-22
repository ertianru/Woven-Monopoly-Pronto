require_relative 'space'

class Property < Space
    @@properties_num_by_color = {}

    attr_reader :price, :color, :owner, :rent

    def initialize(name, price, color, rent)
        super(name)
        @price = price
        @color = color
        @rent = rent
    end

    # setter
    def self.properties_num_by_color(properties_num_by_color)
        @@properties_num_by_color = properties_num_by_color
    end

    def land_on(player)
        puts "#{player.name} land on #{@name}"
        puts "#{player}"

        if @owner.nil?
            handle_purchase(player)
        else
            handle_rent(player)
        end
    end

    def to_s
        "    Property: #{@name}\n    Price: #{@price}\n    Color: #{@color}\n    Owner: #{@owner}\n    Rent: #{@rent}"
    end

    private

    def handle_purchase(player)
        player.buy_property(@price, @color)
        @owner = player
        puts "#{player.name} bought #{@name}"
    end

    def handle_rent(player)
        validate_properties_num_by_color

        rent = @rent
        if @owner.get_num_owned_properties_color(@color) == @@properties_num_by_color[@color]
            rent *= 2
        end

        player.pay_rent(rent)
        @owner.receive_rent(rent)

        puts "#{player} paid rent to #{@owner.name}"
        puts "#{player}"
        puts "#{@owner}"
    end

    def validate_properties_num_by_color
        return unless @@properties_num_by_color.nil?

        raise 'Properties_num_by_color not initialized'
    end
end
