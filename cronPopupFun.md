So, just for fun, I decided I wante to have cron do what it's not supposed to do, which is, to run stuff in the foreground, instead of background or logging.

So, I ended up with this script:

0 * * * * /usr/bin/xfce4-terminal --geometry=55x1 --color-bg=yellow --color-text=red --command="/bin/bash -c '/root/stretchNow.sh; sleep 5'" --display=:0.0

For this to work, we need to install the xfce4-terminal, though:

. apt install xfce4-terminal (ymmv. My Debian machine has gnome as a standard, and it won't let me do this kind of stuff)

We also need to create our script. In this case stretchNow.sh which is sitting at /root/:

#!/bin/bash

echo "Get up and stretch! You've been sitting for too long"
exit 0

We then can add the crontab job with:

. crontab -e

And there it is. Our very own pop-up!

Issues? Yeah, sure. 
It's a security nuisance.
Whatever you are typing at the time: your name, a recipy, a password, etc, will appear on the new terminal for everyone to see.

I think you can circumvent this by installing and scripting xdotool, to lock the terminal, but that is looking like too much for now. xtrlock or xflock4 would also lock the entire screen, but that's also too much.

--snip--
