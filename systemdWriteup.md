### These are some loose notes on systemd.

*2023-10-27 - Watching Learn Linux TV (Systemd Deep-Dive: A Complete, Easy to Understand Guide for Everyone)*


### Intro

The init system is a kind of process (meaning, it runs in the background)

Init system - the very first process on the system and it has the job to schedule all other jobs in the system.

Systemd is the most comment init system.

The init system is always PID1 - process ID 1 (1st to start).

By checking htop and clicking on PID, we can see that init is, in fact PID 1


### Working with Units

Units are resources that systemd is able to manage, like services, timers, mounts, automounts and more.

*Note: a service is a type of unit. There are other units other than services.*

. systemctl start/stop/restart/status <service>

. systemctl enable/disable <service> , enable will create a symlink and make it so that when the machine starts, the service starts too. Disable will make sure it doesn't run at start(symlink removed, ofc).

*these services get a symlink writen into a file like /usr/lib/systemd/system or /etc/systemd/system and systemd knows that it needs to run them at startup*

tbc - wip!
