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
If I then run ssh-add -l, there is no issue whatsoever. The agent sticks and is loaded.

Fri 11 Nov 

I've had a lot of work elsewhere, so I didn't get to pay all that much attention to
this issue. The idea, during the weekend is to compare the config files of 2 PCs.

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

Thu Nov 16 11:11:16 PM WET 2023

- I finally solved it!

But let's first go through what I did: 

I open as many machines as I could and started reading log files and config files, comparing them to each other, to see what are the major differences between machines. As I couldn't find anything major, other than the difference between the result of env | grep ssh, which points to /run/user/1000/keyring/ssh in my Mint machine, and to /tmp/ paths in my Debian machines, I decided to make a simple script which only did the following:

eval $(ssh-agent -s)
ssh-add ~/.ssh/mykey_key

Just that. To see what happened (and if I could still find the same problem where I was only able to keep the agent when running in the command line, but never through a script). And so it was that the same problem remained. So, this wasn't any deeper problem and it wasn't an issue with the script (which was already unlikely).

- So then, it came to me that the script might be running in a subshell and just be 'tossed' out as soon as it stopped (I did a few experiments, where, at the end of the script I checked stuff like ssh-add -l and ssh-add -L).

And so it was. Instead of running the script normally, I did source /autoPull.sh and the agent stuck around.

- So, problem solved.

- But now another question pops up: why is Mint not throwing the script away? Is it treating the script more like a sourced script? Or is there any other reason behind it?

- I'm now going to take a good look at .bashrc, to see if any major differences pop up between distros, but this might just be a tad over my head. I might need to ask in a forum or something.

--snip--

Sat Nov 18 12:27:09 PM WET 2023

- It's at the same time a bit simples and more complicated.
The reason why the Mint system is showing no issues has to do with Mint
using some other process in order to load the key. I suspect that the
agent is already automatically loading the keys at startup, and no more
tinkering is needed.

- So, on my Mint machine, I'm just running the autopulls, not even adding
to the log files. I'm fine with not entering a passphrase on my home machineand simply check how my work is, compared to what's in GitHub.

- For my debian (and other) machines, I'm sourcing the script, but I had to
remove the exec commands in it, to avoid endless loops that froze my treminal.
I'm instead redirecting information into log files (but might do without that altogether, since that was a mostly a way to get a grip on what was happening, and the 'live feedback' is useful to learn immediatelly what repos need attention).

- I still don't know why Mint is automatically loading and 'solving' this issue, but I bet it has something to do with some specific tool, like gnome-keyring or something.

- For now the script is doing exactly what it's supposed to do. I'll edit it soon and post here (the non-Mint version, which is more involved)

--snip--


