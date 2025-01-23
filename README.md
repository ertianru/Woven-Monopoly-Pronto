# Woven Monopoly Game

## Overview
The Woven Monopoly game simulates a deterministic version of Monopoly with predefined dice rolls and board configurations. Players take turns to move around the board, buying properties, paying rent, and passing GO to earn money. The game ends when a player goes bankrupt, and the player with the most money is declared the winner.

## Assumptions
- Four players take turns in order: Peter, Billy, Charlotte, and Sweedal.
- Players start with $16 each and gain $1 upon passing GO.
- Rent is assumed to be 10% of the property price
- Properties can be purchased if unowned, and rent is paid to the owner if owned.
- Rent doubles if a player owns all properties of the same color.
- The game uses a JSON file to define the board and another JSON file for dice rolls.
- Bankruptcy occurs when the money a player owns falls below 0, not at 0.

## Requirements
- Ruby 3.0 or higher
- JSON files for the board and dice rolls

## Usage
The program requires two arguments:
1. The file path to the board JSON file.
2. The file path to the dice rolls JSON file.

### Running the Program
To run the game, cd to the game root folder (WovenMonopoly) and execute the following command:

```bash
ruby woven_monopoly.rb <path_to_board_json> <path_to_dice_json>
```

For example:

```bash
ruby woven_monopoly.rb board.json dice.json
```

### Output
The program outputs:
- The winner of the game
- Final standings of all players, including money, properties owned, and their final positions

## File Structure
- WovenMonopoly folder
  - **`woven_monopoly.rb`**: The main game logic.
  - **`player.rb`**: Defines player behavior, including movement and financial transactions.
  - **`property.rb`**: Handles property-specific logic, such as ownership and rent.
  - **`board.rb`**: Loads and manages the board configuration.
  - **`dice.rb`**: Manages the dice rolls for the game.
  - **`go.rb`**: Handles logic for the GO space.
- data Folder
  - **`board.json`**: Defines the spaces on the board, including properties and GO.
  - **`dice.json`**: Predefined dice rolls for the game.
- tests folder
  - **`test.rb`**: Unit tests for woven monopoly program.
  - **`board.json`**: Defines the spaces on the board for testing.
  - **`dice.json`**: Predefined dice rolls for testing.
- docs folder
  - **`class_diagram.png`**: UML class diagram for the program.

## Testing
The program includes a suite of unit tests to ensure reliability and correctness. To run the tests, cd to the test folder and run:

```bash
ruby woven_monopoly_tests.rb
```

## Example JSON Files
### `board.json`
```json
[
  {
    "name": "GO",
    "type": "go"
  },
  {
    "name": "The Burvale",
    "price": 1,
    "colour": "Brown",
    "type": "property"
  }
]
```

### `dice.json`
```json
[4, 6, 3, 2, 5]
```

# Design Report: Woven Monopoly Program

The design of the program is simple and leverages core object oriented programming concepts including **inheritance** and **polymorphism**.
   - The `Go` and `Property` class inherits from an abstract `Space` class, leveraging polymorphism to handle different board space behaviors.
   - Methods like `land_on` are overridden in derived classes (`Go` and `Property`) to define space-specific behaviors.
   - This abstraction ensures that new types of spaces can be added with minimal changes.
   - This allows the game logic to interact with spaces generically, improving extensibility.

The SOLID Principles were also kept in mind while developing the program. Each class has a clear, **singular responsibility**:
- `Player`: Manages player-specific attributes and actions.
- `Property`: Handles property ownership and rent.
- `Board`: Manages spaces and interactions between players and the board.
- `Dice`: Provides deterministic dice rolls from predefined JSON files.
- `Go`: Handles the logic for the GO space.
- `Space`: Abstract class for spaces players can land on.

Using the **Liskov Substitution Principle (LSP)** derived classes (`Go`, `Property`) can replace their base class (`Space`) without breaking the functionality of the game.

Focusing on maintainability, code is written clean and readable with comments, adhering to Ruby coding conventions. Extensibility also considered. For instance, new board spaces or rules can be integrated without altering core logic by adding new classes that extend from `Space`.

Lastly, a comprehensive test suite validates all aspects of the program, ensuring reliability.