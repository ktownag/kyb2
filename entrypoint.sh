#!/bin/bash
if [[ -n $bot_token && -n $bot_pw ]]; then
cd /remoteTelegramShell
sed -i "s/token=/token=${bot_token}/" config.txt
sed -i "s/password=/password=${bot_pw}/" config.txt
pm2 start pyTelegramShellBot.py --interpreter=python3
fi

cd /usr/local/app/
if [[ -n $RCLONE_CONFIG ]]; then
echo "Rclone config detected"
echo -e "[dropbox]\n$RCLONE_CONFIG" > /root/.config/rclone/rclone.conf
rclone copy dropbox:v2p /usr/local/app/script
pm2 start sync.sh
fi

pm2-runtime index.js -n elecV2P
