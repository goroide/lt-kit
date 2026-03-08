import SwiftUI

/// A card displaying progress toward a numeric goal.
/// Usage: LTProgressCard(title: "Water", current: 5, goal: 8, unit: "cups")
public struct LTProgressCard: View {
    public let title: String
    public let current: Double
    public let goal: Double
    public var unit: String = ""
    public var color: Color = .accentColor

    public init(title: String, current: Double, goal: Double, unit: String = "", color: Color = .accentColor) {
        self.title = title
        self.current = current
        self.goal = goal
        self.unit = unit
        self.color = color
    }

    private var progress: Double { min(current / max(goal, 1), 1.0) }

    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(title)
                    .font(.ltCaption)
                    .foregroundStyle(.ltOnSurfaceSecondary)
                Spacer()
                Text("\(Int(current))/\(Int(goal))\(unit.isEmpty ? "" : " \(unit)")")
                    .font(.ltCaption)
                    .fontWeight(.bold)
            }
            ProgressView(value: progress)
                .tint(color)
        }
        .padding()
        .background(color.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    LTProgressCard(title: "Water", current: 5, goal: 8, unit: "cups", color: .blue)
        .padding()
}
