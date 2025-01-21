require_relative 'bankrupt_error'

class Player
    attr_accessor :name, :money, :properties, :position

    def initialize(name, money = 16, position = 0)
        @name = name
        @money = money
        @properties = []
        @position = position
    end

    def buy_property(property)
        raise BankruptError if @money < property.price

        @money -= property.price
        @properties << property
        puts "#{@name} bought #{property.name}"
    end

    def pay_rent(property)
        raise BankruptError if @money < property.rent

        @money -= property.rent
        property.owner.money += property.rent
        puts "#{@name} paid rent to #{property.owner.name}"
        puts "#{@name}"
        puts "#{property.owner}"
    end

    def to_s
        "    Player: #{@name}\n    Money: #{@money}\n    Properties: #{@properties}\n    Position: #{@position}"
    end
end
