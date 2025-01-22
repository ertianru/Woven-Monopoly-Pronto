class Board
    attr_reader :spaces, :size, :go_space

    def initialize(spaces)
        @spaces = spaces
        @size = spaces.length
        @go_space = spaces[0]
    end

    def get_space(position)
        @spaces[position]
    end

    def land_on(player)
        space = get_space(player.position)
        space.land_on(player)
    end

    def pass_go(player)
        go_space.land_on(player)
    end
end
