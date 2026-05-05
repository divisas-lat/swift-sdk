import XCTest
@testable import DivisasLat

final class DivisasLatTests: XCTestCase {
    func testClientInitialization() throws {
        let client = DivisasLat.DivisasClient(apiKey: "test-key", baseUrl: "https://api.divisas.lat/v1", cacheTtl: 3600)
        XCTAssertEqual(client.apiKey, "test-key")
        XCTAssertEqual(client.baseUrl, "https://api.divisas.lat/v1")
    }
}
