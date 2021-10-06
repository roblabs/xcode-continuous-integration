#!/bin/sh
# Copyright © 2020-2021 ePi Rational, Inc.. All rights reserved.
# SPDX-License-Identifier: MIT
# XCS Pre-Integration Script Trigger name:   git_patch
echo This log was generated at $(date) from: git_patch.sh

# set verbose
set -v

# MARK: - project specific build commands
cd ${XCS_PRIMARY_REPO_DIR}
pwd

/usr/bin/git apply \
  ~/Downloads/patch-teamID.diff

set +v

echo XCS_PRIMARY_REPO_DIR = $XCS_PRIMARY_REPO_DIR

# MARK: - Git metadata
git remote --verbose
git branch
gitBranch=$(/usr/bin/git -C ${XCS_PRIMARY_REPO_DIR} rev-parse --abbrev-ref HEAD)
echo branch = $gitBranch
gitSHA=$(/usr/bin/git -C ${XCS_PRIMARY_REPO_DIR} rev-parse HEAD)
echo SHA = $gitSHA

# MARK: - Verify what is changed
/usr/bin/git status
/usr/bin/git diff
