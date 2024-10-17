# Mastermind

1. This implementation of mastermind contain two players i.e. `ComputerPlayer` and `HumanPlayer`
2. You are the `HumanPlayer`
3. You can choose to be either **code breaker** or **code creator**
4. If you choose to be **code guesser** then `ComputerPlayer` will create code and you'll get `11` tries to guess the code.
5. If you can guess the **secret code** in `11` tries then you win the game and the game will end with a winning message.
6. If you can't guess the code in `11` tries you lose the game and the game will end with a losing message.
7. If you choose to be the **code creator**, then write your code on a piece of paper.
8. `ComputerPlayer` will start guessing your code and everytime **Computer** makes a guess, look at your **code**(where you wrote it in step 7) and provide feedback.
9. `ComputerPlayer` will work under the assumption that you always provide correct feedback.
10. `ComputerPlayer` will always win and will be able to guess the code in atmost 5 tries. Provided that the feedback you provide is correct.
11. It uses **Knuth's** algorithm to guess it in atmost 5 tries. More details on the algortihm are [here](https://en.wikipedia.org/wiki/Mastermind_(board_game)#Best_strategies_with_four_holes_and_six_colors)

---

[Click to know about How to Play Mastermind](https://www.wikihow.com/Play-Mastermind)

![Code Creator]()