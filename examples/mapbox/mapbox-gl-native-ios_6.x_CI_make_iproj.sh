#!/bin/sh
# Pre-Integration Script
#   mapbox_gl_native_ios_6x

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
brew list --versions carthage cmake ccache pkg-config glfw3

# Does `.netrc` exist?  What are the R/W permissions
ls -l ~/.netrc  && stat -f '%A %N' ~/.netrc

# carthage
carthage update --platform iOS --use-netrc
wait

cd ${XCS_PRIMARY_REPO_DIR}
pwd

make iproj
wait

set +v
