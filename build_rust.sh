#! /bin/bash

source ./sources.sh
source ./log.sh

if [ -z "$BUILD_RUST_GUARD" ]   # BUILD_RUST_GUARD
then
  BUILD_RUST_GUARD=1

  # Save CWD
  SCWD=$(pwd)

  # Build Rust
  cd $RUST_WD
  # This version of Rust should not need modification of the config.toml as it should already be changed and included
  ./x.py build

  # Add rust to $PATH
  export PATH="$INSTALL_DIR/.cargo/bin:$PATH"

  # Add Cargo to bin PATH
  cd $RUST_BUILD_DIR/stage2/bin
  ln -s $RUST_BUILD_DIR/stage2-tools-bin/cargo cargo

  # Add custom toolchain to rustup
  rustup toolchain link mpk-step $RUST_BUILD_DIR/stage2/

  # Set mpk-step as default toolchain
  rustup default mpk-step

  cd $RUST_WD

  # Return to previous directory
  cd $SCWD
fi
