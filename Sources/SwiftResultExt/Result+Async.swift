extension Result {
    /// Asynchronously transforms the success value using an async throwing closure.
    @inlinable
    public func asyncMap<NewSuccess>(
        _ transform: (Success) async throws -> NewSuccess
    ) async -> Result<NewSuccess, any Error> {
        switch self {
        case .success(let value):
            do { return .success(try await transform(value)) }
            catch { return .failure(error) }
        case .failure(let error):
            return .failure(error)
        }
    }

    /// Asynchronously transforms the success value using an async closure returning a Result.
    @inlinable
    public func asyncFlatMap<NewSuccess, NewFailure: Error>(
        _ transform: (Success) async throws -> Result<NewSuccess, NewFailure>
    ) async -> Result<NewSuccess, any Error> {
        switch self {
        case .success(let value):
            do {
                switch try await transform(value) {
                case .success(let newValue): return .success(newValue)
                case .failure(let newError): return .failure(newError)
                }
            } catch {
                return .failure(error)
            }
        case .failure(let error):
            return .failure(error)
        }
    }
}
