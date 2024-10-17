# Mastermind

1. This implementation of mastermind contain two players i.e. `ComputerPlayer` and `HumanPlayer`
2. You are the `HumanPlayer`
3. You can choose to be either **code breaker** or **code creator**
4. If you choose to be **code guesser** then `ComputerPlayer` will create code and you'll get `11` tries to guess the code.
5. If you can guess the **secret code** in `11` tries then you win the game and the game will end with a winning message.
6. If you can't guess the code in `11` tries you lose the game and the game will end with a losing message.
7. If you choose to be the **code creator**, then write your code on a piece of paper.
8. `ComputerPlayer` will start guessing your code and everytime **Computer** makes a guess, look at your **code**(where you wrote it in step 7) and provide feedback.
9. `ComputerPlayer` will work under the assumption that you'll always provide correct feedback.
10. `ComputerPlayer` will always win and will be able to guess the code in atmost 5 tries. Provided that the feedback you provide is correct.
11. It uses **Knuth's** algorithm to guess it in atmost 5 tries. More details on the algortihm are [here](https://en.wikipedia.org/wiki/Mastermind_(board_game)#Best_strategies_with_four_holes_and_six_colors)

---

[Click to know about How to Play Mastermind](https://www.wikihow.com/Play-Mastermind)

## Code Creator

![Code Creator](https://github.com/Atul-Vish/mastermind/blob/main/media/code_creator.gif)

If you want to be the **code creator** then press `2`. Write your code on paper and every time `ComputerPlayer` make a **guess** look at your **code** and provide feedback. Take some time but do provide *correct feedback*. In the above `GIF` I created the code *["Red", "Blue", "Green", "Yellow"]*. I kept on providing feedback to Computer based on this code and the ComputerPlayer was able to guess the original code in **4** tries.

## Code Breaker

![Code Breaker](https://github.com/Atul-Vish/mastermind/blob/main/media/code_guess.gif)

If you want to be the **code breaker** then press `1`. Provide the guess in the format specified in the above peg.

## Play the Game

To Play the mastermind : 
1. [Go to this link](https://replit.com/@atulvishwakarm6/mastermind).
2. `Click` on the green  **Fork** button in the top upper right corner.
3. `Select` blue **Fork repl** button.
4. Now `Click` the green **Run** button.
5. You'll be prompted to choose between `code creator` or `code breaker`
6. Enter `1` if you want to guess the **code** created by the `ComputerPlayer`
7. Enter `2` if you want the `ComputerPlayer` to guess your secret **code**
8. ***KEEP REPEATING AND HAVE FUN!!***

## Problems that I Faced

1. Implementing the functionality for `white feedback peg` was difficult. For `red feedback peg` it was way easier, just check the corresponding pegs in both `code` and `guess` and if they are same then increment a **counter** variable for it. I ended up using `red peg feedback` data and method `max_peg_count` to indirectly get get the `white feedback data`.

2. Whle implementing **Knuth's Mastermind Algorithm** to remove **codes** from the `set` of all possible **1296** codes, I was using `each` method on `set` while simultaneously updating my `set` which led to my possible codes leakage.

## Lessons Learned

1. Always write **pseudocode** first. It saves time and helps to find fault in your logic. You may have a strong temptation to just write the code directly but refrain from doing so. Write **pseudocode** and verify it against some examples. Once you have done that you can be sure that whatever error comes now is an *implementation problem*.

2. Don't think about **refactoring** and writing new piece of functionality together. Focus on one thing at a time.

3. Always create a functionality outline via **functions** only then begin to fill those functions. The other way around is too confusing for me. Writing individual functions first and then thinking about how to piece them together to achieve the desired functionality wastes too much time and it doesn't give a good feel of `data flow`.

4. *Tests are awesome*. Everytime I wrote a functionality, I feared that it might break something. I had to check if everything was working manually which took too much time. So why didn't I write tests?? I haven't studied them in `Ruby` yet but had prior exposure to them in `Java`. 
