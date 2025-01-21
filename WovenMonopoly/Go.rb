require_relative 'space'

class Go < Space
    def initialize(name)
        super(name)
    end

    def land_on(player)
        puts "#{player.name} pass by #{@name}"
    end
end
