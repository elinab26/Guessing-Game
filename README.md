# Guessing-Game
A number guessing game programmed in the Assembly x86-64 language. 

## Description
The game gets from a user a seed number and draw a random number that the player need to guess. 
This game was made as part of the Computer Architecture course at Bar Ilan University.

## Features
- Easy and Normal mode
- Double or Nothing
- Five Guesses

## How To Run The Game
1. Make sure you have the `gcc` compiler installed.
2. Clone this repository:
    ```sh
    git clone https://github.com/elinab26/Guessing-Game.git
    ```
3. Compile the code:
    ```sh
    gcc -no-pie guessing.s -o guessing
    ```
4. Run the game:
    ```sh
    ./guessing
    ```
5. Enjoy and have fun!