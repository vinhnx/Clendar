[![SwiftLint](https://github.com/vinhnx/Clendar/actions/workflows/swiftlint.yml/badge.svg)](https://github.com/vinhnx/Clendar/actions/workflows/swiftlint.yml)

<h1 align="center">
Clendar - Minimal Calendar
</h1>
<p align="center">Minimal Calendar & Widget</p>

<p align="center"><img src="https://is3-ssl.mzstatic.com/image/thumb/Purple124/v4/0f/4d/31/0f4d3185-cf37-c985-4631-a5b14b72dba0/AppIcon-0-1x_U007emarketing-0-10-0-85-220.png/230x0w.webp"></p>

<p align="center"><a href="https://apps.apple.com/us/app/clendar-a-calendar-app/id1548102041?itsct=apps_box&amp;itscg=30200" style="display: inline-block; overflow: hidden; border-top-left-radius: 13px; border-top-right-radius: 13px; border-bottom-right-radius: 13px; border-bottom-left-radius: 13px; width: 250px; height: 83px;"><img src="https://tools.applemediaservices.com/api/badges/download-on-the-app-store/white/en-US?size=250x83&amp;releaseDate=1600214400&h=b81fd00fac3280be6ec30d3d3a1461f0" alt="Download on the App Store" style="border-top-left-radius: 13px; border-top-right-radius: 13px; border-bottom-right-radius: 13px; border-bottom-left-radius: 13px; width: 250px; height: 83px;"></a></p>

> [Landing Page](https://clendar.info)

### About

This project is started out as an UIKit base app for me to learn new WWDC features over the years. But one day, I decided to convert the whole app from UIKit -> SwiftUI and boom, here we are.

This is the PR => https://github.com/vinhnx/Clendar/pull/35

### SwiftUI

📖 I believe the best way to Learn is by doing. [SwiftUI](https://developer.apple.com/xcode/swiftui/) is evolving and I think it's the future of writing apps.

> SwiftUI is an innovative, exceptionally simple way to build user interfaces across all Apple platforms with the power of Swift. Build user interfaces for any Apple device using just one set of tools and APIs.
>
> -- Apple

The true power of SwiftUI, to me, is it's flexibility, thanks to it's vast realm of view modifiers and expressiveness with property wrappers.

You can create an "Hello, World!" app with just a few lines of code (check out the new [@main](<https://developer.apple.com/documentation/swiftui/app/main()>) attribute!) or even, [a calendar view](https://gist.github.com/mecid/f8859ea4bdbd02cf5d440d58e936faec).

SwiftUI give you the most flexible tool an Apple developer could ever ask for, all you need is a bit of creativity, and the [possibilities](https://github.com/Juanpe/About-SwiftUI), [are](https://github.com/chinsyo/awesome-swiftui), [limitless](https://github.com/onmyway133/awesome-swiftui).

Clendar would not be possible without the public knowledge of the community. To name a few, in no particular order:

-   https://swiftwithmajid.com
-   https://raywenderlich.com
-   https://www.swiftbysundell.com
-   https://www.hackingwithswift.com
-   https://sarunw.com
-   https://github.com/onmyway133/blog/issues
-   https://github.com/topics/swiftui

my notes about SwiftUI:

-   https://github.com/vinhnx/notes/issues?q=is%3Aissue+is%3Aopen+swiftui+label%3ASwiftUI
-   https://github.com/vinhnx/notes/issues/342

By publishing Clendar, I would like to give back to the community. 😊

### Tech stacks

Core:

-   SwiftUI (and UIKit interoperability)
-   iPadOS
-   WidgetKit
-   SiriKit
-   EventKit/EvenKit UI - wrapper with my own [Shift package](https://github.com/vinhnx/Shift) 📆
-   WatchKit
-   Combine
-   Catalyst
-   StoreKit

Build delivery tool

-   Fastlane

Package Managers

-   Swift Package Manager
-   CocoaPods

Linter

-   SwiftLint

Formatter

-   SwiftFormat

Action

-   [SwiftLint is integrated on GitHub Action workflow](https://github.com/vinhnx/Clendar/actions?query=workflow%3ASwiftLint) 🚀

### Requirements

 (for async/await):
-   Xcode 13.1
-   iOS 15.0
-   watchOS 8.0
-   Ruby (for Fastlane build automation)

### My own Swift Packages currently used in Clendar

+ [Shift](https://github.com/vinhnx/Shift) - Result-based wrapper for EventKit. SwiftUI supported!
+ [Laden](https://github.com/vinhnx/Laden) - SwiftUI loading indicator view

### Contributing

Contributing is more than welcome, if you feel like helping the app, or want to add new feature, feel free to take a look at my [issues page](https://github.com/vinhnx/Clendar/issues). Thanks!

### Contributors

🙏🏻🤯🎉
Huge thanks everyone who took their precious time and effort to contribute to the project:
+ [Aleksandr Sutulov](https://github.com/AlexanderSutul)
+ [Jan Matoniak](https://github.com/kapucnov2321)
+ [your name here?...](https://github.com/vinhnx/Clendar/issues)

💡🧡

### License

[MIT License](https://github.com/vinhnx/Clendar/blob/main/LICENSE)

You can do whatever you want with this source code: modify, tweak or use as learning resources, for example... 🛠👨🏻‍💻

But, please don't re-distribute the app on App Store with different name. 🥺

And, if you like, you can Purchase the app on the [App Store](https://apps.apple.com/us/app/clendar-a-calendar-app/id1548102041?itsct=apps_box&itscg=30200) and leave me a tip via In-App Purchase options if you feel like. Thank you in advance! 📲

### Open-source inspiration
+ https://github.com/jeffreybergier/WaterMe

### What's 'Clendar'?

It's just Calendar, without an 'a'. I thought it's unique, but turns out it's not going well with ASO (App Store Optimization) and SEO (Search Engine Optimization). 

But, whatever!

---

Thanks and take care! 🍀

I'm on `@vinhnx` on almost everywhere.
