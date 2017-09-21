#!/bin/bash
set -x

USER=$1
GROUP=${2:-$USER}

# Remove user from the group
dseditgroup -o edit -d $USER -t user $GROUP

# Delete the group
dscl . -delete /Groups/$GROUP

# Delete the user
dscl localhost delete /Local/Default/Users/$USER
