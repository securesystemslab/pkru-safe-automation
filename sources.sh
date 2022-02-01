#! /bin/bash

if [ -z "$SOURCES_SH_INCLUDED" ]    #SOURCES_SH_INCLUDE_GUARD
then
  SOURCES_SH_INCLUDED=1

  INSTALL_DIR=${HOME}
  BASE_PATH="${HOME}/mpk-test-dir"

  # Setting up Source directory location
  SOURCES="$BASE_PATH/automation"

  # Build Directories
  LLVM_WD="$INSTALL_DIR/llvm-project"
  RUST_WD="$INSTALL_DIR/rust"
  RUST_BUILD_DIR="$INSTALL_DIR/rust/build/x86_64-unknown-linux-gnu"

  # Artifacts Directory
  ARTIFACTS_DIR="${BASE_PATH}/artifacts"
fi    #SOURCES_SH_INCLUDE_GUARD

