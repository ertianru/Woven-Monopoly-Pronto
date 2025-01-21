class Space
    attr_reader :name

    def initialize(name)
        @name = name
    end

    def land_on(player)
        raise NotImplementedError
    end
end
