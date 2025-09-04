FROM scratch as builder
ADD ./steamos /
ADD ./steamos/usr/share/factory /

# not removing libcroco holo-desync holo-keyring holo-pacman holo-pipewire holo-sudo holo-wireplumber elfutils
RUN sed -r -i 's/\[(jupiter|core|extra|community|multilib|holo)\]/\[\1-rel\]/g' /etc/pacman.conf \
 && pacman-key --init \
 && pacman-key --populate archlinux \
 && pacman-key --populate holo \
 && pacman -Sy \
#  && comm -1 -2  <(pacman -Qeq | sort) <(pacman -Qoq /usr/include/ | sort) | pacman -S --noconfirm - \
 && comm -1 -2  <(pacman -Qdq | sort | sed "/^filesystem$/d") <(pacman -Qoq /usr/include/ | sort | sed "/^filesystem$/d") | pacman -S --noconfirm --asdeps - \
 && pacman -S --noconfirm gcc make autoconf automake bison fakeroot flex m4 tpm2-tss \
 && yes | pacman -Scc

FROM scratch
COPY --from=builder / /
