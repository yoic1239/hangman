# Hangman
It is a command line Hangman game built with Ruby.
## How to play
1. Run ```ruby lib/hangman.rb``` in your command line.
2. If there is any saved game, it will ask you whether to load the saved game. Press "Y" to load saved game or press "N" to start new game.
```
You have a saved game. Do you want to continue to play? (Y/N)
```
3. After game start, you can type your guess or type "save" to save the game.
```
_ _ _ _ _ _ _
Enter your guess (or type 'save' to save the game): 
```
4. You need to guess the secret word before 7 mistakes are made. Else, you lose the game.