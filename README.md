# Guessing Game
A number guessing game programmed in the Assembly x86-64 language. 

## Description
The game gets from a user a seed number and draw a random number that the player need to guess.  
This game was made as part of the Computer Architecture course at Bar Ilan University.

## Features
- Easy and Normal mode
- Double or Nothing
- The number to guess will be between 0 and 10 (at the beginning of the game)
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

## How to Play
1. Now that you execute the game, the program will ask you to enter a seed number.
2. Now you will need to choose if you want to play in easy mode or not.
3. And now start guessing! If you are in easy mode, after each guess the game will tell you if you are above or below the number you need to find.
4. Be careful! You have only 5 guesses!
5. When you will guess the correct number, you can choose if you want to double the range of the number and continue to play.

