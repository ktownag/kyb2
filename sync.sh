#!/bin/bash
# Execute first time after the machine is boot
rclone sync /usr/local/app/script dropbox:elecv2p
inotifywait -m -q -r -e create -e modify -e move -e delete --format '%w%f:%e' /usr/local/app/script | \
while read; do \
    path=$(echo $REPLY | cut -d ":" -f 1); \
    event=$(echo $REPLY | cut -d ":" -f 2); \
    echo "$path was changed because of event $event"; \
    echo "Skipping $(timeout 3 cat | wc -l) further changes"; \
    rclone sync --delete-during /usr/local/app/script dropbox:elecv2p; \
done
