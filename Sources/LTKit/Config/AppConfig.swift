import SwiftUI

/// Per-app configuration. Define one static instance per app target.
public struct AppConfig {
    public let appName: String
    public let appDisplayName: String
    public let bundleId: String
    public let accentColor: Color
    public let storageKeys: StorageKeys
    public let privacyPolicyURL: URL?
    public let appStoreURL: URL?

    public init(
        appName: String,
        appDisplayName: String,
        bundleId: String,
        accentColor: Color,
        storageKeys: StorageKeys,
        privacyPolicyURL: URL? = nil,
        appStoreURL: URL? = nil
    ) {
        self.appName = appName
        self.appDisplayName = appDisplayName
        self.bundleId = bundleId
        self.accentColor = accentColor
        self.storageKeys = storageKeys
        self.privacyPolicyURL = privacyPolicyURL
        self.appStoreURL = appStoreURL
    }

    public struct StorageKeys {
        public let primaryFile: String
        public let secondaryFile: String?

        public init(primaryFile: String, secondaryFile: String? = nil) {
            self.primaryFile = primaryFile
            self.secondaryFile = secondaryFile
        }
    }
}
