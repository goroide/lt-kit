import Foundation

/// Generic JSON-backed persistent store.
/// Usage: JSONStore<[Habit]>(fileName: "habits.json")
public final class JSONStore<T: Codable> {
    private let fileURL: URL
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()

    public init(fileName: String, directory: URL? = nil) {
        let base = directory ?? (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first ?? FileManager.default.temporaryDirectory)
        self.fileURL = base.appendingPathComponent(fileName)
    }

    public func load() -> T? {
        guard FileManager.default.fileExists(atPath: fileURL.path) else { return nil }
        guard let data = try? Data(contentsOf: fileURL) else { return nil }
        return try? decoder.decode(T.self, from: data)
    }

    public func save(_ value: T) {
        guard let data = try? encoder.encode(value) else { return }
        try? data.write(to: fileURL)
    }

    public func clear() {
        try? FileManager.default.removeItem(at: fileURL)
    }
}
