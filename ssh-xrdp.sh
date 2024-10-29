#!/bin/bash

ssh-keygen -f "$HOME/.ssh/known_hosts" -R "[localhost]:22000" 

# <<< $'yes\n' >/dev/null 2>&1

ssh -p 22000 localhost

