## Xcode Server Bots 🤖 and Continuous Integration Guide

Goal — ***one button Xcode builds*** with Xcode Server or `XCS`

Do you have CI or *Continuous Integration* for your applications built with Xcode?  There are plenty to choose from and they have their advantages.  But consider Xcode Server *Bots* built directly into Xcode:  there is nothing to install and your project can be up and running in a matter of minutes.

We all want simple builds.  If you are able to check your code into a `git` repo, then it should be able to `git pull` and build in small number of steps.  If you can minimize the number of dependencies to be installed or to be `fetch`ed, then your builds will be more repeatable.  More repeatable; possibly better quality.  More repeatable; prime for automation with Xcode Server *Bots*.

Many Open Source Xcode projects already have a CI architecture.  But if you want to learn the code or achieve ***one button Xcode builds***, then you would have to install or learn a new dependency.  Xcode Server Bots can still be used in this case.

The Xcode Server Bots documentation makes the compelling case to use Bots.  The documentation on [Continuous integration using Xcode Server](https://help.apple.com/xcode/mac/11.4/index.html?localePath=en.lproj#/dev466720061) from Apple is the best resource for setting up your Xcode Server Bots.

> In Xcode, continuous integration is the process of automating and streamlining the building, analyzing, testing, and archiving of your Mac and iOS apps, in order to ensure that they are always in a releasable state. [1]
> The goal of continuous integration is to improve software quality, and there are a number of ways this is achieved:
> * Catching problems quickly, easily, and early.
> * Enhancing collaboration.
> * Broadening test coverage.
> * Generating build and test statistics over time.

* [1] : https://developer.apple.com/library/archive/documentation/IDEs/Conceptual/xcode_guide-continuous_integration/index.html
* [2] : https://developer.apple.com/search/?q=xcode%20server&type=Videos
* [Xcode Server Environment Variable Reference](https://developer.apple.com/library/archive/documentation/IDEs/Conceptual/xcode_guide-continuous_integration/EnvironmentVariableReference.html)
* [Xcode Server API Reference](https://developer.apple.com/library/archive/documentation/Xcode/Conceptual/XcodeServerAPIReference/Bots.html)

This repo includes CI scripts for use in Xcode Continuous Integration *Bots*.  Also useful for manual builds.  Support for `carthage` for fetching binaries.  If you CocoaPods, you can still use this repo.  It's likely you can still use this as you will likely be using the CocoaPods `.xcworkspace`, which this can still be integrated into.

### How to Use Scripts in `XCS`

Choose one of these options that fits your needs.
The Xcode Server Bots documentation makes the compelling case to use Bots.  The documentation on [Continuous integration using Xcode Server](https://help.apple.com/xcode/mac/11.4/index.html?localePath=en.lproj#/dev466720061) from Apple is the best resource for setting up your Xcode Server Bots.

> In Xcode, continuous integration is the process of automating and streamlining the building, analyzing, testing, and archiving of your Mac and iOS apps, in order to ensure that they are always in a releasable state. [1]
> The goal of continuous integration is to improve software quality, and there are a number of ways this is achieved:
> * Catching problems quickly, easily, and early.
> * Enhancing collaboration.
> * Broadening test coverage.
> * Generating build and test statistics over time.

[1] : https://developer.apple.com/library/archive/documentation/IDEs/Conceptual/xcode_guide-continuous_integration/index.html

This repo includes CI scripts for use in Xcode Continuous Integration *Bots*.  Also useful for manual builds.  Support for `carthage` for fetching binaries.  If you CocoaPods, you can still use this repo.  It's likely you can still use this as you will likely be using the CocoaPods `.xcworkspace`, which this can still be integrated into.

#### Add as a `git submodule`

Add this repo as a `git submodule`.  The directory name it creates will be `xcode-continuous-integration` and the shell scripts will be in that directory.

```
# Add repo to the current directory
git submodule add https://github.com/roblabs/xcode-continuous-integration.git
```

#### In Xcode Schemes

`Edit Scheme` > `Build` > `Pre-Actions` > `Run Script` > Add the following (assuming the proper path relative to your `${PROJECT_DIR}`)

```
cd ${PROJECT_DIR}
git submodule update --init --recursive
wait
sh ${PROJECT_DIR}/xcode-continuous-integration/ci.sh
```

---

<img width="600" alt="xcode-continuous-integration" src="https://user-images.githubusercontent.com/118112/93690228-f4571500-fa8a-11ea-923f-bccb58ef8c50.png">

---

#### In Xcode Server Bots

Let's take the special case of building Mapbox GL Native for iOS.  See the `examples` folder for scripts for setting up `XCS` with

* `mapbox-gl-native-ios`, versions <= v5.9
* `mapbox-gl-native-ios`, versions > 6.0

1.  The Git branch and Xcode scheme you want to test is very important, so check out a local copy to your development folder.  For example, set the branch you want and perform the initial step to make the Xcode Project.

`mapbox-gl-native-ios`, versions <= v5.9

```
git clone --branch ios-v5.9.0 \
  https://github.com/mapbox/mapbox-gl-native-ios.git \
  tmp/mapbox-gl-native-ios

cd tmp/mapbox-gl-native-ios
make iproj
```

`mapbox-gl-native-ios`, versions > 6.0, or master

```
git clone \
  https://github.com/mapbox/mapbox-gl-native-ios.git \
  tmp/mapbox-gl-native-ios

cd tmp/mapbox-gl-native-ios
make iproj
```

2. The call to `make iproj` will automatically open the Xcode Project on your development Mac.

<img width="238" alt="xcs-ci" src="https://user-images.githubusercontent.com/118112/94976840-13ae6300-04cb-11eb-8f5b-49c8fb5dce0d.png">

3. Change the Scheme to `CI`, which is already configured in the source for CI.  On your development Mac, choose `Product` > `Create Bot`.
4. Add Pre-Integration Triggers
  1. `environment` - Git repo metadata & Build versions
  1. project specific build commands - for your version of `mapbox-gl-native-ios`

---

### Example Data

* Example Data is generated from a project that makes use of these scripts on GitHub, [roblabs / openmaptiles-ios-demo](https://github.com/roblabs/openmaptiles-ios-demo)

<details open><summary> Project & Development Environment `metadata` 👉 </summary>

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
</details>

---

#### `XCS` Environment Variables

If built using Xcode Server *Bots*, then log several key `XCS_` environment variables.  See Apple's [Xcode Server Environment Variable Reference](https://developer.apple.com/library/archive/documentation/IDEs/Conceptual/xcode_guide-continuous_integration/EnvironmentVariableReference.html).

If built using Xcode Server *Bots*, then log several key `XCS_` environment variables

<details><summary> Example Xcode Server Environment Variables 👉 </summary>

```
XCS = 1
XCS_BOT_NAME = OSM2VectorTiles Bot
XCS_BOT_ID = drb3o4b067dec6e781b4976604a291
XCS_BOT_TINY_ID = CB1D194
XCS_INTEGRATION_ID = drb3o4b067dec6e781b4976604a291
XCS_INTEGRATION_TINY_ID = R698E33
XCS_INTEGRATION_NUMBER = 4
XCS_INTEGRATION_RESULT = unknown
XCS_SOURCE_DIR = /Users/roblabs/Library/Caches/XCSBuilder/Bots/drb3o4b067dec6e781b4976604a291/Source
XCS_OUTPUT_DIR = /Users/roblabs/Library/Caches/XCSBuilder/Integration-drb3o4b067dec6e781b4976604a291
XCS_DERIVED_DATA_DIR = /Users/roblabs/Library/Caches/XCSBuilder/Bots/drb3o4b067dec6e781b4976604a291/DerivedData
XCS_XCODEBUILD_LOG = /Users/roblabs/Library/Caches/XCSBuilder/Integration-drb3o4b067dec6e781b4976604a291/xcodebuild.log
INTEGRATION_URL = https://roblabs.local/xcode/bots/CB1D194/integrations/R698E33

# Log data generated from this script:  ci.sh
PREBUILD_LOG = /Users/roblabs/Library/Caches/XCSBuilder/Bots/drb3o4b067dec146e781b4976604a291/Source/openmaptiles-ios-demo/prebuild.RB1A194.4.log
```
</details>

---

#### Xcode Server URLs

You can also log some interesting URL's from the [Xcode Server API Reference](https://developer.apple.com/library/archive/documentation/Xcode/Conceptual/XcodeServerAPIReference/Bots.html)

<details><summary> Example Xcode Server URLs 👉 </summary>

```
http://Bots JSON         = https://oldSanJuan.local:20343/api/bots
http://bots/latest       = https://oldSanJuan.local/xcode/bots/latest
http://latest this bot   = https://oldSanJuan.local/xcode/bots/latest/EC6DB3B
http://Integration JSON  = https://oldSanJuan.local/xcode/internal/api/integrations/771613596b2cdb2a24eaa2108be1b1
http://Download          = https://oldSanJuan.local/xcode/internal/api/integrations/771613596b2cdb2a24eaa2108be1b1/assets
xcbot://See Bot in Xcode = xcbot://oldSanJuan.local/botID/dcb3a48067dec1e781b49766016a8f/integrationID/771613596b2cdb2a24eaa2108be1b1

```

</details>

---

### `XCS` and the Build Number

How to add the `XCS` *integration* or build number into your Xcode project.

  * XCS builds will automatically update the build number
  * Example, If you are doing a non `XCS` build with the following values for current & marketing version then,
      * The variable `${XCS_INTEGRATION_NUMBER}` will be `""` or null.
      * Local builds version will be `1.278.314` with a build number of `314`
      * An example `XCS` build version for the **101** *st* build will be 1.278.314**101** with a build number of 314**101**.
  * To acheive this, hand edit all instances in file `<project>.xcodeproj/project.pbxproj`.  It is not possible to do this in Xcode directly.

```
CURRENT_PROJECT_VERSION = "314${XCS_INTEGRATION_NUMBER}";
MARKETING_VERSION = "1.278.314${XCS_INTEGRATION_NUMBER}";
```


<img width="400" alt="xcs-integration-number" src="https://user-images.githubusercontent.com/118112/94976977-a51dd500-04cb-11eb-8bc4-34c7ca1df863.png">


---

### `ExportOptions.plist`

You can use `XCS` with open source projects and apply your own signing credentials for deploying to devices in your local lab.  See the file `ExportOptions.plist`.

* `Configuration` > `Archive` > `Use Custom Export Options Plist`

<img width="709" alt="use-custom-export-options-Plist" src="https://user-images.githubusercontent.com/118112/94869729-c8c51a80-03fa-11eb-9f22-680f69c5d45b.png">

---

*When you apply a proper `ExportOptions.plist`, then you can*
* `Install on device...`
* `Show in Organizer...`

![product-archive](https://user-images.githubusercontent.com/118112/94870250-f6f72a00-03fb-11eb-8aa0-ad638d35e0cd.gif)

---

*Viewing `ExportOptions.plist` in Xcode*

<img width="422" alt="export-options plist-in-xcode" src="https://user-images.githubusercontent.com/118112/94869758-d4184600-03fa-11eb-9537-334723ca3955.png">

#### Documentation

Documentation for the Export Options can be found by typing:

`xcodebuild -h`

Here are some of those settings after running the online documentation for these settings.  You can review Apple [Technical Note TN2339](https://developer.apple.com/library/archive/technotes/tn2339/_index.html#//apple_ref/doc/uid/DTS40014588-CH1-WHAT_KEYS_CAN_I_PASS_TO_THE_EXPORTOPTIONSPLIST_FLAG_) for more information.

`destination` : String
>	Determines whether the app is exported locally or uploaded to Apple. Options are `export` or `upload`. The available options vary based on the selected distribution method. Defaults to `export`.

`method` : String
>	Describes how Xcode should export the archive. Available options: `app-store`, `validation`, `ad-hoc`, `package`, `enterprise`, `development`, `developer-id`, and `mac-application`. The list of options varies based on the type of archive. Defaults to `development`.

`signingStyle` : String
>	The signing style to use when re-signing the app for distribution. Options are `manual` or `automatic`. Apps that were automatically signed when archived can be signed manually or automatically during distribution, and default to automatic. Apps that were manually signed when archived must be manually signed during distribution, so the value of signingStyle is ignored.

`stripSwiftSymbols` : Bool
>	Should symbols be stripped from Swift libraries in your IPA? Defaults to YES.

`teamID` : String
>	The Developer Portal team to use for this export. Defaults to the team used to build the archive.

`uploadBitcode` : Bool
>	For App Store exports, should the package include bitcode? Defaults to YES.

`uploadSymbols` : Bool
>	For App Store exports, should the package include symbols? Defaults to YES.


<!--

# script to add integration number into build
    # https://stackoverflow.com/a/25958498
    # Simply set the Build number to ${XCS_INTEGRATION_NUMBER} in your project settings.

    # https://stackoverflow.com/a/51957227/388210
    # In Xcode 9 server, submodules are not initialized
    # if none of the files of the submodules is referenced by one of the Xcode projects in the workspace.
    # A possible workaround is to add at least one file from the submodule to the Xcode project.
    #It can even be a Readme.md file.

-->

<!--

``` bash
system_profiler -json SPDeveloperToolsDataType


system_profiler -listDataTypes
system_profiler SPPrintersDataType
system_profiler SPApplicationsDataType | grep Info
system_profiler SPNetworkDataType
#system_profiler SPEthernetDataType
#system_profiler SPFrameworksDataType
#system_profiler SPPrintersSoftwareDataType
#system_profiler SPAirPortDataType
```

---

* https://developer.apple.com/library/archive/documentation/Xcode/Conceptual/XcodeServerAPIReference/Schema.html
```bash
wget --no-check-certificate https://oldsanjuan.local:20343/api/bots -O tmp/bots.json
cat tmp/bots.json | json > tmp/bots.pretty.json

# Get the first result
cat tmp/bots.json | json results.0

# Scheme name
#             The name of the scheme used to integrate.
cat tmp/bots.json | json results.0.configuration.schemeName

# Built from clean
#             0: Never
#             1: Always
#             2: Once a day
#             3: Once a week
cat tmp/bots.json | json results.0.configuration.builtFromClean

# Configuration
#             Value: "Debug" | "Release" | "XXX" <- we need to set the value because if exists already,
#             devs cannot remove it (there is no support for it)
cat tmp/bots.json | json results.0.configuration.buildConfiguration

cat tmp/bots.json | json results.0.configuration.buildEnvironmentVariables
cat tmp/bots.json | json results.0.configuration.additionalBuildArguments

# Performs analyze action
#             Value: true | false
cat tmp/bots.json | json results.0.configuration.performsAnalyzeAction

# Performs test action
#             Value: true | false
cat tmp/bots.json | json results.0.configuration.performsTestAction
cat tmp/bots.json | json results.0.configuration.useParallelDeviceTesting
cat tmp/bots.json | json results.0.configuration.exportsProductFromArchive
cat tmp/bots.json | json results.0.configuration.codeCoveragePreference

# Schedule type:
#             1: Periodically
#             2: On commit
#             3: Manual
cat tmp/bots.json | json results.0.configuration.scheduleType
# Periodic schedule
#             1: Hourly
#             2: Daily
#             3: Weekly
#        Dependencies:
#              - 'scheduleType' set to 1 (Periodically)
cat tmp/bots.json | json results.0.configuration.periodicScheduleInterval

# Blueprint
cat tmp/bots.json | json results.0.configuration.sourceControlBlueprint

# Git Remote Repository URL
cat tmp/bots.json | json results.0.configuration.sourceControlBlueprint.DVTSourceControlWorkspaceBlueprintRemoteRepositoriesKey.0.DVTSourceContro
lWorkspaceBlueprintRemoteRepositoryURLKey

# The name for the blueprint, typically the name of the Xcode project or workspace
#           Value: string
cat tmp/bots.json | json results.0.configuration.sourceControlBlueprint.DVTSourceControlWorkspaceBlueprintRemoteRepositoriesKey.0.DVTSourceControlWorkspaceBlueprintNameKey

# Name
#  Integration number - This number dictates the number that the next integration will be set to.
cat tmp/bots.json | json results.0.name
cat tmp/bots.json | json results.0.integration_counter
cat tmp/bots.json | json results.0.tinyID
cat tmp/bots.json | json results.0.type
cat tmp/bots.json | json results.0._id  # 5aad0a28b449aa1209c98dac7a16f26c
cat tmp/bots.json | json results.0.doc_type

# triggers name: string (title of the script)
cat tmp/bots.json | json results.0.configuration.triggers.0
cat tmp/bots.json | json results.0.configuration.triggers.0.name

# phase: 1 (Before) | 2 (After)
cat tmp/bots.json | json results.0.configuration.triggers.0.phase

# scriptBody: string (script)
cat tmp/bots.json | json results.0.configuration.triggers.0.scriptBody
```

data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4NCjwhLS0gR2VuZXJhdG9yOiBBZG9iZSBJbGx1c3RyYXRvciAxNy4xLjAsIFNWRyBFeHBvcnQgUGx1Zy1JbiAuIFNWRyBWZXJzaW9uOiA2LjAwIEJ1aWxkIDApICAtLT4NCjwhRE9DVFlQRSBzdmcgUFVCTElDICItLy9XM0MvL0RURCBTVkcgMS4xLy9FTiIgImh0dHA6Ly93d3cudzMub3JnL0dyYXBoaWNzL1NWRy8xLjEvRFREL3N2ZzExLmR0ZCI%2BDQo8c3ZnIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayIgeD0iMHB4IiB5PSIwcHgiDQoJIHZpZXdCb3g9IjAgMCA3MCA3MCIgZW5hYmxlLWJhY2tncm91bmQ9Im5ldyAwIDAgNzAgNzAiIHhtbDpzcGFjZT0icHJlc2VydmUiPg0KPGcgaWQ9ImJnIj4NCjwvZz4NCjxnIGlkPSJMYXllcl8yIj4NCgk8cGF0aCBmaWxsPSIjQzNDM0MzIiBkPSJNMzUsNy4wNzFMNjIuOTI5LDM1TDM1LDYyLjkyOUw3LjA3MSwzNUwzNSw3LjA3MSBNMzUsMEwwLDM1bDM1LDM1bDM1LTM1TDM1LDBMMzUsMHoiLz4NCgk8bGluZSBmaWxsPSJub25lIiBzdHJva2U9IiNDM0MzQzMiIHN0cm9rZS13aWR0aD0iNSIgc3Ryb2tlLW1pdGVybGltaXQ9IjEwIiB4MT0iMjIuNDk5IiB5MT0iMzUiIHgyPSI0Ny40OTkiIHkyPSIzNSIvPg0KPC9nPg0KPC9zdmc%2BDQo%3D

---

## integrations

* https://oldSanJuan.local:20343/api/integrations/
* https://oldSanJuan.local:20343/api/integrations/<<<id>>>/assets
* https://oldSanJuan.local:20343/api/integrations/<<<id>>>/assets/74e3b5355373cf034a1e4eeaa700a886-MapKit-starter Bot/12/sourceControl.log

```bash
wget --no-check-certificate https://oldSanJuan.local:20343/api/integrations -O tmp/integrations.json
```
-->
