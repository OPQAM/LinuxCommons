I really must check the issue with the agents auto-unloading on my Debian machines.
It's also happening with the 'autoLoader' script.

If called with ssh-add -l the agent is present. But if I run that again, it is gone.
Must, must, must check the differences between Debian and Mint in this regard.

Wed  1 Nov 21:15:13 WET 2023

I've tested trying to commit and push without the agent being loaded.
There is no issue at all... because the system is asking me for my password, and
loading it as the program runs. So, both the autoLoader and the startup script loading
don't seem to be doing pretty much anything (well, the startup script is actually
pulling stuff from the repos... so that's something).

Really need to check this and make it work.

update: 
IF I add by hand the commands eval $(ssh-add -s) and ssh-add ~/.ssh/id_rsa then all is
 fine. If a script adds it, it gets auto-removed. I don't know where this comes from.
