# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present Shanti Gilbert (https://github.com/shantigilbert)

PKG_NAME="dosbox-x"
PKG_VERSION="5688e35d497497cf4ca04f1c5d8e2bb5de65b72b"
PKG_SHA256="7292ad08b3f490580d05338dfd35d1f55ce7615ded8c74ef25d7d81bfbb8be4a"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/joncampbell123/dosbox-x"
PKG_URL="$PKG_SITE/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux glibc glib systemd dbus alsa-lib SDL2-git SDL2_net SDL_sound libpng zlib libvorbis flac libogg fluidsynth-git munt"
PKG_LONGDESC="DOSBox-X fork of the DOSBox project."
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="+lto"

pre_configure_target() {
  cd ${PKG_BUILD}
  rm -rf .${TARGET_NAME}

  PKG_CONFIGURE_OPTS_TARGET="--prefix=/usr \
                             --enable-core-inline \
                             --enable-dynrec \
                             --enable-unaligned_memory \
                             --disable-sdl \
							 --enable-sdl2 \
							 --enable-mt32 \
                             --with-sdl2-prefix=${SYSROOT_PREFIX}/usr"
}

pre_make_target() {
  # Define DOSBox version
  sed -e "s/SVN/SDL2/" -i ${PKG_BUILD}/config.h
}

post_makeinstall_target() {
  # Create config directory & install config
  mkdir -p ${INSTALL}/usr/config/emuelec/configs/dosbox/
  cp -a ${PKG_DIR}/scripts/* ${INSTALL}/usr/bin/
  cp -a ${PKG_DIR}/config/*  ${INSTALL}/usr/config/emuelec/configs/dosbox/
}
