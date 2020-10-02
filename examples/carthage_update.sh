#!/bin/sh

# MARK: - Update PATH
set -v
echo $PATH
export PATH=/usr/local/bin:.:$PATH
echo $PATH

# MARK: - carthage update
echo "---"
echo "* `carthage update`"

brew list --versions carthage

carthage update
wait
