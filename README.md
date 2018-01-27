# SignalTrap

[![Swift][swift-badge-3]][swift-url]
[![Swift][swift-badge-4]][swift-url]
[![Build Status][travis-build-badge]][travis-build-url]
![macOS][macos-badge]
![Linux][linux-badge]
[![License][mit-badge]][mit-url]

A **Swift-3/4** implementation of signal trapping for Linux (untested on Mac etc.) with support for real-time signals.

## Usage

If [Swift Package Manager](https://github.com/apple/swift-package-manager) is used, add this package as a dependency in `Package.swift`,

```swift
import PackageDescription

let package = Package (
    name:  "<your-app-name>",
    dependencies: [
        .Package(url: "https://github.com/itssofluffy/SignalTrap.git", majorVersion: 0)
    ]
)
```

## Example

```swift
import Foundation
import SignalTrap

var count = 0
var started: TimeInterval = 0

do {
    try trap(signals: Signal.allSignals) { signal in
        let runtime = Date().timeIntervalSince1970 - started

        print("received signal: \(Signal(rawValue: signal).description)")
        print("count          : \(count)")
        print("runtime        : \(runtime) seconds")

        exit(EXIT_SUCCESS)
    }

    started = Date().timeIntervalSince1970

    alarm(2) // Wait 2 seconds for the program to be killed

    while true {
        print("timestamp: \(Date().timeIntervalSince1970)")
        count += 1
              
        if (count >= 100000) {
            print("sending signal .TERM")
            try raise(signal: .TERM)
        }
    }
} catch let error as SignalTrapError {
    print(error)
} catch {
    print("an unexpected error '\(error)' has occured in the library libSignalTrap.")
}

// Or stop it yourself with cntrl+C
```

## License

This project is released under the MIT license. See [LICENSE](LICENSE) for details.

[swift-badge-3]: https://img.shields.io/badge/Swift-3.0-orange.svg?style=flat
[swift-badge-4]: https://img.shields.io/badge/Swift-4.0-orange.svg?style=flat
[swift-url]: https://swift.org
[travis-build-badge]: https://travis-ci.org/itssofluffy/SignalTrap.svg?branch=master
[travis-build-url]: https://travis-ci.org/itssofluffy/SignalTrap
[macos-badge]: https://img.shields.io/badge/os-macOS-green.svg?style=flat
[linux-badge]: https://img.shields.io/badge/os-linux-green.svg?style=flat
[mit-badge]: https://img.shields.io/badge/License-MIT-blue.svg?style=flat
[mit-url]: https://tldrlegal.com/license/mit-license
