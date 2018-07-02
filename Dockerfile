FROM alpine:3.7

# Set python to use utf-8 rather than ascii.
ENV \
  PYTHONIOENCODING="UTF-8" \
  LOGLEVEL="verbose"

# install frolvlad/alpine-python3
RUN apk add --no-cache python3 && \
  python3 -m ensurepip && \
  rm -r /usr/lib/python*/ensurepip && \
  pip3 install --upgrade pip setuptools

# install flexget
RUN apk --no-cache add ca-certificates tzdata && \
  pip3 install --upgrade --force-reinstall --ignore-installed \
    flexget && \
  rm -r /root/.cache

VOLUME /config

CMD ["/usr/bin/flexget", "-c /config/config.yml", "daemon start --autoreload-config", "--loglevel $LOGLEVEL"]
