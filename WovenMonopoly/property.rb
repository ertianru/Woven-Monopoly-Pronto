require_relative 'space'

class Property < Space
    attr_reader :price, :color, :owner, :rent

    def initialize(name, price, color, rent)
        super(name)
        @price = price
        @color = color
        @rent = rent
    end

    def land_on(player)
        puts "#{player.name} land on #{@name}"
        puts "#{player}"

        if @owner.nil?
            player.buy_property(self)
            @owner = player
        else
            # TODO: Implement rent calculation
            player.pay_rent(self)
        end
    end

    def to_s
        "    Property: #{@name}\n    Price: #{@price}\n    Color: #{@color}\n    Owner: #{@owner}\n    Rent: #{@rent}"
    end
end
