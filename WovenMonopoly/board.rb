class Board
    attr_reader :spaces, :size

    def initialize(spaces)
        @spaces = spaces
        @size = spaces.length
    end

    def get_space(position)
        @spaces[position]
    end

    def land_on(player)
        space = get_space(player.position)
        space.land_on(player)
    end
end
