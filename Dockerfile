FROM alpine:3.17

ENV CGO_ENABLED = 0

WORKDIR /app

COPY entrypoint.sh /app/entrypoint.sh

RUN apk add --no-cache ca-certificates = 20220614-r4 git = 2.38.4-r1 curl && \
  rm -rf /var/cache/apk  /* && \
    LATESTVER=$(curl --silent "https://api.github.com/repos/k8sgpt-ai/k8sgpt/releases/latest" | \
    grep '"tag_name":' |                                            \
    sed -E 's/.*"([^"]+)".*/\1/') && \
    wget https: //github.com/k8sgpt-ai/k8sgpt/releases/download/$LATESTVER/k8sgpt_amd64.apk && \
    apk add --allow-untrusted k8sgpt_amd64.apk  && \
    chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]