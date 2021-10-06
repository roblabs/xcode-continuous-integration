#!/bin/sh
# Copyright © 2020-2021 ePi Rational, Inc.. All rights reserved.
# SPDX-License-Identifier: MIT
# XCS Post-Integration Script Trigger name:  maplibre_gl_native_ios_CI_make_xcframework
echo This log was generated at $(date) from: maplibre_gl_native_ios_CI_make_xcframework.sh

# MARK: - Update PATH
echo $PATH
export PATH=/usr/local/bin:.:$PATH
# `brew` location on macOS for Mac Silicon
export PATH=/opt/homebrew/bin:.:$PATH
echo $PATH

# set verbose
set -v

# MARK: - project specific build commands
# Log the explicit path to the Workspace
echo xed ${XCS_PRIMARY_REPO_DIR}/platform/ios/ios.xcworkspace

cd ${XCS_PRIMARY_REPO_DIR}/platform/ios/
pwd

/usr/bin/make xcframework BUILDTYPE=Release
wait
