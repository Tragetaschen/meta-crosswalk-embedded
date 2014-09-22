FILESEXTRAPATHS_prepend := "${THISDIR}/crosswalk:"

SRC_URI += "\
    file://do_not_link_webrtc_with_x11.patch;patch=1 \
    file://embedded_chromium_crosswalk.patch;patch=1 \
    file://embedded_crosswalk.patch;patch=1 \
    file://xwalk_host_window_bounds.patch;patch=1 \
    file://xwalk \
    "

DEPENDS_remove = "gtk+"
DEPENDS_remove = "libxss"
DEPENDS += "virtual/egl"

RDEPENDS_crosswalk += "\
    libegl-mesa \
    libgbm \
    libglapi \
    libgles1-mesa \
    libgles2-mesa \
    mesa-driver-i915 \
    mesa-driver-i965 \
    "

DEFAULT_CONFIGURATION += "\
    -Dembedded=1 \
    -Dozone_platform_gbm=1 \
    -Dozone_platform_wayland=0 \
    -Duse_ozone=1 \
    -Duse_udev=1 \
    "

do_install_append() {
    # Remove the symlink and replace with the wrapper
    rm -f ${D}${bindir}/xwalk

    install -d ${D}${bindir}/
    install -m 0755 ${WORKDIR}/xwalk ${D}${bindir}/xwalk
}
