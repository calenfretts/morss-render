FROM alpine:3.20

WORKDIR /app

COPY . /app

RUN set -ex; \
    apk add --no-cache \
        python3 \
        py3-lxml \
        py3-setproctitle \
        py3-setuptools \
        py3-pip \
        py3-wheel; \
    python3 -m venv /opt/venv; \
    /opt/venv/bin/pip install --no-cache-dir --upgrade pip; \
    /opt/venv/bin/pip install --no-cache-dir '/app[full]'; \
    apk del py3-pip py3-wheel

ENV PATH="/opt/venv/bin:$PATH"

EXPOSE 10000

USER 1000:1000

ENTRYPOINT ["/bin/sh", "/app/morss-helper"]

CMD ["run"]

HEALTHCHECK CMD /bin/sh /app/morss-helper check
