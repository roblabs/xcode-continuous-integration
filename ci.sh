#! /bin/sh
# This file is:  xcode-continuous-integration/ci.sh

# Add to scheme with these commands
  # sh ${PROJECT_DIR}/xcode-continuous-integration/ci.sh

# MARK: - Output log name
# check if we are usings Xcode Server Bots integration
if [ "$XCS" == 1 ]
then
  export PREBUILD_LOG=${PROJECT_DIR}/prebuild.${XCS_BOT_TINY_ID}.${XCS_INTEGRATION_NUMBER}.log
else
  # Local build, so remove previous build
  rm -f $PREBUILD_LOG
  export PREBUILD_LOG=${PROJECT_DIR}/prebuild.log
fi

# Xcode Pre-build scripts goto stdError, so use this to capture
exec > $PREBUILD_LOG 2>&1

export LANG=en_US.UTF-8   # to avoid Pod WARNING: CocoaPods requires your terminal to be using UTF-8 encoding.
date

# MARK: - metadata
echo "---"
echo "* metadata for your Project & Development Environment"
echo PROJECT_DIR = $PROJECT_DIR
gitBranch=$(git -C ${PROJECT_DIR} rev-parse --abbrev-ref HEAD)
echo gitBranch = $gitBranch
gitSHA=$(git -C ${PROJECT_DIR} rev-parse HEAD)
echo gitSHA = $gitSHA

echo CURRENT_PROJECT_VERSION = $CURRENT_PROJECT_VERSION
echo MARKETING_VERSION = $MARKETING_VERSION

echo DEVELOPMENT_TEAM = $DEVELOPMENT_TEAM
echo PREBUILD_LOG = $PREBUILD_LOG

# MARK: - build environment
# set verbose
set -v
hostname

sw_vers

# Xcode version & path
/usr/bin/xcodebuild -version
/usr/bin/xcode-select -print-path

# installed SDKs
/usr/bin/xcodebuild -showsdks -json
system_profiler -json SPDeveloperToolsDataType

set +v

# MARK: - metadata for Xcode Server Bots
# https://developer.apple.com/library/archive/documentation/IDEs/Conceptual/xcode_guide-continuous_integration/EnvironmentVariableReference.html
echo "---"
echo "* If built using Xcode Server *Bots*, then log several key XCS_ environment variables"
if [ "$XCS" == 1 ]
then
  export PREBUILD_LOG=${PROJECT_DIR}/prebuild.${XCS_BOT_TINY_ID}.${XCS_INTEGRATION_NUMBER}.log

  echo XCS = $XCS
  echo XCS_INTEGRATION_NUMBER = $XCS_INTEGRATION_NUMBER
  echo XCS_BOT_NAME = $XCS_BOT_NAME
  echo XCS_BOT_ID = $XCS_BOT_ID
  echo XCS_BOT_TINY_ID = $XCS_BOT_TINY_ID
  echo XCS_INTEGRATION_ID = $XCS_INTEGRATION_ID
  echo XCS_INTEGRATION_TINY_ID = $XCS_INTEGRATION_TINY_ID
  echo XCS_INTEGRATION_RESULT = $XCS_INTEGRATION_RESULT
  echo XCS_SOURCE_DIR = $XCS_SOURCE_DIR
  echo XCS_OUTPUT_DIR = $XCS_OUTPUT_DIR
  echo XCS_PRIMARY_REPO_DIR = $XCS_PRIMARY_REPO_DIR
  echo XCS_DERIVED_DATA_DIR = $XCS_DERIVED_DATA_DIR
  echo XCS_XCODEBUILD_LOG = $XCS_XCODEBUILD_LOG
  echo INTEGRATION_URL = https://$(hostname)/xcode/bots/${XCS_BOT_TINY_ID}/integrations/${XCS_INTEGRATION_TINY_ID}

  # MARK: - updates for git submodules and/or carthage
  # Run every time `XCS` is used to build
  echo PROJECT_DIR = ${PROJECT_DIR}
  cd ${PROJECT_DIR}

  echo "---"
  echo "* Update submodules"
  git submodule update --init --recursive
  wait

  set -v
  echo $PATH
  export PATH=/usr/local/bin:.:$PATH
  echo $PATH

  # MARK: - carthage update
  echo "---"
  echo "* `carthage update`"
  date
  carthage version
  carthage update
  wait
else
  # For local builds assume that submodule, carthage and Pods are updated manually one time.
  echo XCS = $XCS # should be `0`
  open $PREBUILD_LOG
fi

date
