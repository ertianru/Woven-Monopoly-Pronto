# Abstract space class.
# Represents a space on the Monopoly board.
class Space
    # @attr_reader [String] name The name of the space.
    attr_reader :name

    # Initializes a new Space object.
    #
    # @param name [String] The name of the space.
    def initialize(name)
        @name = name
    end

    # Defines the action to be taken when a player lands on this space.
    # This method should be implemented by subclasses.
    #
    # @param player [Player] The player who lands on the space.
    # @raise [NotImplementedError] If the method is not implemented by a subclass.
    def land_on(player)
        raise NotImplementedError
    end
end
