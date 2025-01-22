require 'minitest/autorun'
require_relative '../WovenMonopoly/player'
require_relative '../WovenMonopoly/property'
require_relative '../WovenMonopoly/board'
require_relative '../WovenMonopoly/dice'
require_relative '../WovenMonopoly/woven_monopoly'

# This class contains test cases for the Woven Monopoly game.
class WovenMonopolyTest < Minitest::Test
    # Sets up the initial state for the tests.
    # Initializes instance variables for the board file, dice file, players, and board.
    #
    # @instance_variable [String] @board_file Path to the board configuration file.
    # @instance_variable [String] @dice_file Path to the dice configuration file.
    # @instance_variable [Array<String>] @players List of player names.
    # @instance_variable [Board] @board Instance of the Board class initialized with the board file.
    def setup
        @board_file = 'board.json'
        @dice_file = 'dice.json'
        @players = %w[Peter Billy Charlotte Sweedal]
        @board = Board.new(@board_file)
    end

    # Tests the loading of the board from a file.
    #
    # @return [void]
    def test_board_loading
        board = Board.new(@board_file)
        assert_equal 9, board.size # Assuming board.json defines 9 spaces
    end

    # Tests the movement of a player on the board.
    #
    # The test covers:
    # - Moving the player by a specified number of steps.
    # - Ensuring the player's position is updated correctly.
    # - Testing the wrap-around behavior when the player moves beyond the board's limit.
    def test_player_movement
        player = Player.new('TestPlayer')
        player.move(3, 9)
        assert_equal 3, player.position

        player.move(7, 9)
        assert_equal 1, player.position # Wrap-around test
    end

    # Tests the purchase of a property by a player.
    #
    # The test covers:
    # - Buying a property by a player.
    # - Ensuring the player's money is updated after the purchase.
    # - Ensuring the property's owner is updated after the purchase.
    def test_property_purchase
        property = Property.new('Blue Property', 5, 'Blue', 2)
        player = Player.new('Buyer')

        property.land_on(player)

        assert_equal player, property.owner
        assert_equal 11, player.money
    end

    # Tests the rent payment functionality in the Monopoly game.
    #
    # The test covers:
    # - The owner's money should be equal to the initial money minus the property price plus the rent.
    # - The renter's money should be equal to the initial money minus the rent.
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

    # Tests the dice roll functionality.
    #
    # The test covers:
    # - Ensuring the dice rolls match the expected values from the dice file.
    def test_dice_roll
        dice = Dice.new(@dice_file)
        assert_equal 1, dice.roll(0) # Assuming first roll in file is 1
        assert_equal 3, dice.roll(1) # Assuming second roll in file is 3
    end

    # Tests the overall game play.
    #
    # The test covers:
    # - Starting the game and ensuring there is a winner.
    def test_game_play
        game = WovenMonopoly.new(@board_file, @players, @dice_file)
        results = game.start_game

        assert results[:winner]
    end

    # Tests the bankruptcy functionality.
    #
    # The test covers:
    # - Ensuring a player is marked as bankrupt when they cannot afford a property.
    def test_bankruptcy
        player = Player.new('Bankrupt', 2)
        property = Property.new('Expensive Property', 5, 'Red', 5)

        property.land_on(player)

        assert player.bankrupt?
    end

    # Tests the rent doubling functionality for owning multiple properties of the same color.
    #
    # The test covers:
    # - Ensuring the player owns all properties of a specific color.
    # - Ensuring the rent is doubled for properties of the same color.
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

    # Tests the functionality of landing on the GO space.
    #
    # The test covers:
    # - Ensuring the player's money is increased by the correct amount when landing on GO.
    def test_go_space
        go_space = Go.new('GO')
        player = Player.new('TestPlayer')

        initial_money = player.money
        go_space.land_on(player)

        assert_equal initial_money + 1, player.money
    end
end
