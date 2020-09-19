# `xcode-continuous-integration`

Goal — *one button Xcode builds*.

We all want simple builds.  If you are able to check your code into a `git` repo, then it should be able to `git pull` and build in small number of steps.  If you can minimize the number of dependencies to be installed or to be `fetch`ed, then your builds will be more repeatable.  More repeatable; possibly better quality.  More repeatable; prime for automation with Xcode Server *Bots*.

This repo includes CI scripts for use in Xcode Continuous Integration *Bots*.  Also useful for manual builds.  Support for `carthage` for fetching binaries.  If you CocoaPods, you can still use this repo.  It's likely you can still use this as you will likely be using the CocoaPods `.xcworkspace`, which this can still be integrated into.

### Xcode Server and Continuous Integration Guide

* [https://developer.apple.com/library/archive/documentation/IDEs/Conceptual/xcode_guide-continuous_integration/](https://developer.apple.com/library/archive/documentation/IDEs/Conceptual/xcode_guide-continuous_integration/)

### How to Use the Repo

1.  Add this repo as a `git submodule`.  The directory name it creates will be `xcode-continuous-integration` and the shell scripts will be in that directory.

```
# Add repo to the current directory
git submodule add https://github.com/roblabs/xcode-continuous-integration.git
```

2. In Xcode

  2.1 `Edit Scheme` > `Build` > `Pre-Actions` > `Run Script` > Add the following (assuming the proper path relative to your `${PROJECT_DIR}`)

```
cd ${PROJECT_DIR}
git submodule update --init --recursive
wait
sh ${PROJECT_DIR}/xcode-continuous-integration/ci.sh
```

---

<img width="600" alt="xcode-continuous-integration" src="https://user-images.githubusercontent.com/118112/93689119-5d855b00-fa80-11ea-9738-c3996dc5a7d7.png">

---

### Example Data

* Example Data is generated from a project that makes use of these scripts on GitHub, [roblabs / openmaptiles-ios-demo](https://github.com/roblabs/openmaptiles-ios-demo)

* `metadata` for your Project & Development Environment

```
Sat Sep 19 13:35:34 PDT 2020
PROJECT_DIR = /Users/roblabs/Documents/github/roblabs/openmaptiles-ios-demo/tmp/openmaptiles-ios-demo
gitBranch = master
gitSHA = aaa53c24cce044e2e2fbfc49b56bd83d825b969d
CURRENT_PROJECT_VERSION = 0
MARKETING_VERSION = 1.341.0
DEVELOPMENT_TEAM = R7O3BWLEA8BS
PREBUILD_LOG = /Users/roblabs/Documents/github/roblabs/openmaptiles-ios-demo/tmp/openmaptiles-ios-demo/prebuild.log
ProductName:	Mac OS X
ProductVersion:	10.15.6
BuildVersion:	19G2021
Xcode 11.7
Build version 11E801a
```

---

* If built using Xcode Server *Bots*, then log several key `XCS_` environment variables

```
XCS = 1
XCS_BOT_NAME = OSM2VectorTiles Bot
XCS_BOT_ID = drb3o4b067dec146e781b4976604a291
XCS_BOT_TINY_ID = CB1D194
XCS_INTEGRATION_ID = drb3o4b067dec146e781b49766059a41
XCS_INTEGRATION_TINY_ID = R698E33
XCS_INTEGRATION_NUMBER = 4
XCS_INTEGRATION_RESULT = unknown
XCS_SOURCE_DIR = /Users/roblabs/Library/Caches/XCSBuilder/Bots/drb3o4b067dec146e781b4976604a291/Source
XCS_OUTPUT_DIR = /Users/roblabs/Library/Caches/XCSBuilder/Integration-drb3o4b067dec146e781b49766059a41
XCS_DERIVED_DATA_DIR = /Users/roblabs/Library/Caches/XCSBuilder/Bots/drb3o4b067dec146e781b4976604a291/DerivedData
XCS_XCODEBUILD_LOG = /Users/roblabs/Library/Caches/XCSBuilder/Integration-drb3o4b067dec146e781b49766059a41/xcodebuild.log
INTEGRATION_URL = https://roblabs.local/xcode/bots/CB1D194/integrations/R698E33

# Log data generated from this script:  ci.sh
PREBUILD_LOG = /Users/roblabs/Library/Caches/XCSBuilder/Bots/drb3o4b067dec146e781b4976604a291/Source/openmaptiles-ios-demo/prebuild.RB1A194.4.log
```

---

* `carthage` metadata

```
carthage version
0.36.0
carthage update
*** Fetching mapbox-events-ios
*** Downloading binary-only framework Mapbox-iOS-SDK at "https://www.mapbox.com/ios-sdk/Mapbox-iOS-SDK.json"
*** Checking out mapbox-events-ios at "v0.10.4"
*** Downloading binary-only framework Mapbox-iOS-SDK at "https://www.mapbox.com/ios-sdk/Mapbox-iOS-SDK.json"
*** xcodebuild output can be found in /var/folders/1h/4r1gtygs5x76pn_n6ts5v24w0000gn/T/carthage-xcodebuild.TEen4A.log
*** Building scheme "MapboxMobileEvents" in MapboxMobileEvents.xcodeproj
```
