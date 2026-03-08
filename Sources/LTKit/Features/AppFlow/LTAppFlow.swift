import SwiftUI

private let splashDisplayDuration: TimeInterval = 2.0

/// Common app startup flow: Splash -> FirstTime or Home.
public struct LTAppFlow<HomeContent: View, FirstTimeContent: View>: View {
    let splashDisplayName: String
    let splashLogoName: String
    let splashSubtitle: String
    let hasSeenSplashKey: String
    let isEmpty: Bool
    @ViewBuilder let home: () -> HomeContent
    @ViewBuilder let firstTime: () -> FirstTimeContent

    @AppStorage private var hasSeenSplash: Bool
    @State private var showSplash = true

    public init(
        splashDisplayName: String,
        splashLogoName: String = "SplashLogo",
        splashSubtitle: String = "",
        hasSeenSplashKey: String,
        isEmpty: Bool,
        @ViewBuilder home: @escaping () -> HomeContent,
        @ViewBuilder firstTime: @escaping () -> FirstTimeContent
    ) {
        self.splashDisplayName = splashDisplayName
        self.splashLogoName = splashLogoName
        self.splashSubtitle = splashSubtitle
        self.hasSeenSplashKey = hasSeenSplashKey
        self.isEmpty = isEmpty
        self.home = home
        self.firstTime = firstTime
        self._hasSeenSplash = AppStorage(wrappedValue: false, hasSeenSplashKey)
    }

    public var body: some View {
        Group {
            if showSplash {
                LTSplashView(appDisplayName: splashDisplayName, logoImageName: splashLogoName, subtitle: splashSubtitle)
            } else if isEmpty {
                firstTime()
            } else {
                home()
            }
        }
        .onAppear {
            if !hasSeenSplash || isEmpty {
                showSplash = true
                DispatchQueue.main.asyncAfter(deadline: .now() + splashDisplayDuration) {
                    hasSeenSplash = true
                    showSplash = false
                }
            } else {
                showSplash = false
            }
        }
    }
}
