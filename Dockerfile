FROM alpine:edge

# Set python to use utf-8 rather than ascii.
ENV \
  PYTHONIOENCODING="UTF-8" \
  LOGLEVEL="verbose"

RUN apk add --no-cache python2 && \
  python2 -m ensurepip && \
  rm -r /usr/lib/python*/ensurepip && \
  pip install --upgrade pip setuptools

# Install deluge
RUN apk add --no-cache \
  --repository http://nl.alpinelinux.org/alpine/edge/testing \
  deluge

ENV VERSION="==2.17.7"

# install flexget
RUN apk --no-cache add ca-certificates tzdata && \
  pip install --upgrade --force-reinstall --ignore-installed flexget$VERSION incremental constantly Automat Transmissionrpc && \
  pip install subliminal && \
  rm -r /root/.cache

VOLUME /config /downloads

ADD entry.sh .

ENTRYPOINT ["/entry.sh"]
