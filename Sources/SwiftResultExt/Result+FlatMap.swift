extension Result {
    /// Transforms the success value with a closure returning a `Result` of a potentially different failure type.
    @inlinable
    public func flatMap<NewSuccess, NewFailure: Error>(
        _ transform: (Success) -> Result<NewSuccess, NewFailure>
    ) -> Result<NewSuccess, any Error> {
        switch self {
        case .success(let value):
            switch transform(value) {
            case .success(let newValue): return .success(newValue)
            case .failure(let error): return .failure(error)
            }
        case .failure(let error):
            return .failure(error)
        }
    }

    /// Transforms the failure value using a throwing closure.
    @inlinable
    public func mapError(_ transform: (Failure) throws -> any Error) -> Result<Success, any Error> {
        switch self {
        case .success(let value): return .success(value)
        case .failure(let error):
            do { return .failure(try transform(error)) }
            catch { return .failure(error) }
        }
    }

    /// Returns the success value or a provided fallback default.
    @inlinable
    public func unwrapOr(_ fallback: @autoclosure () -> Success) -> Success {
        switch self {
        case .success(let value): return value
        case .failure: return fallback()
        }
    }

    /// Returns the success value or throws the contained failure error.
    @inlinable
    public func unwrapOrThrow() throws(Failure) -> Success {
        switch self {
        case .success(let value): return value
        case .failure(let error): throw error
        }
    }
}
