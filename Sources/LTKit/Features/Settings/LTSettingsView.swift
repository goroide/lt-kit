import SwiftUI

/// Reusable settings screen with history link, privacy policy, and data clear.
public struct LTSettingsView<HistoryContent: View>: View {
    let config: AppConfig
    let onClearAllData: () -> Void
    @ViewBuilder let historyContent: () -> HistoryContent
    @State private var showingClearConfirm = false

    public init(config: AppConfig, onClearAllData: @escaping () -> Void, @ViewBuilder historyContent: @escaping () -> HistoryContent) {
        self.config = config
        self.onClearAllData = onClearAllData
        self.historyContent = historyContent
    }

    public var body: some View {
        List {
            Section {
                NavigationLink { historyContent() } label: {
                    Text("History")
                        .font(.ltBody)
                        .foregroundStyle(.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .contentShape(Rectangle())
                }
                if let url = config.privacyPolicyURL {
                    Link(destination: url) {
                        Text("Privacy Policy")
                            .font(.ltBody)
                            .foregroundStyle(.primary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .contentShape(Rectangle())
                    }
                } else {
                    NavigationLink {
                        LTPrivacyPolicyView()
                    } label: {
                        Text("Privacy Policy")
                            .font(.ltBody)
                            .foregroundStyle(.primary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .contentShape(Rectangle())
                    }
                }
            }
            Section {
                Button(role: .destructive) {
                    showingClearConfirm = true
                } label: {
                    Text("Clear Data")
                        .font(.ltBody)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .contentShape(Rectangle())
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Clear Data", isPresented: $showingClearConfirm) {
            Button("Cancel", role: .cancel) {}
            Button("Clear", role: .destructive) { onClearAllData() }
        } message: {
            Text("All data will be permanently deleted. This action cannot be undone.")
        }
    }
}

/// Default privacy policy view (no external URL configured).
public struct LTPrivacyPolicyView: View {
    public var bodyText: String = """
    This app does not collect any personal information.
    All data entered is stored only on your device and
    is never transmitted to external servers.
    """

    public init(bodyText: String? = nil) {
        if let t = bodyText { self.bodyText = t }
    }

    public var body: some View {
        ScrollView {
            Text(bodyText)
                .font(.ltBody)
                .foregroundStyle(.primary)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.horizontal, LTSpacing.lg)
                .padding(.vertical, LTSpacing.lg)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.ltSurface)
        .navigationTitle("Privacy Policy")
        .navigationBarTitleDisplayMode(.inline)
    }
}
