Tue  7 Nov 11:24:38 WET 2023
**input1:** simple program that reads the user name and prints it
**input2:** adapted from test program, to evaluate the type of integer
 Similar to **input3* but with a while loop

Note: We can't pipe the read command.

The reason for this lies in teh fact that piping creates subshells.
These are copies of the shell and it envionment athat are use to 
execute the command in the pipeline. When the process is finished,
the copy is destroyes. Thus, such copies (subshells) simply
cannot alter the environment of its parent process.
Sun 12 Nov 14:45:55 WET 2023
**validatingInput** Summing up previous knowledge on input validation
