#!/bin/sh

# MARK: - Update PATH
set -v
echo $PATH
export PATH=/usr/local/bin:.:$PATH
# `brew` location on macOS for Mac Silicon
export PATH=/opt/homebrew/bin:.:$PATH
echo $PATH

# MARK: - carthage update
echo "---"
echo "* `carthage update`"

brew list --versions carthage

carthage update
wait
