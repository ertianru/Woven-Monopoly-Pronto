class Board
    attr_reader :spaces

    def initialize(spaces)
        @spaces = spaces
    end

    def get_space(position)
        @spaces[position]
    end

    def size
        @spaces.length
    end
end
