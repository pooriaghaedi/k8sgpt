FROM golang:1.20.3-alpine3.16 AS builder

ENV CGO_ENABLED=0

WORKDIR /workspace

COPY go.mod go.sum ./
RUN go mod download

COPY ./ ./

RUN chmod +x entrypoint.sh && go build -o /workspace/k8sgpt ./

FROM gcr.io/distroless/static AS production

LABEL org.opencontainers.image.source="https://github.com/k8sgpt-ai/k8sgpt" \
    org.opencontainers.image.url="https://k8sgpt.ai" \
    org.opencontainers.image.title="k8sgpt" \
    org.opencontainers.image.vendor="the k8sgpt-ai maintainers" \
    org.opencontainers.image.licenses="MIT"

WORKDIR /
COPY --from=builder /workspace/k8sgpt  .
COPY --from=builder /workspace/entrypoint.sh  .
USER 65532:65532

ENTRYPOINT ["/entrypoint.sh"]