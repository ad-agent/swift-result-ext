import Foundation
/// Sequence extensions for collecting Results.
extension Sequence {
    public func compactMapResults<S, F: Error>() -> [S] where Element == Result<S, F> {
        compactMap { try? $0.get() }
    }
}
