require_relative 'bankrupt_error'

class Player
    attr_accessor :name, :money, :position
    attr_reader :properties

    def initialize(name, money = 16, position = 0)
        @name = name
        @money = money
        @properties = []
        @position = position
    end

    def buy_property(property)
        # raise BankruptError if @money < property.price

        @money -= property.price
        @properties << property
        puts "#{@name} bought #{property.name}"
    end

    def pay_rent(property)
        # raise BankruptError if @money < property.rent

        @money -= property.rent
        property.owner.money += property.rent
        puts "#{@name} paid rent to #{property.owner.name}"
        puts "#{@name}"
        puts "#{property.owner}"
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
