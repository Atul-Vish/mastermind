Mastermind Strategy Implementation for Computer (Minimax and Alpha/Beta Pruning)

1. Create the Set of 1296 possible codes {1111, 1112,....6665, 6666}
2. Start with Initial guess 1122
3. Play the guess to get a response of colored and white key pegs. (Assume RW)
4. If the response if 4 colored pegs then the game is won & the algorithm terminates
5. Otherwise, remove from S any code that would not give this response of colored and white pegs.

Example: If '1111' was code and you played 1122 as a guess for it then you would've got 2R peg as response for it. However, the response we got for 1122 is (RW) which clearly indicates that '1111' can't be the code, so we'll remove it from Set 'S'.

