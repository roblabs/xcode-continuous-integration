#!/bin/sh

# MARK: - carthage update
echo "---"
echo "* `carthage update`"

export PATH=/opt/homebrew/bin:$PATH
brew list --versions carthage

carthage version
carthage update
wait
