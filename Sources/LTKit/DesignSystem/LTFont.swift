import SwiftUI

/// Typography scale for the Life Tracker app series.
public extension Font {
    static var ltLargeTitle: Font { .system(size: 34, weight: .bold) }
    static var ltTitle: Font     { .system(size: 20, weight: .bold) }
    static var ltHeadline: Font  { .system(size: 16, weight: .semibold) }
    static var ltBody: Font      { .system(size: 16, weight: .regular) }
    static var ltSubheadline: Font { .system(size: 14, weight: .regular) }
    static var ltCaption: Font   { .system(size: 12, weight: .regular) }
}
