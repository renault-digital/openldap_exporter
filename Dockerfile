FROM golang:1.13 as builder

WORKDIR /go/src/github.com/tomcz/openldap_exporter
COPY . .

RUN make build && chmod +x ./cmd/openldap_exporter

FROM gcr.io/distroless/base:debug-nonroot
WORKDIR /
COPY --from=builder /go/src/github.com/tomcz/openldap_exporter/target/openldap_exporter-linux /openldap_exporter
USER nonroot:nonroot

ENTRYPOINT ["/openldap_exporter"]
