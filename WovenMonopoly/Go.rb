require_relative 'space'

class Go < Space
    attr_reader :go_money

    def initialize(name, go_money = 1)
        super(name)
        @go_money = go_money
    end

    def land_on(player)
        puts "#{player.name} passed by #{@name} (#{player.money})"
        player.receive_money(@go_money)
        puts "#{player}"
    end
end
