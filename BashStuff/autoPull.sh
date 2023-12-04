#!/bin/bash

# If you're going to have different SSH key-pairs on different machines, then it's
# a good idea to have this script running locally (also for minor tinkering)

# Start the SSH agent
eval $(ssh-agent -s)

# Add SSH key to the agent (this is an example. Add the correct key. Also, Verbosity can be added - and the logging removed or 'tee'ed' into the terminal if you want to read the info)
ssh-add /root/.ssh/id_rsa


# The repository pulls
/usr/bin/git -C /home/opqam/PROJECTS/LinuxCommons/ pull origin master
/usr/bin/git -C /home/opqam/PROJECTS/MigratingCoconuts/ pull origin master
/usr/bin/git -C /home/opqam/PROJECTS/edoC/ pull origin master
/usr/bin/git -C /home/opqam/PROJECTS/Documentation/ pull origin master
/usr/bin/git -C /home/opqam/PROJECTS/Belters/ pull origin master
/usr/bin/git -C /home/opqam/PROJECTS/Pocket-Lab/ pull origin master
