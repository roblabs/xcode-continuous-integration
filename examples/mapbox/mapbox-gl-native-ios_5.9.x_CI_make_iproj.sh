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
# Log the explicit path to the Workspace
echo xed ${XCS_PRIMARY_REPO_DIR}/platform/ios/ios.xcworkspace

cd ${XCS_PRIMARY_REPO_DIR}
pwd

# Versions of build dependencies
brew list --versions node cmake ccache

gem list xcpretty jazzy

# This version of mapbox-gl-native is heavy with submodules
git submodule sync && git submodule update --init --recursive
wait

make iproj
wait

# MARK: - Show Xcode Build Settings
cd platform/ios # to location of ios.xcworkspace

set +v

xcodebuild -showBuildSettings | grep PRODUCT_BUNDLE_IDENTIFIER
xcodebuild -showBuildSettings | grep CURRENT_PROJECT_VERSION
xcodebuild -showBuildSettings | grep CURRENT_SEMANTIC_VERSION
xcodebuild -showBuildSettings
