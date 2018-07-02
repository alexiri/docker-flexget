FROM alexiri/deluge-base:0.1

# Set python to use utf-8 rather than ascii.
ENV \
  PYTHONIOENCODING="UTF-8" \
  LOGLEVEL="verbose"

# install pip
RUN python2 -m ensurepip && \
  rm -r /usr/lib/python*/ensurepip && \
  pip install --upgrade pip setuptools

# install flexget
RUN apk --no-cache add ca-certificates tzdata && \
  pip install --upgrade --force-reinstall --ignore-installed \
   subliminal flexget && \
  rm -r /root/.cache

VOLUME /config /downloads

ADD entry.sh .

ENTRYPOINT ["/entry.sh"]
