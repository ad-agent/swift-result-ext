# SwiftResultExt

A lightweight, expressive extension library for Swift's standard `Result` type, designed for functional composition, safe error mapping, and unwrapping with full Swift 6 strict concurrency support.

## Features

- **Functional Chaining**: Compose results across error domains using `flatMap` and `mapError`.
- **Safe Unwrapping**: Extract values cleanly with `unwrapOr` and typed throws via `unwrapOrThrow`.
- **Combination**: Combine results into tuples with `zip` or aggregate collections with `merge`.
- **Asynchronous Extensions**: Transform results across async boundaries with `asyncMap` and `asyncFlatMap`.
- **Swift 6 Strict Concurrency**: Fully compliant with Swift 6 language mode and strict concurrency checking.

## Installation

Add `SwiftResultExt` to your `Package.swift` package dependencies:

```swift
dependencies: [
    .package(url: "https://github.com/ad-agent/swift-result-ext.git", from: "1.0.0")
]
```

Add `SwiftResultExt` to your target dependencies:

```swift
.target(
    name: "AppTarget",
    dependencies: ["SwiftResultExt"]
)
```

## Quick Start

```swift
import SwiftResultExt

// Safe unwrapping
let fallback = Result<Int, Error>.failure(MyError.notFound).unwrapOr(0)

// Combining results
let first: Result<Int, Error> = .success(42)
let second: Result<String, Error> = .success("answers")
let pair = zip(first, second) // .success((42, "answers"))

// Async transformation
let user = await result.asyncMap { id in
    try await database.fetchUser(id)
}
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
