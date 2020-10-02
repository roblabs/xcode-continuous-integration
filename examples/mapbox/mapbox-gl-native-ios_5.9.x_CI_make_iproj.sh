#!/bin/sh
# Pre-Integration Script
#   mapbox_gl_native_ios_59

# MARK: - Update PATH
echo $PATH
export PATH=/usr/local/bin:.:$PATH
echo $PATH

# set verbose
set -v

# MARK: - project specific build commands
cd ${XCS_PRIMARY_REPO_DIR}
pwd

# Versions of build dependencies
brew list --versions node cmake ccache

# Heavy with submodules
git submodule sync && git submodule update --init --recursive
wait

make iproj
wait

set +v
