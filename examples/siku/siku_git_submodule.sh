#!/bin/sh
# Pre-Integration Script
#   siku_git_submodule

# MARK: - Xcode Server Environment Variable Reference
# https://developer.apple.com/library/archive/documentation/IDEs/Conceptual/xcode_guide-continuous_integration/EnvironmentVariableReference.html
echo XCS=${XCS}
echo "XCS_BOT_NAME             = ${XCS_BOT_NAME}"
echo "XCS_INTEGRATION_NUMBER   = ${XCS_INTEGRATION_NUMBER}"
echo "XCS_PRIMARY_REPO_DIR     = ${XCS_PRIMARY_REPO_DIR}"
echo "XCS_SOURCE_DIR           = ${XCS_SOURCE_DIR}"
echo "XCS_DERIVED_DATA_DIR     = ${XCS_DERIVED_DATA_DIR}"
echo "XCS_PRIMARY_REPO_REVISION= ${XCS_PRIMARY_REPO_REVISION}"  # Only used when not checking out a branch or a tag.
echo "XCS_PRIMARY_REPO_BRANCH  = ${XCS_PRIMARY_REPO_BRANCH}"   # Only used when checking out a branch.
echo "XCS_PRIMARY_REPO_TAG     = ${XCS_PRIMARY_REPO_TAG}"      # Only used when checking out a tag.
echo "XCS_OUTPUT_DIR           = ${XCS_OUTPUT_DIR}"
echo "XCS_BOT_ID               = ${XCS_BOT_ID}"
echo "XCS_BOT_TINY_ID          = ${XCS_BOT_TINY_ID}"
echo "http://Bots JSON         = https://$(hostname):20343/api/bots"
echo "http://bots/latest       = https://$(hostname)/xcode/bots/latest"
echo "http://latest this bot   = https://$(hostname)/xcode/bots/latest/${XCS_BOT_TINY_ID}"
echo "http://Integration JSON  = https://$(hostname)/xcode/internal/api/integrations/${XCS_INTEGRATION_ID}"
echo "http://Download          = https://$(hostname)/xcode/internal/api/integrations/${XCS_INTEGRATION_ID}/assets"
echo "xcbot://See Bot in Xcode = xcbot://$(hostname)/botID/${XCS_BOT_ID}/integrationID/${XCS_INTEGRATION_ID}"

# Siku specific, if you need to open the Workspace from CLI
echo xed ${XCS_PRIMARY_REPO_DIR}/Siku/Siku.xcworkspace

# set verbose
set -v

echo "changing directory"
cd ${XCS_PRIMARY_REPO_DIR}
pwd

git submodule sync
wait
git submodule update --init --recursive
wait
git submodule update --remote
wait

# MARK: - verify `siku-map-assets`
echo "verify siku-map-assets"
ls -l Siku/Siku/Resources/siku-map-assets
cat Siku/Siku/Resources/siku-map-assets/styles/siku-offline-asset.json | grep name

set +v

# MARK: - Git metadata
git remote --verbose
git branch
gitBranch=$(/usr/bin/git -C ${XCS_PRIMARY_REPO_DIR} rev-parse --abbrev-ref HEAD)
echo branch = $gitBranch
gitSHA=$(/usr/bin/git -C ${XCS_PRIMARY_REPO_DIR} rev-parse HEAD)
echo SHA = $gitSHA

# MARK: - Show Xcode Build Settings
cd ${XCS_PRIMARY_REPO_DIR}/Siku

xcodebuild -showBuildSettings | grep PRODUCT_BUNDLE_IDENTIFIER
xcodebuild -showBuildSettings | grep CURRENT_PROJECT_VERSION
xcodebuild -showBuildSettings | grep MARKETING_VERSION

xcodebuild -showBuildSettings
