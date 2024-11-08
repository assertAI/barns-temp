#!/bin/bash

# Create the reboot.service file
cat <<EOL | sudo tee /etc/systemd/system/reboot.service > /dev/null
[Unit]
Description=Reboot the system

[Service]
Type=oneshot
ExecStart=/sbin/reboot

[Install]
WantedBy=multi-user.target
EOL

# Create the reboot.timer file
cat <<EOL | sudo tee /etc/systemd/system/reboot.timer > /dev/null
[Unit]
Description=Daily Reboot Timer

[Timer]
OnCalendar=*-*-* 04:00:00
Persistent=true

[Install]
WantedBy=timers.target
EOL

# Reload systemd to recognize the new files

sudo timedatectl set-timezone Asia/Riyadh
sudo systemctl daemon-reload

# Enable and start the reboot timer
sudo systemctl enable reboot.timer
sudo systemctl start reboot.timer

# Check the status of the timer
sudo systemctl status reboot.timer
timedatectl

echo "Reboot timer has been set up to reboot the system daily at 4:00 AM."
