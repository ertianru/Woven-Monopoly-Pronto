require_relative 'space'

class Property < Space
    attr_reader :price, :color

    def initialize(name, price, color)
        super(name)
        @price = price
        @color = color
    end

    def land_on(player)
        puts "#{player} land on #{@name}"
    end
end
