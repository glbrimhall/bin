# From https://blog.bogdancaraman.com/set-time-enable-ntp-debian/ 
# install the package
# From https://liberiangeek.net/2026/11/set-timezone-debian-13/
sudo apt update
sudo apt install systemd-timesyncd

# enable and start the service
sudo systemctl enable systemd-timesyncd

sudo systemctl start systemd-timesyncd

# enable NTP sync via timedatectl
sudo timedatectl set-ntp true
sudo timedatectl set-local-rtc 0

# check the sync status
timedatectl status
