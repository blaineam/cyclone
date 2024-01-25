#!/bin/sh

env >> /etc/environment

echo -e "- @eaDir/**\n- *@Syno*\n- #recycle/**" > /filters.txt

(crontab -l ; echo "* * * * * /usr/bin/flock -n /tmp/cyclone.lockfile /usr/bin/rclone ${PLAN} --stats 1m --size-only --log-level ERROR --log-file=/proc/1/fd/1 --low-level-retries 100 --tpslimit 20 --retries 100 --transfers 20 --checkers 20 --order-by modtime,desc --check-first --filter-from /filters.txt --bwlimit ${BWLIMIT} ${EXTRAFLAGS} \"${SOURCE}\" \"${TARGET}\"") | crontab -

# execute CMD
echo "$@"
exec "$@"
