# Signal trapping

## Usage

If [Swift Package Manager](https://github.com/apple/swift-package-manager) is
used, add this package as a dependency in `Package.swift`,

```swift
.Package(url: "https://github.com/itssofluffy/Signaltrap.git", majorVersion: 0)
```

## Example

```swift
import Signaltrap

let hupHandler: SigactionHandler = { signal in
    print("received .HUP")
}

trap(.INT) { signal in
//
// do our clear up operations
//
    exit(0)
}

trap(.HUP, action: hupHandler)
```
