import Foundation
/// Combines two Results into a tuple Result, returning the first encountered failure if either fails.
public func zip<T, U, Failure: Error>(
    _ first: Result<T, Failure>,
    _ second: Result<U, Failure>
) -> Result<(T, U), Failure> {
    switch (first, second) {
    case (.success(let a), .success(let b)): return .success((a, b))
    case (.failure(let error), _): return .failure(error)
    case (_, .failure(let error)): return .failure(error)
    }
}

/// Combines two Results with differing error types into a tuple Result.
public func zip<T, U, E1: Error, E2: Error>(
    _ first: Result<T, E1>,
    _ second: Result<U, E2>
) -> Result<(T, U), any Error> {
    switch (first, second) {
    case (.success(let a), .success(let b)): return .success((a, b))
    case (.failure(let error), _): return .failure(error)
    case (_, .failure(let error)): return .failure(error)
    }
}

/// Merges a collection of Results into an array Result, or returns the first failure encountered.
public func merge<T, Failure: Error>(_ results: [Result<T, Failure>]) -> Result<[T], Failure> {
    var values: [T] = []
    values.reserveCapacity(results.count)
    for result in results {
        switch result {
        case .success(let value): values.append(value)
        case .failure(let error): return .failure(error)
        }
    }
    return .success(values)
}
