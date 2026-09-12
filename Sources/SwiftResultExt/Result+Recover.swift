/// Recovery extensions for Result types.
extension Result {
    /// Attempt to recover from a failure using a fallback operation.
    public func recover(_ transform: (Failure) -> Success) -> Result<Success, Failure> {
        switch self {
        case .success: return self
        case .failure(let error): return .success(transform(error))
        }
    }

    /// Attempt to recover from a failure with a throwing operation.
    public func tryRecover(_ transform: (Failure) throws -> Success) -> Result<Success, any Error> {
        switch self {
        case .success(let value): return .success(value)
        case .failure(let error):
            do { return .success(try transform(error)) }
            catch { return .failure(error) }
        }
    }

    /// Returns the success value or nil.
    public var value: Success? {
        if case .success(let v) = self { return v }
        return nil
    }
}
