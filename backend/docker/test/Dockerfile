FROM golang:1.23-rc-alpine

WORKDIR /app

ENV LIBVIPS_VERSION_MAJOR 8
ENV LIBVIPS_VERSION_MINOR 4
ENV LIBVIPS_VERSION_PATCH 5
ENV LIBVIPS_VERSION $LIBVIPS_VERSION_MAJOR.$LIBVIPS_VERSION_MINOR.$LIBVIPS_VERSION_PATCH
ENV LIBVIPS_SRC_URL http://www.vips.ecs.soton.ac.uk/supported/$LIBVIPS_VERSION_MAJOR.$LIBVIPS_VERSION_MINOR/vips-$LIBVIPS_VERSION.tar.gz

# RUN apk add --no-cache --virtual .temp-deps \
#     g++ make \
#     curl \
#     automake \
#     libtool \
#     tar \
#     gettext && \
#     apk add --no-cache --virtual .dev-deps \
#     libc-dev \
#     glib-dev \
#     libpng-dev \
#     libwebp-dev \
#     libexif-dev \
#     libxml2-dev \
#     libjpeg-turbo-dev \
#     libgsf-dev \
#     giflib-dev \
#     gobject-introspection-dev \
#     ghostscript-dev \
#     fftw-dev \
#     pango-dev \
#     poppler-dev \
#     cairo-dev \
#     librsvg-dev && \
#     apk add --no-cache --virtual .run-deps \
#     gcc \
#     git \
#     pkgconfig \
#     glib \
#     libpng \
#     libwebp \
#     libexif \
#     libxml2 \
#     libjpeg-turbo \
#     libgsf \
#     giflib \
#     gobject-introspection \
#     ghostscript \
#     fftw \
#     pango \
#     poppler \
#     cairo \
#     librsvg && \
#     curl -O $LIBVIPS_SRC_URL && \
#     tar zvxf vips-${LIBVIPS_VERSION}.tar.gz && \
#     cd vips-${LIBVIPS_VERSION} && \
#     ./configure \
#     --disable-debug \
#     --disable-dependency-tracking \
#     --disable-introspection \
#     --disable-static \
#     --enable-gtk-doc-html=no \
#     --enable-gtk-doc=no \
#     --enable-pyvips8=no \
#     --without-orc \
#     --without-python && \
#     make -j4 && \
#     make install && \
#     rm -rf /tmp/vips-* && \
#     rm -rf /var/cache/apk/* && \
#     apk del .temp-deps

ENV CPATH /usr/local/include
ENV LIBRARY_PATH /usr/local/lib
ENV PKG_CONFIG_PATH /usr/local/lib/pkgconfig:/usr/lib/pkgconfig:$PKG_CONFIG_PATH
ENV GOROOT /usr/local/go
ENV GOPATH /go
ENV PATH /go/bin:$PATH

COPY . .

EXPOSE 3200

# Set the entrypoint to bash for debugging
ENTRYPOINT ["bash"]