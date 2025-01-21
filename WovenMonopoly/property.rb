class Property < Space
    attr_reader :price, :color

    def initialize(name, price, color)
        super(name)
        @price = price
        @color = color
    end
end
