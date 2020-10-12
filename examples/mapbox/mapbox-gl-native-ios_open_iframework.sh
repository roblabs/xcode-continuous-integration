#!/bin/sh
# Post-Integration Script
#   mapbox_gl_native_ios_open_iframework

# MARK: - Update PATH
echo $PATH
export PATH=/usr/local/bin:.:$PATH
echo $PATH

# set verbose
set -v

# MARK: - project specific build commands
# Log the explicit path to the Workspace
echo xed ${XCS_PRIMARY_REPO_DIR}/platform/ios/ios.xcworkspace

cd ${XCS_PRIMARY_REPO_DIR}
pwd

open build/ios/pkg

echo ${XCS_PRIMARY_REPO_DIR}/build/ios/pkg

cat build/ios/pkg/version.txt

echo open ${XCS_PRIMARY_REPO_DIR}/build/ios/pkg/documentation/index.html

cd ${XCS_PRIMARY_REPO_DIR}/build/ios/pkg

# Version info from Mapbox.framework
# plutil -- property list utility
  # plutil -help
  # man plutil

plutil -convert json dynamic/Mapbox.framework/Info.plist -o Info.json -r
# `json` depends on https://www.npmjs.com/package/json
#    npm install -g json
cat Info.json | json CFBundleIdentifier
cat Info.json | json CFBundleShortVersionString
cat Info.json | json CFBundleVersion
cat Info.json | json MGLSemanticVersionString
cat Info.json | json MGLCommitHash

# make script to move Mapbox.framework, docs, and license
SHORT_VERSION="$(cat Info.json | json CFBundleShortVersionString)"
echo "mv pkg/ ~/Downloads/${SHORT_VERSION}" > ../mv-pkg.sh

plutil -p dynamic/Mapbox.framework/Info.plist | grep CFBundleIdentifier
plutil -p dynamic/Mapbox.framework/Info.plist | grep CFBundleShortVersionString
plutil -p dynamic/Mapbox.framework/Info.plist | grep CFBundleVersion
plutil -p dynamic/Mapbox.framework/Info.plist | grep MGLSemanticVersionString
plutil -p dynamic/Mapbox.framework/Info.plist | grep MGLCommitHash
plutil -p dynamic/Mapbox.framework/Info.plist
