import XCTest
@testable import SwiftResultExt

final class ResultExtTests: XCTestCase {
    enum SampleError: Error, Equatable {
        case failureA
        case failureB
    }

    func testFlatMapSuccessAndFailure() {
        let success: Result<Int, SampleError> = .success(21)
        let mappedSuccess = success.flatMap { value -> Result<String, SampleError> in
            .success("\(value * 2)")
        }
        XCTAssertEqual(try? mappedSuccess.get(), "42")

        let failure: Result<Int, SampleError> = .failure(.failureA)
        let mappedFailure = failure.flatMap { value -> Result<String, SampleError> in
            .success("\(value * 2)")
        }
        XCTAssertEqual(mappedFailure.unwrapOr("fallback"), "fallback")
    }

    func testZipCombinesResults() {
        let first: Result<Int, SampleError> = .success(10)
        let second: Result<String, SampleError> = .success("apples")
        let zipped = zip(first, second)

        let value = zipped.unwrapOr((0, ""))
        XCTAssertEqual(value.0, 10)
        XCTAssertEqual(value.1, "apples")

        let failed: Result<String, SampleError> = .failure(.failureB)
        let failedZip = zip(first, failed)
        XCTAssertThrowsError(try failedZip.unwrapOrThrow())
    }

    func testUnwrapOrAndUnwrapOrThrow() throws {
        let success: Result<String, SampleError> = .success("swift")
        let failure: Result<String, SampleError> = .failure(.failureA)

        XCTAssertEqual(success.unwrapOr("default"), "swift")
        XCTAssertEqual(failure.unwrapOr("default"), "default")

        XCTAssertEqual(try success.unwrapOrThrow(), "swift")
        XCTAssertThrowsError(try failure.unwrapOrThrow()) { error in
            XCTAssertEqual(error as? SampleError, .failureA)
        }
    }
}
