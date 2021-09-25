FROM alpine:edge

# Set python to use utf-8 rather than ascii.
ENV \
  PYTHONIOENCODING="UTF-8" \
  LOGLEVEL="verbose" \
  VERSION="==3.1.137"

RUN apk add --no-cache python3 && \
  python3 -m ensurepip && \
  rm -r /usr/lib/python*/ensurepip && \
  echo "done"
#  pip3 install --upgrade pip setuptools

# Install deluge
RUN apk add --no-cache \
  --repository http://nl.alpinelinux.org/alpine/edge/testing \
  deluge

# install flexget
RUN apk --no-cache add ca-certificates tzdata gcc g++ musl-dev python3-dev jpeg-dev zlib-dev linux-headers && \
  pip3 install --force-reinstall --ignore-installed flexget$VERSION transmission-rpc subliminal && \
  rm -r /root/.cache

VOLUME /config /downloads

ADD entry.sh .

ENTRYPOINT ["/entry.sh"]
