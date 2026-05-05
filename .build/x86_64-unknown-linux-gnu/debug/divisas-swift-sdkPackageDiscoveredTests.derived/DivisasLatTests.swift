import XCTest
@testable import DivisasLatTests

fileprivate extension DivisasLatTests {
    @available(*, deprecated, message: "Not actually deprecated. Marked as deprecated to allow inclusion of deprecated tests (which test deprecated functionality) without warnings")
    static nonisolated(unsafe) let __allTests__DivisasLatTests = [
        ("testClientInitialization", testClientInitialization)
    ]
}
@available(*, deprecated, message: "Not actually deprecated. Marked as deprecated to allow inclusion of deprecated tests (which test deprecated functionality) without warnings")
func __DivisasLatTests__allTests() -> [XCTestCaseEntry] {
    return [
        testCase(DivisasLatTests.__allTests__DivisasLatTests)
    ]
}