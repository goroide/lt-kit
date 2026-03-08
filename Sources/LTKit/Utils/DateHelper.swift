import Foundation

public enum DateHelper {
    private static let dateKeyFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "yyyy-MM-dd"
        f.timeZone = TimeZone.current
        f.locale = Locale(identifier: "en_US_POSIX")
        return f
    }()

    private static let displayDateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "yyyy/MM/dd"
        f.timeZone = TimeZone.current
        f.locale = Locale(identifier: "en_US_POSIX")
        return f
    }()

    private static let monthNames = [
        "January", "February", "March", "April", "May", "June",
        "July", "August", "September", "October", "November", "December"
    ]

    /// Today's dateKey (yyyy-MM-dd)
    public static func todayKey(calendar: Calendar = .current) -> String {
        dateKey(from: Date(), calendar: calendar)
    }

    /// Converts Date to dateKey (yyyy-MM-dd)
    public static func dateKey(from date: Date, calendar: Calendar = .current) -> String {
        let comps = calendar.dateComponents([.year, .month, .day], from: date)
        guard let d = calendar.date(from: comps) else {
            return dateKeyFormatter.string(from: date)
        }
        return dateKeyFormatter.string(from: d)
    }

    /// Converts dateKey to display format "yyyy/MM/dd"
    public static func displayDate(from dateKey: String) -> String {
        guard let date = dateKeyFormatter.date(from: dateKey) else {
            return dateKey
        }
        return displayDateFormatter.string(from: date)
    }

    /// Converts dateKey to long display format (no zero-padding). e.g. "March 7, 2026"
    public static func displayDateKanji(from dateKey: String, calendar: Calendar = .current) -> String {
        guard let date = dateKeyFormatter.date(from: dateKey) else {
            return dateKey
        }
        let c = calendar.dateComponents([.year, .month, .day], from: date)
        guard let y = c.year, let m = c.month, let d = c.day, m >= 1, m <= 12 else {
            return dateKey
        }
        return "\(monthNames[m - 1]) \(d), \(y)"
    }

    /// Year-month display for dateKey. e.g. "March 2026"
    public static func displayYearMonth(from dateKey: String, calendar: Calendar = .current) -> String {
        guard let date = dateKeyFormatter.date(from: dateKey) else {
            return dateKey
        }
        let c = calendar.dateComponents([.year, .month], from: date)
        guard let y = c.year, let m = c.month, m >= 1, m <= 12 else {
            return dateKey
        }
        return "\(monthNames[m - 1]) \(y)"
    }

    private static let weekdayFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "EEEE"
        f.locale = Locale(identifier: "en_US")
        f.timeZone = TimeZone.current
        return f
    }()

    private static let weekdayShortFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "EEE"
        f.locale = Locale(identifier: "en_US")
        f.timeZone = TimeZone.current
        return f
    }()

    /// Returns the weekday for dateKey. e.g. "Saturday"
    public static func weekdayString(from dateKey: String) -> String {
        guard let date = dateKeyFormatter.date(from: dateKey) else {
            return ""
        }
        return weekdayFormatter.string(from: date)
    }

    /// Single-line date with full weekday. e.g. "March 2, 2026 (Friday)"
    public static func displayDateWithWeekdayShort(from dateKey: String, calendar: Calendar = .current) -> String {
        let dateStr = displayDateKanji(from: dateKey, calendar: calendar)
        let weekday = weekdayString(from: dateKey)
        guard !weekday.isEmpty else { return dateKey }
        return "\(dateStr) (\(weekday))"
    }

    /// Returns the 3-letter weekday abbreviation. e.g. "Sun"
    public static func weekdayShortChar(from dateKey: String, calendar: Calendar = .current) -> String {
        guard let date = dateKeyFormatter.date(from: dateKey) else { return "" }
        return weekdayShortFormatter.string(from: date)
    }

    /// Single-line date with 3-letter weekday. e.g. "March 8, 2026 (Sun)" (Figma design)
    public static func displayDateWithWeekdayChar(from dateKey: String, calendar: Calendar = .current) -> String {
        let dateStr = displayDateKanji(from: dateKey, calendar: calendar)
        let w = weekdayShortChar(from: dateKey, calendar: calendar)
        guard !w.isEmpty else { return dateKey }
        return "\(dateStr) (\(w))"
    }

    /// Returns the dateKey for the next day
    public static func nextDay(from dateKey: String, calendar: Calendar = .current) -> String? {
        guard let date = dateKeyFormatter.date(from: dateKey) else { return nil }
        guard let next = calendar.date(byAdding: .day, value: 1, to: date) else { return nil }
        return Self.dateKey(from: next, calendar: calendar)
    }

    /// Returns the dateKey for the previous day
    public static func previousDay(from dateKey: String, calendar: Calendar = .current) -> String? {
        guard let date = dateKeyFormatter.date(from: dateKey) else { return nil }
        guard let prev = calendar.date(byAdding: .day, value: -1, to: date) else { return nil }
        return Self.dateKey(from: prev, calendar: calendar)
    }

    /// Returns the dateKey 7 days before (previous week)
    public static func previousWeek(from dateKey: String, calendar: Calendar = .current) -> String? {
        guard let date = dateKeyFormatter.date(from: dateKey) else { return nil }
        guard let prev = calendar.date(byAdding: .day, value: -7, to: date) else { return nil }
        return Self.dateKey(from: prev, calendar: calendar)
    }

    /// Returns the dateKey 7 days after (next week)
    public static func nextWeek(from dateKey: String, calendar: Calendar = .current) -> String? {
        guard let date = dateKeyFormatter.date(from: dateKey) else { return nil }
        guard let next = calendar.date(byAdding: .day, value: 7, to: date) else { return nil }
        return Self.dateKey(from: next, calendar: calendar)
    }

    /// Returns the dateKey for the same day in the previous month (or last day if it doesn't exist)
    public static func previousMonth(from dateKey: String, calendar: Calendar = .current) -> String? {
        guard let date = dateKeyFormatter.date(from: dateKey) else { return nil }
        guard let prev = calendar.date(byAdding: .month, value: -1, to: date) else { return nil }
        return Self.dateKey(from: prev, calendar: calendar)
    }

    /// Returns the dateKey for the same day in the next month (or last day if it doesn't exist)
    public static func nextMonth(from dateKey: String, calendar: Calendar = .current) -> String? {
        guard let date = dateKeyFormatter.date(from: dateKey) else { return nil }
        guard let next = calendar.date(byAdding: .month, value: 1, to: date) else { return nil }
        return Self.dateKey(from: next, calendar: calendar)
    }
}
