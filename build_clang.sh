#! /bin/bash

if [ -z "$BUILD_CLANG_SH_INCLUDED" ]    # BUILD_CLANG_SH_INCLUDED_GUARD
then
  BUILD_CLANG_SH_INCLUDED=1

  # Save CWD
  SCWD=$(pwd)

  source ./sources.sh
  source ./log.sh

  cd $LLVM_WD

  cp "$SOURCES/cmake_config.sh" .
  cp "$SOURCES/sources.sh" .
  chmod +x cmake_config.sh

  mkdir my-build
  cd my-build

  ./../cmake_config.sh
  ninja install

  # Add Clang to Path
  export PATH="$INSTALL_DIR/clang/bin:$PATH"

  # Change back to saved directory
  cd $SCWD

fi    # BUILD_CLANG_SH_INCLUDED_GUARD
