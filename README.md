[![SwiftLint](https://github.com/vinhnx/Clendar/actions/workflows/swiftlint.yml/badge.svg)](https://github.com/vinhnx/Clendar/actions/workflows/swiftlint.yml)

💙 Clendar is now temporarily removed from sale. I will try to get it back soon, thank you all the for all supporting over the years, it means the world to me!

Hi everyone,

I wanted to provide an update regarding the Clendar app. Due to some personal matters, I haven't been able to dedicate much time to maintaining the app recently.

I'm truly grateful for all the support and contributions from the Open Source community over the past year. Your encouragement and assistance have meant a lot to me and motivated me to continually improve the app. Unfortunately, I've had to step back temporarily to address some personal matters.

Thank you for your understanding and patience. I look forward to resuming work on Clendar and continuing to engage with this fantastic community.

Best Regards,

Vinh Nguyen

---

<h1 align="center">
Clendar - Minimal Calendar
</h1>
<p align="center">Minimal Calendar & Widget</p>

<p align="center"><img src="https://is1-ssl.mzstatic.com/image/thumb/Purple116/v4/1c/4f/b7/1c4fb766-21ba-d822-4370-c7ad59bf6b8f/AppIcon-0-2x-4-85-220.png/230x0w.webp"></p>

<p align="center"><a href="https://apps.apple.com/app/clendar-a-calendar-app/id1548102041#?platform=iphone"
                style="display: inline-block; overflow: hidden; border-top-left-radius: 13px; border-top-right-radius: 13px; border-bottom-right-radius: 13px; border-bottom-left-radius: 13px; width: 250px; height: 83px;"><img
                    src="https://apple-resources.s3.amazonaws.com/media-badges/download-on-the-app-store/white/en-us.svg"
                    alt="Download on the App Store"
                    style="border-top-left-radius: 13px; border-top-right-radius: 13px; border-bottom-right-radius: 13px; border-bottom-left-radius: 13px; width: 250px; height: 83px;"></a></p>

> [Landing Page](http://vinhnx.github.io/clendar-site)

### Table of Contents

- 📋 [About](#about)
- 🚀 [What's Clendar](##whats-clendar)
- 📦 [SwiftUI](#swiftui)
- 💻 [Tip to build on M1 Macs](#tip-to-build-on-m1-macs)
- 📚 [Tech stacks](#tech-stacks)
- 📖 [Requirements](#requirements)
- 💖 [My own Swift Packages currently used in Clendar](#my-own-swift-packages-currently-used-in-clendar)
- 📝 [Contributing](#contributing)
- 📂 [Important Files To Look At](#important-files-to-look-at)
- 🙌 [Contributors](#contributors)
- ⚖️ [License](#license)
- 🏆 [Open-source inspiration](#open-source-inspiration)
  
### About

This project is started out as an UIKit base app for me to learn new WWDC features over the years. But one day, I decided to convert the whole app from UIKit -> SwiftUI and boom, here we are.

This is the PR => https://github.com/vinhnx/Clendar/pull/35

### What's 'Clendar'?

It's just Calendar, without an 'a'. I thought it was unique, but it turns out it's not going well with ASO (App Store Optimization) and SEO (Search Engine Optimization).

Clendar is a calendar app made simpler. The application includes features like widgets, themes, keyboard shortcuts, and natural language parsing.

Its main features include:

-  Widgets, with customizable dark/light themes
-  Keyboard shortcuts
-  Siri shortcuts
-  Apple Watch complications
-  Custom app icons
-  Natural language parsing
-  Lunar day view
-  Dark and light modes built-in
-  Accessibility support
-  Localizations support

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

### Tip to build on M1 Macs

> So, maybe someone, who wants to contribute in this repo will find the next info a very helpful.
> If you have Macbook on m1:
>
> ```bash
> sudo arch -x86_64 gem install ffi
> arch -x86_64 pod install
> ```
> Or:
>
> run terminal with Rosetta and run `pod install`
>> Thanks https://github.com/vinhnx/Clendar/issues/220#issuecomment-1107809043

### Tech stacks

The following technologies were used to develop our application:

Core:

-   [SwiftUI](https://developer.apple.com/xcode/swiftui/) (and UIKit interoperability)
-   iPadOS
-   [WidgetKit](https://developer.apple.com/documentation/widgetkit)
-   [SiriKit](https://developer.apple.com/documentation/sirikit/)
-   EventKit/EvenKit UI - wrapper with my own [Shift package](https://github.com/vinhnx/Shift) 📆
-   [WatchKit](https://developer.apple.com/documentation/watchkit/)
-   Combine
-   Catalyst
-   [StoreKit](https://developer.apple.com/documentation/storekit)

Build delivery tool:

-   [Fastlane](https://fastlane.tools/)

Package Managers:

-   [Swift Package Manager](https://www.swift.org/package-manager/)
-   [CocoaPods](https://cocoapods.org/)

Linter:

-   [SwiftLint](https://swiftpackageindex.com/realm/SwiftLint)

Formatter:

-   [SwiftFormat](https://formulae.brew.sh/cask/swiftformat-for-xcode)

Action:

-   [SwiftLint is integrated on GitHub Action workflow](https://github.com/vinhnx/Clendar/actions?query=workflow%3ASwiftLint) 🚀

### Requirements

(for async/await):

-   Xcode 13.1
-   iOS 15.0
-   watchOS 8.0
-   Ruby (for Fastlane build automation)

### My own Swift Packages currently used in Clendar

-   [Shift](https://github.com/vinhnx/Shift) - Result-based wrapper for EventKit. SwiftUI supported!
-   [Laden](https://github.com/vinhnx/Laden) - SwiftUI loading indicator view

### Contributing

Contributing is more than welcome, if you feel like helping the app, or want to add new features, feel free to take a look at my [issues page](https://github.com/vinhnx/Clendar/issues). Thanks!

How To Contribute:

-  Report issues you're facing
-  Give a 👍 on issues that are relevant to you
-  Answer queries on the issue tracker

If you don't know where to start:

- Navigate to the [issues page](https://github.com/vinhnx/Clendar/issues) 
- Filter by label
- Look for issues related to [good first issue](https://github.com/vinhnx/Clendar/issues?q=is%3Aopen+is%3Aissue+label%3A%22good+first+issue%22)
- Feel free to look at all the issues opened and pick one that interests you!

1. Fork the project repository by clicking Fork in the top right hand corner 🍴
2. Clone the repository onto your local machine using the Git url 💻
3. Switch to the branch you want to work on and start contributing! 📝 

When submitting an issue, please make sure your description is clear and has enough information for someone to be able to reproduce the issue!

### Important Files To Look At

-  [Clendar](https://github.com/vinhnx/Clendar/tree/main/Clendar0)
  -  Clendar application program
-  [ClendarTests](https://github.com/vinhnx/Clendar/tree/main/ClendarTests)
  -  Contents to test the Clendar program on IOS software
-  [ClendarUITests](https://github.com/vinhnx/Clendar/tree/main/ClendarUITests)
  -  Contents to test the Clendar UI on IOS software
-  [ClendarWatchApp Extension](https://github.com/vinhnx/Clendar/tree/main/ClendarWatchApp%20Extension)
  - Contents used to create Clendar compatibility to watchOS using SwiftUI
-  [Packages](https://github.com/vinhnx/Clendar/tree/main/Packages)
  -  Contains Clendar theme and SwiftUI calendar view

### Contributors

Huge thanks everyone who took their precious time and effort to contribute to the project:

-   [Aleksandr Sutulov](https://github.com/AlexanderSutul)
-   [Jan Matoniak](https://github.com/kapucnov2321)
-   [Prabaljit Walia](https://github.com/prabal4546)
-   [Gaurav Kakkar](https://github.com/shadowfax90)
-   [Andrey Bozhko](https://github.com/AndreyBozhko)
-   [carboitel](https://github.com/carboitel)
-   [Michele Zenoni](https://github.com/Levyathanus)
-   [Samis](https://github.com/samis0707)
-  💡 [your name here?...](https://github.com/vinhnx/Clendar/issues) 

Words simply can not describe how thankful am I, I'm deeply appreciated all for your kind contribution. 

I feel very lucky that my small side project help people find inspiration 💙

Thank you again, you rocks!

🇺🇳 🚀

### License

[MIT License](https://github.com/vinhnx/Clendar/blob/main/LICENSE)

You can do whatever you want with this source code: modify, tweak or use as learning resources, for example... 🛠👨🏻‍💻👩🏻‍💻

But, please don't re-distribute the app on App Store with different name. 🥺

And, if you like, you can download the app for free on the [App Store](https://apps.apple.com/us/app/clendar-a-calendar-app/id1548102041?itsct=apps_box&itscg=30200).

### Open-source inspiration

-   https://github.com/jeffreybergier

---

## Star History

[![Star History Chart](https://api.star-history.com/svg?repos=vinhnx/Clendar&type=Date)](https://star-history.com/#vinhnx/Clendar&Date)

---

Thanks and take care! 🍀

I'm on `@vinhnx` on almost everywhere.
