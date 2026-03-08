import SwiftUI

/// Centered title header with optional trailing button.
public struct LTPageHeader: View {
    let title: String
    let trailingLabel: String?
    let trailingAction: (() -> Void)?

    public init(title: String, trailingLabel: String? = nil, trailingAction: (() -> Void)? = nil) {
        self.title = title
        self.trailingLabel = trailingLabel
        self.trailingAction = trailingAction
    }

    public var body: some View {
        ZStack(alignment: .trailing) {
            Text(title)
                .font(.ltTitle)
                .foregroundStyle(.primary)
                .frame(maxWidth: .infinity)
            if let label = trailingLabel, let action = trailingAction {
                Button(action: action) {
                    Text(label)
                        .font(.ltBody)
                        .foregroundStyle(.primary)
                        .padding(.vertical, LTSpacing.sm)
                        .padding(.horizontal, LTSpacing.sm)
                        .contentShape(Rectangle())
                }
            }
        }
    }
}
