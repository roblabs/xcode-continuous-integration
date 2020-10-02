#!/bin/sh
# Pre-Integration Script
#   environment

echo XCS=${XCS}
echo XCS_INTEGRATION_NUMBER=${XCS_INTEGRATION_NUMBER}

echo CURRENT_PROJECT_VERSION=${CURRENT_PROJECT_VERSION}
echo MARKETING_VERSION=${MARKETING_VERSION}

echo XCS_PRIMARY_REPO_BRANCH=${XCS_PRIMARY_REPO_BRANCH}
echo XCS_PRIMARY_REPO_TAG=${XCS_PRIMARY_REPO_TAG}
echo XCS_SOURCE_DIR=${XCS_SOURCE_DIR}
echo XCS_PRIMARY_REPO_DIR=${XCS_PRIMARY_REPO_DIR}
echo XCS_BOT_NAME=${XCS_BOT_NAME}
echo XCS_OUTPUT_DIR=${XCS_OUTPUT_DIR}

# set verbose
set -v

# MARK: - build environment
hostname

sw_vers

# Xcode version & path
/usr/bin/xcodebuild -version
/usr/bin/xcode-select -print-path

# installed SDKs
/usr/bin/xcodebuild -showsdks -json
system_profiler -json SPDeveloperToolsDataType

set +v
