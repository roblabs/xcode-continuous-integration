#!/bin/sh

# MARK: - carthage update
echo "---"
echo "* `carthage update`"

/usr/local/bin/brew list --versions carthage

/usr/local/bin/carthage version
/usr/local/bin/carthage update
wait
