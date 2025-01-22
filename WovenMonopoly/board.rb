require_relative 'go'
require_relative 'property'

class Board
    attr_reader :spaces, :size, :go_space

    def initialize(spaces_file_path)
        @spaces = load_spaces(spaces_file_path)
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

    private

    def load_spaces(spaces_file_path)
        spaces_json = JSON.parse(File.read(spaces_file_path))

        spaces = []
        properties = {}
        spaces_json.each do |s|
            case s['type']
            when 'go'
                spaces << Go.new(s['name'])
            when 'property'
                # TODO: ask how much rent cost
                spaces << Property.new(s['name'], s['price'], s['colour'], s['price'])
                properties[s['colour']] ||= 0
                properties[s['colour']] += 1
            end
        end

        Property.properties_num_by_color(properties)

        spaces
    end
end
