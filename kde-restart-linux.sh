# From https://superuser.com/questions/395820/how-to-properly-end-a-kde-session-from-shell-without-root-privileges

loginctl terminate-session 1 && sudo reboot 

#qdbus6 org.kde.Shutdown /Shutdown  org.kde.Shutdown.logoutAndReboot

#qdbus6 org.kde.ksmserver /KSMServer logout 0 1 0

#First parameter:
#
#    0 = Do not wait for confirmation
#    1 = Wait for confirmation (with a 30 second timeout)
#
#Second parameter:
#
#    -1 = Prompt for action, defaulting to shutdown (Only makes sense when waiting for confirmation.)
#    0 = Logout
#    1 = Restart
#    2 = Shutdown
#
