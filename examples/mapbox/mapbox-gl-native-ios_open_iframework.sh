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

# Version info from Mapbox.framework
# plutil -- property list utility
  # plutil -help
  # man plutil

plutil -p build/ios/pkg/dynamic/Mapbox.framework/Info.plist | grep CFBundleIdentifier
plutil -p build/ios/pkg/dynamic/Mapbox.framework/Info.plist | grep CFBundleShortVersionString
plutil -p build/ios/pkg/dynamic/Mapbox.framework/Info.plist | grep CFBundleVersion
plutil -p build/ios/pkg/dynamic/Mapbox.framework/Info.plist | grep MGLSemanticVersionString
plutil -p build/ios/pkg/dynamic/Mapbox.framework/Info.plist | grep MGLCommitHash
plutil -p build/ios/pkg/dynamic/Mapbox.framework/Info.plist
