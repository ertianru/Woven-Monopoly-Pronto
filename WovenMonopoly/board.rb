require_relative 'go'
require_relative 'property'

# The Board class represents the game board in a Monopoly game.
# It manages the spaces on the board and interactions with players.
class Board
    # @return [Array] the list of spaces on the board
    # @return [Integer] the number of spaces on the board
    # @return [Go] the starting 'Go' space on the board
    attr_reader :spaces, :size, :go_space

    # Initializes a new Board instance.
    #
    # @param spaces_file_path [String] the file path to the JSON file containing the board spaces
    def initialize(spaces_file_path)
        @spaces = load_spaces(spaces_file_path)
        @size = spaces.length
        @go_space = spaces[0]
    end

    # Retrieves the space at the given position.
    #
    # @param position [Integer] the position of the space on the board
    # @return [Space] the space at the given position
    def get_space(position)
        @spaces[position]
    end

    # Handles the action when a player lands on a space.
    #
    # @param player [Player] the player landing on the space
    def land_on(player)
        space = get_space(player.position)
        space.land_on(player)
    end

    # Handles the action when a player passes the 'Go' space.
    #
    # @param player [Player] the player passing the 'Go' space
    def pass_go(player)
        return if get_space(player.position) == @go_space

        go_space.land_on(player)
    end

    private

    # Loads the spaces from the given JSON file.
    #
    # @param spaces_file_path [String] the file path to the JSON file containing the board spaces
    # @return [Array] the list of spaces loaded from the file
    def load_spaces(spaces_file_path)
        spaces_json = JSON.parse(File.read(spaces_file_path))

        spaces = []
        properties = {}
        spaces_json.each do |s|
            case s['type']
            when 'go'
                spaces << Go.new(s['name'])
            when 'property'
                # Rent is assumed to be 10% of the property price
                spaces << Property.new(s['name'], s['price'], s['colour'],
                                       (s['price'] * 0.1).round(2))
                properties[s['colour']] ||= 0
                properties[s['colour']] += 1
            end
        end

        Property.properties_num_by_color(properties)

        spaces
    end
end
