import XCTest
@testable import LTKit

final class JSONStoreTests: XCTestCase {
    func testSaveAndLoad() {
        let dir = FileManager.default.temporaryDirectory
        let store = JSONStore<[String]>(fileName: "test_\(UUID().uuidString).json", directory: dir)
        let items = ["a", "b", "c"]
        store.save(items)
        XCTAssertEqual(store.load(), items)
        store.clear()
        XCTAssertNil(store.load())
    }
}
