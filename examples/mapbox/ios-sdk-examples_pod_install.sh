#!/bin/sh
# Pre-Integration Script
# Bot:     ios-sdk-examples main Examples Bot
# Script:  ios_sdk_examples_pod_install

# MARK: - Update PATH
echo $PATH
export PATH=/usr/local/bin:.:$PATH
echo $PATH

# set verbose
set -v

cd ${XCS_PRIMARY_REPO_DIR}
pwd

# MARK: - project specific build commands

# WARNING: CocoaPods requires your terminal to be using UTF-8 encoding.
export LANG=en_US.UTF-8

# Versions of build dependencies
pod --version

# This version is heavy with pod
pod install --repo-update
wait

echo xed ${XCS_PRIMARY_REPO_DIR}/Examples.xcworkspace
wait

set +v

xcodebuild -showBuildSettings | grep PRODUCT_BUNDLE_IDENTIFIER
xcodebuild -showBuildSettings | grep CURRENT_PROJECT_VERSION
xcodebuild -showBuildSettings | grep CURRENT_SEMANTIC_VERSION
xcodebuild -showBuildSettings
