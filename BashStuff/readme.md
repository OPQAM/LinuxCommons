Sat 28 Oct 16:58:52 WEST 2023

- I've just finished my last version of my calculator

- I had no idea, but *bc* (basic calculator), on which my program depends,
isn't automatically installed into all distros

- Therefore, I decided to add a few lines at the beginning of the program,
to check if *bc* is present in the system. If it isn't, the user is asked
if they want to install the program.

--snip--

Sun 29 Oct 14:54:57 WET 2023

- Created 'dotfiler', a program that can take on a parameter (the file
that we want to send to our dotfiles folder).

- The program starts by making sure that the user enters at least one 
argument. It then goes on to asking the user what is the name of the
dotfiles folder - assuming a priori a certain folder (remember that this
is for personal use, so I have my preference).

- The required folder (if inserted) will be created if it doesn't exist.

- Afterwards, she program checks to see if git is present in the system.
  If it's not, git will be installed, and then initialized inside the
  appropriate folder.

- Finally, we run git inside the appropriate folder, in order to push the changes relative to the folder.
