import Foundation
/// Validation helpers for Result chains.
extension Result where Failure == any Error {
    public func validate(_ predicate: (Success) throws -> Bool, or error: any Error) -> Result<Success, any Error> {
        flatMap { value in
            do {
                guard try predicate(value) else { return .failure(error) }
                return .success(value)
            } catch { return .failure(error) }
        }
    }
}
