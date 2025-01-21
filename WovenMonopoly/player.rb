class Player
    attr_accessor :name, :money, :properties, :position

    def initialize(name, money = 16, position = 0)
        @name = name
        @money = money
        @properties = []
        @position = position
    end
end
