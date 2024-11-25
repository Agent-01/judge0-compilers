# Check for latest version here: https://hub.docker.com/_/buildpack-deps?tab=tags&page=1&name=buster&ordering=last_updated
# This is just a snapshot of buildpack-deps:buster that was last updated on 2019-12-28.
FROM judge0/buildpack-deps:buster-2019-12-28

# Check for latest version here: https://gcc.gnu.org/releases.html, https://ftpmirror.gnu.org/gcc
ENV GCC_VERSIONS \
    9.2.0 \
    12.3.0
RUN set -xe && \
    for VERSION in $GCC_VERSIONS; do \
      curl -fSsL "https://ftpmirror.gnu.org/gcc/gcc-$VERSION/gcc-$VERSION.tar.gz" -o /tmp/gcc-$VERSION.tar.gz && \
      mkdir /tmp/gcc-$VERSION && \
      tar -xf /tmp/gcc-$VERSION.tar.gz -C /tmp/gcc-$VERSION --strip-components=1 && \
      rm /tmp/gcc-$VERSION.tar.gz && \
      cd /tmp/gcc-$VERSION && \
      ./contrib/download_prerequisites && \
      { rm *.tar.* || true; } && \
      tmpdir="$(mktemp -d)" && \
      cd "$tmpdir"; \
      if [ $VERSION = "9.2.0" ]; then \
        ENABLE_FORTRAN=",fortran"; \
      else \
        ENABLE_FORTRAN=""; \
      fi; \
      /tmp/gcc-$VERSION/configure \
        --build=x86_64-linux-gnu \
        --host=x86_64-linux-gnu \
        --target=x86_64-linux-gnu \
        --enable-checking=release \
        --disable-multilib \
        --enable-languages=c,c++$ENABLE_FORTRAN \
        --prefix=/usr/local/gcc-$VERSION && \
      make -j$(nproc) && \
      make -j$(nproc) install-strip && \
      rm -rf /tmp/*; \
    done

# Check for latest version here: https://www.ruby-lang.org/en/downloads
ENV RUBY_VERSIONS \
      2.7.3 \
      3.3.1
RUN set -xe && \
    for VERSION in $RUBY_VERSIONS; do \
      curl -fSsL "https://cache.ruby-lang.org/pub/ruby/${VERSION%.*}/ruby-$VERSION.tar.gz" -o /tmp/ruby-$VERSION.tar.gz && \
      mkdir /tmp/ruby-$VERSION && \
      tar -xf /tmp/ruby-$VERSION.tar.gz -C /tmp/ruby-$VERSION --strip-components=1 && \
      rm /tmp/ruby-$VERSION.tar.gz && \
      cd /tmp/ruby-$VERSION && \
      ./configure \
        --disable-install-doc \
        --prefix=/usr/local/ruby-$VERSION && \
      make -j$(nproc) && \
      make -j$(nproc) install && \
      rm -rf /tmp/*; \
    done

# Check for latest version here: https://www.python.org/downloads
ENV PYTHON_VERSIONS \
      3.11.8
RUN set -xe && \
    for VERSION in $PYTHON_VERSIONS; do \
      curl -fSsL "https://www.python.org/ftp/python/$VERSION/Python-$VERSION.tar.xz" -o /tmp/python-$VERSION.tar.xz && \
      mkdir /tmp/python-$VERSION && \
      tar -xf /tmp/python-$VERSION.tar.xz -C /tmp/python-$VERSION --strip-components=1 && \
      rm /tmp/python-$VERSION.tar.xz && \
      cd /tmp/python-$VERSION && \
      ./configure \
        --prefix=/usr/local/python-$VERSION && \
      make -j$(nproc) && \
      make -j$(nproc) install && \
      rm -rf /tmp/*; \
    done

# Check for latest version here: https://jdk.java.net
RUN set -xe && \
    curl -fSsL "https://download.java.net/java/GA/jdk22.0.1/c7ec1332f7bb44aeba2eb341ae18aca4/8/GPL/openjdk-22.0.1_linux-x64_bin.tar.gz" -o /tmp/openjdk22.tar.gz && \
    mkdir /usr/local/openjdk22 && \
    tar -xf /tmp/openjdk22.tar.gz -C /usr/local/openjdk22 --strip-components=1 && \
    rm /tmp/openjdk22.tar.gz && \
    ln -s /usr/local/openjdk22/bin/javac /usr/local/bin/javac && \
    ln -s /usr/local/openjdk22/bin/java /usr/local/bin/java && \
    ln -s /usr/local/openjdk22/bin/jar /usr/local/bin/jar

# Check for latest version here: https://www.freepascal.org/download.html
ENV FPC_VERSIONS \
      3.2.2
RUN set -xe && \
    for VERSION in $FPC_VERSIONS; do \
      curl -fSsL "https://nchc.dl.sourceforge.net/project/freepascal/Linux/$VERSION/fpc-$VERSION.x86_64-linux.tar?viasf=1" -o /tmp/fpc-$VERSION.tar && \
      mkdir /tmp/fpc-$VERSION && \
      tar -xf /tmp/fpc-$VERSION.tar -C /tmp/fpc-$VERSION --strip-components=1 && \
      rm /tmp/fpc-$VERSION.tar && \
      cd /tmp/fpc-$VERSION && \
      echo "/usr/local/fpc-$VERSION" | ./install.sh && \
      rm -rf /tmp/*; \
    done

# Check for latest version here: https://www.haskell.org/ghc/download.html
ENV HASKELL_VERSIONS \
      8.8.4
RUN set -xe && \
    apt-get update && \
    apt-get install -y --no-install-recommends libgmp-dev libtinfo5 && \
    rm -rf /var/lib/apt/lists/* && \
    for VERSION in $HASKELL_VERSIONS; do \
      curl -fSsL "https://downloads.haskell.org/~ghc/$VERSION/ghc-$VERSION-x86_64-deb8-linux.tar.xz" -o /tmp/ghc-$VERSION.tar.xz && \
      mkdir /tmp/ghc-$VERSION && \
      tar -xf /tmp/ghc-$VERSION.tar.xz -C /tmp/ghc-$VERSION --strip-components=1 && \
      rm /tmp/ghc-$VERSION.tar.xz && \
      cd /tmp/ghc-$VERSION && \
      ./configure \
        --prefix=/usr/local/ghc-$VERSION && \
      make -j$(nproc) install && \
      rm -rf /tmp/*; \
    done

# Check for latest version here: https://www.mono-project.com/download/stable
# ENV MONO_VERSIONS \
#       6.12.0.206
# RUN set -xe && \
#     apt-get update && \
#     apt-get install -y --no-install-recommends cmake && \
#     rm -rf /var/lib/apt/lists/* && \
#     for VERSION in $MONO_VERSIONS; do \
#       curl -fSsL "https://download.mono-project.com/sources/mono/mono-$VERSION.tar.xz" -o /tmp/mono-$VERSION.tar.xz && \
#       mkdir /tmp/mono-$VERSION && \
#       tar -xf /tmp/mono-$VERSION.tar.xz -C /tmp/mono-$VERSION --strip-components=1 && \
#       rm /tmp/mono-$VERSION.tar.xz && \
#       cd /tmp/mono-$VERSION && \
#       ./configure \
#         --prefix=/usr/local/mono-$VERSION && \
#       make -j$(nproc) && \
#       make -j$(proc) install && \
#       rm -rf /tmp/*; \
#     done

RUN set -xe && \
    PREFIX=$@ && \
    if [ -z $PREFIX ]; \
    then PREFIX="/usr/local"; \
    fi && \
    # Ensure that all required packages are installed.
    apt-get update && \
    apt-get install -y --no-install-recommends git autoconf libtool automake build-essential gettext cmake python && \
    rm -rf /var/lib/apt/lists/* && \
    PATH=$PREFIX/bin:$PATH && \
    git clone https://github.com/mono/mono.git && \
    cd mono && \
    ./autogen.sh --prefix=$PREFIX && \
    make && \
    make install

# Check for latest version here: https://nodejs.org/en
ENV NODE_VERSIONS \
      20.12.2
RUN set -xe && \
    for VERSION in $NODE_VERSIONS; do \
      curl -fSsL "https://nodejs.org/dist/v$VERSION/node-v$VERSION.tar.gz" -o /tmp/node-$VERSION.tar.gz && \
      mkdir /tmp/node-$VERSION && \
      tar -xf /tmp/node-$VERSION.tar.gz -C /tmp/node-$VERSION --strip-components=1 && \
      rm /tmp/node-$VERSION.tar.gz && \
      cd /tmp/node-$VERSION && \
      ./configure \
        --prefix=/usr/local/node-$VERSION && \
      make -j$(nproc) && \
      make -j$(nproc) install && \
      rm -rf /tmp/*; \
    done

# Check for latest version here: https://www.rust-lang.org
ENV RUST_VERSIONS \
      1.77.2
RUN set -xe && \
    for VERSION in $RUST_VERSIONS; do \
      curl -fSsL "https://static.rust-lang.org/dist/rust-$VERSION-x86_64-unknown-linux-gnu.tar.gz" -o /tmp/rust-$VERSION.tar.gz && \
      mkdir /tmp/rust-$VERSION && \
      tar -xf /tmp/rust-$VERSION.tar.gz -C /tmp/rust-$VERSION --strip-components=1 && \
      rm /tmp/rust-$VERSION.tar.gz && \
      cd /tmp/rust-$VERSION && \
      ./install.sh \
        --prefix=/usr/local/rust-$VERSION \
        --components=rustc,rust-std-x86_64-unknown-linux-gnu && \
      rm -rf /tmp/*; \
    done

# Check for latest version here: https://golang.org/dl
ENV GO_VERSIONS \
      1.22.3
RUN set -xe && \
    for VERSION in $GO_VERSIONS; do \
        curl -fSsL "https://go.dev/dl/go$VERSION.linux-amd64.tar.gz" -o /tmp/go$VERSION.linux-amd64.tar.gz && \
        rm -rf /usr/local/go && tar -C /usr/local -xzf /tmp/go$VERSION.linux-amd64.tar.gz && \
        rm -rf /tmp/*; \
    done

# Check for latest version here: https://www.php.net/downloads
ENV PHP_VERSIONS \
      8.3.6
RUN set -xe && \
    apt-get update && \
    apt-get install -y --no-install-recommends bison re2c && \
    rm -rf /var/lib/apt/lists/* && \
    for VERSION in $PHP_VERSIONS; do \
      curl -fSsL "https://codeload.github.com/php/php-src/tar.gz/php-$VERSION" -o /tmp/php-$VERSION.tar.gz && \
      mkdir /tmp/php-$VERSION && \
      tar -xf /tmp/php-$VERSION.tar.gz -C /tmp/php-$VERSION --strip-components=1 && \
      rm /tmp/php-$VERSION.tar.gz && \
      cd /tmp/php-$VERSION && \
      ./buildconf --force && \
      ./configure \
        --prefix=/usr/local/php-$VERSION && \
      make -j$(nproc) && \
      make -j$(nproc) install && \
      rm -rf /tmp/*; \
    done

# Check for latest version here: https://www.lua.org/download.html
ENV LUA_VERSIONS \
      5.4.6
RUN set -xe && \
    for VERSION in $LUA_VERSIONS; do \
      curl -fSsL "https://www.lua.org/ftp/lua-$VERSION.tar.gz" -o /tmp/lua-$VERSION.tar.gz && \
      tar -xf /tmp/lua-$VERSION.tar.gz -C /usr/local && \
      cd /usr/local/lua-$VERSION && \
      make all test && \
      rm -rf /tmp/*; \
    done; \
    ln -s /lib/x86_64-linux-gnu/libreadline.so.7 /lib/x86_64-linux-gnu/libreadline.so.6

# Check for latest version here: https://github.com/microsoft/TypeScript/releases
# ENV TYPESCRIPT_VERSIONS \
#       5.4.5
# RUN set -xe && \
#     curl -fSsL "https://deb.nodesource.com/setup_12.x" | bash - && \
#     apt-get update && \
#     apt-get install -y --no-install-recommends nodejs && \
#     rm -rf /var/lib/apt/lists/* && \
#     for VERSION in $TYPESCRIPT_VERSIONS; do \
#       npm install -g typescript@$VERSION; \
#     done

# Check for latest version here: https://nasm.us
ENV NASM_VERSIONS \
      2.16.03
RUN set -xe && \
    for VERSION in $NASM_VERSIONS; do \
      curl -fSsL "https://www.nasm.us/pub/nasm/releasebuilds/$VERSION/nasm-$VERSION.tar.gz" -o /tmp/nasm-$VERSION.tar.gz && \
      mkdir /tmp/nasm-$VERSION && \
      tar -xf /tmp/nasm-$VERSION.tar.gz -C /tmp/nasm-$VERSION --strip-components=1 && \
      rm /tmp/nasm-$VERSION.tar.gz && \
      cd /tmp/nasm-$VERSION && \
      ./configure \
        --prefix=/usr/local/nasm-$VERSION && \
      make -j$(nproc) nasm ndisasm && \
      make -j$(nproc) strip && \
      make -j$(nproc) install && \
      echo "/usr/local/nasm-$VERSION/bin/nasm -o main.o \$@ && ld main.o" >> /usr/local/nasm-$VERSION/bin/nasmld && \
      chmod +x /usr/local/nasm-$VERSION/bin/nasmld && \
      rm -rf /tmp/*; \
    done

# Check for latest version here: https://packages.debian.org/buster/clang-7
# Used for additional compilers for C, C++ and used for Objective-C.
RUN set -xe && \
    apt-get update && \
    apt-get install -y --no-install-recommends clang-7 gnustep-devel && \
    rm -rf /var/lib/apt/lists/*

# Check for latest version here: https://cloud.r-project.org/src/base
ENV R_VERSIONS \
      4.4.0
RUN set -xe && \
    apt-get update && \
    apt-get install -y --no-install-recommends libpcre2-dev gfortran && \
    rm -rf /var/lib/apt/lists/* && \
    for VERSION in $R_VERSIONS; do \
      curl -fSsL "https://cloud.r-project.org/src/base/R-4/R-$VERSION.tar.gz" -o /tmp/r-$VERSION.tar.gz && \
      mkdir /tmp/r-$VERSION && \
      tar -xf /tmp/r-$VERSION.tar.gz -C /tmp/r-$VERSION --strip-components=1 && \
      rm /tmp/r-$VERSION.tar.gz && \
      cd /tmp/r-$VERSION && \
      ./configure \
        --prefix=/usr/local/r-$VERSION && \
      make -j$(nproc) && \
      make -j$(nproc) install && \
      rm -rf /tmp/*; \
    done

# Check for latest version here: https://packages.debian.org/buster/sqlite3
# Used for support of SQLite.
RUN set -xe && \
    apt-get update && \
    apt-get install -y --no-install-recommends sqlite3 && \
    rm -rf /var/lib/apt/lists/*

# Check for latest version here: https://www.pypy.org/download.html
# Used for support of PyPy.
RUN wget https://downloads.python.org/pypy/pypy3.10-v7.3.16-linux64.tar.bz2 --no-check-certificate -O /tmp/pypy3.10-v7.3.16-linux64.tar.bz2 && \
    mkdir /tmp/pypy3.10 && \
    tar -xf /tmp/pypy3.10-v7.3.16-linux64.tar.bz2 -C /tmp/pypy3.10 && \
    rm /tmp/pypy3.10-v7.3.16-linux64.tar.bz2 && \
    mv /tmp/pypy3.10/pypy3.10-v7.3.16-linux64 /usr/local/pypy3.10-v7.3.16-linux64 && \
    rm -rf /tmp/pypy3.10

# Brainfuck
# Check for latest version here https://github.com/redraiment/brainfuck
RUN wget https://github.com/redraiment/brainfuck/releases/download/v0.5.0/brainfuck-0.5.0-x86_64.gz -O /tmp/brainfuck-0.5.0-x86_64.gz && \
    gunzip /tmp/brainfuck-0.5.0-x86_64.gz && \
    mv /tmp/brainfuck-0.5.0-x86_64 /usr/local/brainfuck && \
    chmod +x /usr/local/brainfuck

RUN set -xe && \
    apt-get update && \
    apt-get install -y --no-install-recommends locales && \
    rm -rf /var/lib/apt/lists/* && \
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen
ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8

RUN set -xe && \
    apt-get update && \
    apt-get install -y --no-install-recommends git libcap-dev && \
    rm -rf /var/lib/apt/lists/* && \
    git clone https://github.com/judge0/isolate.git /tmp/isolate && \
    cd /tmp/isolate && \
    git checkout ad39cc4d0fbb577fb545910095c9da5ef8fc9a1a && \
    make -j$(nproc) install && \
    rm -rf /tmp/*
ENV BOX_ROOT /var/local/lib/isolate

LABEL maintainer="Herman Zvonimir Došilović <hermanz.dosilovic@gmail.com>"
LABEL version="1.4.0"
