fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew install fastlane`

# Available Actions
## iOS
### ios bumpPatch
```
fastlane ios bumpPatch
```
Increment the app version patch (0.0.X)
### ios bumpMinor
```
fastlane ios bumpMinor
```
Increment the app version minor (0.X.0)
### ios bumpMajor
```
fastlane ios bumpMajor
```
Increment the app version major (X.0.0)
### ios bumpVersion
```
fastlane ios bumpVersion
```
Increment the app's version number (required for app store build)
### ios bumpBuild
```
fastlane ios bumpBuild
```
Increment the app's build number
### ios bumpBuildCustom
```
fastlane ios bumpBuildCustom
```

### ios test
```
fastlane ios test
```
Runs all the tests
### ios ensure_lane
```
fastlane ios ensure_lane
```

### ios ensureMain
```
fastlane ios ensureMain
```
Make sure current branch is `main`
### ios makeAppStoreGitTag
```
fastlane ios makeAppStoreGitTag
```
Create/make app store git tag for release
### ios pushGitTag
```
fastlane ios pushGitTag
```
Push git tag to git `upstream`
### ios makeAndPushReleaseTag
```
fastlane ios makeAndPushReleaseTag
```
Create release git tag and push to upstream
### ios buildAppStore
```
fastlane ios buildAppStore
```
Build App Store
### ios testtime
```
fastlane ios testtime
```

### ios makeAppStoreBuild
```
fastlane ios makeAppStoreBuild
```
Build app store
### ios commitVersionBumpWrapper
```
fastlane ios commitVersionBumpWrapper
```
Commit version bump wrapper
### ios run_swiftlint
```
fastlane ios run_swiftlint
```
run SwiftLint linter

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
