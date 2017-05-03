# Based on fnichol's docker-rust Dockerfile
# 
# Maintaining my own because I like to track stable more closely than
# fnichol's image updates
FROM buildpack-deps:jessie
MAINTAINER J. David Smith <emallson@atlanis.net>

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    gdb \
  && rm -rf /var/lib/apt/lists/*

ENV RUST_VERSION 1.17.0
ENV CARGO_HOME /cargo
ENV PATH $CARGO_HOME/bin:/root/.cargo/bin:$PATH
ENV SRC_PATH /src

RUN curl -sSf https://sh.rustup.rs \
  | env -u CARGO_HOME sh -s -- -y --default-toolchain "$RUST_VERSION" \
  && rustc --version && cargo --version \
  && mkdir -p "$CARGO_HOME" "$SRC_PATH"

WORKDIR $SRC_PATH

CMD ["/bin/bash"]

COPY cplex-root/cplex/ /opt/ibm/ILOG/CPLEX_Studio1263/cplex
