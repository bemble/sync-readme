FROM alpine:3.10

RUN apk update \
    && apk add curl jq oath-toolkit

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
