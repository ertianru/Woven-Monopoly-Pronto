require_relative 'bankrupt_error'

class Player
    attr_accessor :name, :money
    attr_reader :properties_num_by_color, :position

    def initialize(name, money = 16, position = 0)
        @name = name
        @money = money
        @properties_num_by_color = {}
        @position = position
    end

    def buy_property(price, color)
        @money -= price
        @properties_num_by_color[color] ||= 0
        @properties_num_by_color[color] += 1
    end

    def deduct_money(money)
        @money -= money
    end

    def receive_money(money)
        @money += money
    end

    def get_num_owned_properties_color(color)
        if @properties_num_by_color[color].nil?
            raise Error, "Player does not own any properties of color #{color}"
        end

        @properties_num_by_color[color]
    end

    def move(roll, board_size)
        @position = (@position + roll) % board_size
    end

    def bankrupt?
        money < 0
    end

    def to_s
        "    Player: #{@name}\n    Money: #{@money}\n    Properties: #{@properties}\n    Position: #{@position}"
    end
end
