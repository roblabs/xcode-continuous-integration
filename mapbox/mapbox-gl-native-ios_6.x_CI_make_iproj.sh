#!/bin/sh
# Pre-Integration Script
#   mapbox-gl-native-ios_6.x

# set verbose
set -v

# MARK: - project specific build commands
cd ${XCS_PRIMARY_REPO_DIR}
pwd

# Versions of `brew` dependencies
/usr/local/bin/brew list --versions carthage cmake ccache pkg-config glfw3

# Does `.netrc` exist?
ll ~/.netrc  && stat -f '%A %N' ~/.netrc

# carthage
/usr/local/bin/carthage update --platform iOS --use-netrc
wait

cd ${XCS_PRIMARY_REPO_DIR}
pwd
/usr/bin/make iproj
wait

set +v
