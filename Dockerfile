FROM scratch as builder
ADD ./steamos /
ADD ./steamos/usr/share/factory /

FROM scratch
COPY --from=builder / /
