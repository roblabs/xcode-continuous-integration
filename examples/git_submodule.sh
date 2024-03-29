#!/bin/sh
# Copyright © 2020-2021 ePi Rational, Inc.. All rights reserved.
# SPDX-License-Identifier: MIT
# XCS Pre-Integration Script Trigger name:   git_submodule
echo This log was generated at $(date) from: git_submodule.sh

# Update submodules in the Main project directory
cd ${XCS_PRIMARY_REPO_DIR}
git submodule sync && git submodule update --init --recursive
wait
