Sun 29 Oct 14:54:57 WET 2023

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

- Finished the SecretSanta script. It took me much longer than expected, since I had to use stuff I simply didn't know in Bash. It would have been much easier to do it in Python, haha. Anyway, it's done and ready.

--snip--
