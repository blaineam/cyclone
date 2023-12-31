#!/bin/sh

env >> /etc/environment

echo -e "- @eaDir/**\n- *@Syno*\n- #recycle/**" > /filters.txt

(crontab -l ; echo "* * * * * /usr/bin/flock -n /tmp/cyclone.lockfile /usr/bin/rclone sync --stats-one-line -P --stats 1m --size-only --log-level NOTICE --low-level-retries 100 --tpslimit 20 --retries 100 --transfers 20 --checkers 20 --order-by modtime,desc --check-first --filter-from /filters.txt --bwlimit ${BWLIMIT} \"${SOURCE}\" \"${TARGET}\" > /proc/1/fd/1 2>&1") | crontab -

# execute CMD
echo "$@"
exec "$@"
