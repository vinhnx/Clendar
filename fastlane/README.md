fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## iOS

### ios bumpPatch

```sh
[bundle exec] fastlane ios bumpPatch
```

Increment the app version patch (0.0.X)

### ios bumpMinor

```sh
[bundle exec] fastlane ios bumpMinor
```

Increment the app version minor (0.X.0)

### ios bumpMajor

```sh
[bundle exec] fastlane ios bumpMajor
```

Increment the app version major (X.0.0)

### ios bumpVersion

```sh
[bundle exec] fastlane ios bumpVersion
```

Increment the app's version number (required for app store build)

### ios bumpBuild

```sh
[bundle exec] fastlane ios bumpBuild
```

Increment the app's build number

### ios bumpBuildCustom

```sh
[bundle exec] fastlane ios bumpBuildCustom
```



### ios test

```sh
[bundle exec] fastlane ios test
```

Runs all the tests

### ios ensure_lane

```sh
[bundle exec] fastlane ios ensure_lane
```



### ios ensureMain

```sh
[bundle exec] fastlane ios ensureMain
```

Make sure current branch is `main`

### ios makeAppStoreGitTag

```sh
[bundle exec] fastlane ios makeAppStoreGitTag
```

Create/make app store git tag for release

### ios pushGitTag

```sh
[bundle exec] fastlane ios pushGitTag
```

Push git tag to git `upstream`

### ios makeAndPushReleaseTag

```sh
[bundle exec] fastlane ios makeAndPushReleaseTag
```

Create release git tag and push to upstream

### ios release

```sh
[bundle exec] fastlane ios release
```

Build App Store

### ios _makeAppStoreBuild

```sh
[bundle exec] fastlane ios _makeAppStoreBuild
```

Build app store

### ios _makeMacAppStoreBuild

```sh
[bundle exec] fastlane ios _makeMacAppStoreBuild
```

Build app store

### ios commitVersionBumpWrapper

```sh
[bundle exec] fastlane ios commitVersionBumpWrapper
```

Commit version bump wrapper

### ios run_swiftlint

```sh
[bundle exec] fastlane ios run_swiftlint
```

run SwiftLint linter

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
