FROM scratch as builder
ADD ./steamos /
ADD ./steamos/usr/share/factory /

# not removing libcroco holo-desync holo-keyring holo-pacman holo-pipewire holo-sudo holo-wireplumber elfutils
RUN sed -r -i 's/\[(jupiter|core|extra|community|multilib|holo)\]/\[\1-rel\]/g' /etc/pacman.conf \

FROM scratch
COPY --from=builder / /
