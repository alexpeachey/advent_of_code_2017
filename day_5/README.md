# Day5

Part 1:

The message includes a list of the offsets for each jump. Jumps are relative: -1 moves to the previous instruction, and 2 skips the next one. Start at the first instruction in the list. The goal is to follow the jumps until one leads outside the list.

In addition, these instructions are a little strange; after each jump, the offset of that instruction increases by 1. So, if you come across an offset of 3, you would move three instructions forward, but change it to a 4 for the next time it is encountered.

For Example:

(0) 3  0  1  -3
(1) 3  0  1  -3
2 (3) 0  1  -3
2  4  0  1 (-3)
2 (4) 0  1  -2
2  5  0  1  -2

Escape in 5 steps

Part 2:

Now, the jumps are even stranger: after each jump, if the offset was three or more, instead decrease it by 1. Otherwise, increase it by 1 as before.

For Example:

0 3  0  1  -3 Now takes 10 steps
