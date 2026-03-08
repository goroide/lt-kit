import SwiftUI

/// A card displaying a single numeric metric with a label and unit.
/// Usage: MetricCard(title: "Today", value: "3", unit: "times")
public struct LTMetricCard: View {
    public let title: String
    public let value: String
    public let unit: String
    public var color: Color = .accentColor

    public init(title: String, value: String, unit: String, color: Color = .accentColor) {
        self.title = title
        self.value = value
        self.unit = unit
        self.color = color
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.ltCaption)
                .foregroundStyle(Color.ltOnSurfaceSecondary)
            HStack(alignment: .lastTextBaseline, spacing: 2) {
                Text(value)
                    .font(.ltTitle)
                Text(unit)
                    .font(.ltCaption)
                    .foregroundStyle(Color.ltOnSurfaceSecondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(color.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    LTMetricCard(title: "Today", value: "3", unit: "times")
        .padding()
}
