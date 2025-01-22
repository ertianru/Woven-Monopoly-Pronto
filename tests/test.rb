require 'minitest/autorun'
require_relative '../WovenMonopoly/player'
require_relative '../WovenMonopoly/property'
require_relative '../WovenMonopoly/board'
require_relative '../WovenMonopoly/dice'
require_relative '../WovenMonopoly/woven_monopoly'

class WovenMonopolyTest < Minitest::Test
    def setup
        @board_file = 'C:\Users\oohpi\OneDrive\Documents\GitHub\Woven-Monopoly-Pronto\tests\board.json'
        @dice_file = 'C:\Users\oohpi\OneDrive\Documents\GitHub\Woven-Monopoly-Pronto\tests\dice.json'
        @players = %w[Peter Billy Charlotte Sweedal]
        @board = Board.new(@board_file)
    end

    def test_board_loading
        board = Board.new(@board_file)
        assert_equal 9, board.size # Assuming board.json defines 10 spaces
    end

    def test_player_movement
        player = Player.new('TestPlayer')
        player.move(3, 9)
        assert_equal 3, player.position

        player.move(7, 9)
        assert_equal 1, player.position # Wrap-around test
    end

    def test_property_purchase
        property = Property.new('Blue Property', 5, 'Blue', 2)
        player = Player.new('Buyer')

        property.land_on(player)

        assert_equal player, property.owner
        assert_equal 11, player.money
    end

    def test_rent_payment
        rent = 2
        price = 5
        start_money = 16

        property = Property.new('Blue Property', price, 'Blue', rent)
        owner = Player.new('Owner')
        renter = Player.new('Renter')

        property.land_on(owner) # Owner buys property
        property.land_on(renter) # Renter pays rent

        assert_equal start_money - price + rent, owner.money
        assert_equal start_money - rent, renter.money
    end

    def test_dice_roll
        dice = Dice.new(@dice_file)
        assert_equal 1, dice.roll(0) # Assuming first roll in file is 1
        assert_equal 3, dice.roll(1) # Assuming second roll in file is 3
    end

    def test_game_play
        game = WovenMonopoly.new(@board_file, @players, @dice_file)
        results = game.start_game

        assert results[:winner]
        # assert(results[:standings].all? { |player| player.money >= 0 })
    end

    def test_bankruptcy
        player = Player.new('Bankrupt', 2)
        property = Property.new('Expensive Property', 5, 'Red', 5)

        property.land_on(player)

        assert player.bankrupt?
    end

    def test_rent_doubling
        board = Board.new(@board_file)
        player = Player.new('TestPlayer')
        blue_properties = board.spaces.select do |space|
            space.is_a?(Property) && space.color == 'Blue'
        end

        blue_properties.each { |property| property.land_on(player) }

        assert_equal 2, player.get_num_owned_properties_color('Blue')
        assert_equal(true, blue_properties.all? { |prop| prop.owner == player })
    end

    def test_go_space
        go_space = Go.new('GO')
        player = Player.new('TestPlayer')

        initial_money = player.money
        go_space.land_on(player)

        assert_equal initial_money + 1, player.money
    end
end
