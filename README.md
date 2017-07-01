# Feedback

The easiest way to provide feedback in the form of haptics and sounds for your users.

## Overview

Feedback is an evolution of my other pod, [HapticGenerator](https://github.com/KaneCheshire/HapticGenerator). Just like **HapticGenerator**,
**Feedback** provides an easy and coherent way to generate different types of haptic feedback.
**Feedback** goes a step further and allows you to also play _sound_ as feedback, either with
or without accompanying haptics.

**Feedback** comes with a few default sounds, courtesy of Facebook's [Sound Kit](http://facebook.design/soundkit), but also has
an option to allow you to use custom sounds, which means it will work with any brand.

## Installation

**Feedback** is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "FeedbackGenerator"
```

## Usage

Using **Feedback**, just like **HapticGenerator**, is incredibly simple. You can create generators that
provide just haptics, haptics and sound, or just sound.

Here's how to create a feedback generator that provides has a "success" haptic:

```swift
let successGenerator = Feedback(hapticType: .notification(.success))
```

Here's how to create a feedback generator that just provides a default "error" sound:
```swift
let errorGenerator = Feedback(soundType: .notification(.error))
```

Here's how to create a feedback generator that provides both a haptic and a sound:
```swift
let selectionGenerator = Feedback(hapticType: .selection, soundType: .selection)
```

Once you've created your generator, all you have to do to generate the feedback is this:

```swift
selectionGenerator.generateFeedback()
```

Optionally, if you know in advance when your feedback is likely to be generated, you
can prepare the system for its use:

```swift
selectionGenerator.prepareForUse()
```

You can also provide the name of a custom sound file to use with or without haptics:

```swift
let customSoundWithHaptic = Feedback(hapticType: .impact(.light), soundType: .custom(soundName: "customFileName", extension: "mp3"))
```

## Requirements

**Feedback** works as far back as iOS 8, but haptics will only play on supported devices running iOS 10 or newer.
Under the hood, Feedback uses `UIKit` and `AVFoundation`.

## Author

[@kanecheshire](https://twitter.com/kanecheshire)

## License

Feedback is available under the MIT license. See the LICENSE file for more info.
