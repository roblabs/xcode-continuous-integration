#!/bin/sh
# Pre-Integration Script
#   git_branch

# set verbose
set -v

# MARK: - project specific build commands
cd ${XCS_PRIMARY_REPO_DIR}
pwd

# MARK: - change branch if XCS does not give you the option
/usr/bin/git checkout origin/roblabs/Map

set +v

echo XCS_PRIMARY_REPO_DIR = $XCS_PRIMARY_REPO_DIR

# Git metadata
git remote --verbose
git branch
gitBranch=$(/usr/bin/git -C ${XCS_PRIMARY_REPO_DIR} rev-parse --abbrev-ref HEAD)
echo branch = $gitBranch
gitSHA=$(/usr/bin/git -C ${XCS_PRIMARY_REPO_DIR} rev-parse HEAD)
echo SHA = $gitSHA
