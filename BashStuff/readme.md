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

- New addenda: now the script can run for many other linux distros.

--snip--

- Created the 'secretsanta' script. My family wanted me to write a script that would take their names,
assort them and then return a secret friend. Meaning that everyone would have a secret friend, there would
be no repetitions, no closed couples, and no one woul be left out.

- Every person is then to be informed, through email, on who is their secret friend. That is the person
they'll buy a christmas gift this year. This way we can all give a gift to every kid, and still have one 
surprise for a single adult.

- The code is mostly done - at least the gist of it. Now I need to organize it and find out how I'll
send the emails.

- By creating a simple list of names, shuffling it and then having each person give a gift to every next 
person, all the issues that might have arisen are no more.

- Now I'm going to create an email, and see if I can work with *sendmail*.

- The email bit was a total mess. I'm having something of a hard time sending the messages throuh email
while inside the script/terminal. So, for now I'll just use an external gmail account I created for this.

- The files are created inside a folder - which also serves as a backup in case someone doesn't get their
message.

- Note that later I'll want to control this 'email sending problem' and perhaps add encryption so that
even I, the creator of the script, cannot see the results of the random script (which wouldn't have been
a problem if the script itself could send emails)

- Do note that if the above had been possible, the very real risk of an email not reaching the destination
is not to be ignored. A backup of sorts would have always been a good idea - which (likely) means
encryption.

- My family members have asked for an extra perk: that no one can be friends of or have a secret friend
that is from the same house. So, I'll have to set teams and forbid choices from within those teams.
This will complicate my code quite a bit more, I guess. Maybe there is an easy way to do it. Mhhh.

--snip--

Mon Oct 30 01:14:22 PM WET 2023
<<<<<<< HEAD

- Finished the SecretSanta script. It took me much longer than expected, since I had to use stuff I
simply didn't know in Bash. It would have been much easier to do it in Python, haha. 
Anyway, it's done and ready.
=======
- Finished the SecretSanta script. It took me much longer than expected, since I had to use stuff I simply 
didn't know in Bash. It would have been much easier to do it in Python, haha. Anyway, it's done and ready.

--snip--

Wed  1 Nov 20:54:09 WET 2023

- Created the agentLoader. It loads the ssh agent and points it to the LOCAL ssh key
- Deleted it from the PATH. No point. The issue with automatically unloading agents must be solved first.
See IssueREADME.md

--snip--

- The secret santa script works... not always. Sometimes it hangs at the end. It's a coin toss, really.
I don't know why this is happening, but I'm suspecting that the shuffle function is doing something funky.
I suspect that Bash isn't the best or easiest language to pull this stuff. Python would surely be better.

--snip--

Addendum:

I want to finish my current Linux book + systemd video and little tidbits like that.
TODO: more Linux CTFs, the SysAdmin book (hopefully Santa will play nice this year), then I also have to
finish soon Linux Essential and the Linux Journey site. Near future: some Cert.
>>>>>>> 4adf0b92418b60bcdb95d2e4567f59f7ce7e752b

--snip--

Tue Nov 14 02:54:24 PM WET 2023

- I'm now trying to solve the issues with the autoPull.sh scrip. But it's not been easy. I'm comparing the
configuration and associated files between machines, since the Mint machine is working properly and
everything else is not.

- Still, it is to be noted that this autoPulling script is also, for some reason I cannot fathom, 
pulling or copying some stuff from my repos directly into my user's (or root) home folders. This is
very bad form, but I don't see anything in the script that oculd justify this. Maybe an improper use
of the git commands, that is sending stuff to those folders?

- So far, I've noticed that one of the other machines (Debian) has SSH_AUTHO_SOCK= and then a temp path
while the Mint machine has a /run/user/... path, which is odd. Also, the Debian machine has a config
ssh file, and the Mint doesn't.

- Need to carry on investigating, and test the other machines.

--snip--

