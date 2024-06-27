#!/bin/bash

# Define the remote server and user
REMOTE_USER="opqam"
REMOTE_HOST="127.0.0.1"

# Define the initial command to pre-type
INITIAL_COMMAND="hello world "

# Start tmux if not already running
if ! pgrep tmux > /dev/null; then
  tmux start-server
fi

# Create a new tmux session and pane
SESSION_NAME="ssh_session"
tmux new-session -d -s $SESSION_NAME

# Send commands to the new pane
tmux send-keys -t $SESSION_NAME "ssh $REMOTE_USER@$REMOTE_HOST" C-m
sleep 1  # Wait for SSH to connect
#tmux send-keys -t $SESSION_NAME "sudo su" C-m
sleep 1  # Wait for the sudo su command
tmux send-keys -t $SESSION_NAME "$INITIAL_COMMAND"

# Attach to the tmux session
tmux attach-session -t $SESSION_NAME

