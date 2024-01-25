FROM alpine

LABEL Blaine Miller <blaine@wemiller.com>

ENV ARCH=amd64
ENV PLAN=sync
ENV TARGET=crypto:
ENV SOURCE=/data
ENV BWLIMIT=125M

RUN apk update \
    && apk add \
	flock \
	htop \
	tree \
	vim \
	bash \
	git \
	openssh-client \
        openssl \
        ca-certificates \
        fuse \
    && cd /tmp \
    && wget -q http://downloads.rclone.org/rclone-current-linux-${ARCH}.zip \
    && unzip /tmp/rclone-current-linux-${ARCH}.zip \
    && mv /tmp/rclone-*-linux-${ARCH}/rclone /usr/bin \
    && rm -r /tmp/rclone*

COPY  --chmod=777 entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["crond", "-f", "-l", "8"]
