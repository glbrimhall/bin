# From https://blog.bogdancaraman.com/set-time-enable-ntp-debian/ 
# install the package
sudo apt update
sudo apt install systemd-timesyncd

# enable and start the service
sudo systemctl enable systemd-timesyncd

sudo systemctl start systemd-timesyncd

# enable NTP sync via timedatectl
sudo timedatectl set-ntp true

# check the sync status
timedatectl status
