#!/bin/sh
# Copyright © 2020-2021 ePi Rational, Inc.. All rights reserved.
# SPDX-License-Identifier: MIT
# XCS Pre-Integration Script Trigger name:   maplibre_gl_native_ios_CI_make_iproj
echo This log was generated at $(date) from: maplibre_gl_native_ios_CI_make_iproj.sh

# MARK: - Update PATH
echo $PATH
export PATH=/usr/local/bin:.:$PATH
# `brew` location on macOS for Mac Silicon
export PATH=/opt/homebrew/bin:$PATH
echo $PATH

# set verbose
set -v

# MARK: - project specific build commands
# Log the explicit path to the Workspace
echo xed ${XCS_PRIMARY_REPO_DIR}/platform/ios/ios.xcworkspace

cd ${XCS_PRIMARY_REPO_DIR}
pwd

# Brew based dependencies
brew list --versions cmake      || brew install cmake
brew list --versions ccache     || brew install ccache
brew list --versions pkg-config || brew install pkg-config
brew list --versions glfw      || brew install glfw

# Ruby based dependencies
brew list --versions ruby@2.6       || brew install ruby@2.6
export RUBY_BREW=$(brew --prefix ruby@2.6)  &&  echo RUBY_BREW=${RUBY_BREW}
export GEM_DIR=$(${RUBY_BREW}/bin/gem environment gemdir) &&  echo GEM_DIR=${GEM_DIR}
export PATH=${RUBY_BREW}/bin:$PATH
export PATH=${GEM_DIR}/bin:$PATH
jazzy -version     || gem install jazzy
xcpretty --version || gem install xcpretty
gem list jazzy xcpretty

# This version of mapbox-gl-native is heavy with submodules
git submodule sync && git submodule update --init --recursive
wait

cd ${XCS_PRIMARY_REPO_DIR}/platform/ios

make iproj CI=1
wait

# MARK: - Show Xcode Build Settings
cd ${XCS_PRIMARY_REPO_DIR}/platform/ios/platform/ios # to location of ios.xcworkspace

set +v

xcodebuild -showBuildSettings | grep "PRODUCT_BUNDLE_IDENTIFIER\|CURRENT_PROJECT_VERSION\|CURRENT_SEMANTIC_VERSION"
xcodebuild -showBuildSettings
