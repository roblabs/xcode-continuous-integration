#!/bin/sh
# Pre-Integration Script
#   mapbox-gl-native-ios_5.9.x

# set verbose
set -v

# MARK: - project specific build commands

# Versions of `brew` dependencies
/usr/local/bin/brew list --versions node cmake ccache

cd ${XCS_PRIMARY_REPO_DIR}
pwd

set +v

git submodule sync && git submodule update --init --recursive
wait
