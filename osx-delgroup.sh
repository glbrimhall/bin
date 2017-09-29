#!/bin/bash
set -x

GROUP=${1}

# Delete the group
dscl . -delete /Groups/$GROUP

