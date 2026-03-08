import SwiftUI

/// Full-width primary action button (height: 64pt).
public struct LTPrimaryButton: View {
    let title: String
    let action: () -> Void
    var disabled: Bool = false

    public init(_ title: String, disabled: Bool = false, action: @escaping () -> Void) {
        self.title = title
        self.disabled = disabled
        self.action = action
    }

    public var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .font(.ltTitle)
                .foregroundStyle(Color.ltSurface)
                .frame(maxWidth: .infinity)
                .frame(height: 64)
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .disabled(disabled)
        .background(disabled ? Color.ltOnSurface.opacity(0.3) : Color.ltOnSurface)
    }
}
