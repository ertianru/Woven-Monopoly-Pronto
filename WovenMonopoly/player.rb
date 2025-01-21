class Player
    attr_accessor :name, :money, :properties, :position

    def initialize(name, money = 16, position = 0)
        @name = name
        @money = money
        @properties = []
        @position = position
    end

    def to_s
        "Player: #{@name}
        Money: #{@money}
        Properties: #{@properties}
        Position: #{@position}"
    end
end
