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
        puts "#{player.name} lands on #{@name}"

        if @owner.nil?
            puts "#{@name} is unowned"
            puts "#{player.name} ($#{player.money}) bought #{@name}"

            handle_purchase(player)

            puts self
        else
            puts "#{@name} is owned by #{@owner.name}"
            puts "#{player.name} ($#{player.money}) pays rent to #{@owner.name} (#{@owner.money})"

            handle_rent(player)

            puts "    #{player.name} ($#{player.money})"
            puts "    #{@owner.name} ($#{@owner.money})"
        end
    end

    def to_s
        "    Property: #{@name}\n    Price: #{@price}\n    Color: #{@color}\n    Owner: \n#{@owner}\n    Rent: #{@rent}"
    end

    private

    def handle_purchase(player)
        player.buy_property(@price, @color)
        @owner = player
    end

    def handle_rent(player)
        validate_properties_num_by_color

        rent = @rent
        if @owner.get_num_owned_properties_color(@color) == @@properties_num_by_color[@color]
            rent *= 2
        end

        player.deduct_money(rent)
        @owner.receive_money(rent)
    end

    def validate_properties_num_by_color
        return unless @@properties_num_by_color.nil?

        raise 'Properties_num_by_color not initialized'
    end
end
