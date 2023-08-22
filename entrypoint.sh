#!/bin/sh

env >> /etc/environment

(crontab -l ; echo "* * * * * /usr/bin/rclone sync --stats-one-line -P --stats 5s --ignore-existing --log-level NOTICE --ignore-times --low-level-retries 100 --tpslimit 20 --retries 100 --transfers 20 --checkers 20 --bwlimit ${BWLIMIT} \"${SOURCE}\" \"${TARGET}\" > /proc/1/fd/1 2>&1") | crontab -

# execute CMD
echo "$@"
exec "$@"
