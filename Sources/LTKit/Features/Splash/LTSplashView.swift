import SwiftUI
import UIKit

/// Reusable splash screen. Pass appDisplayName and logoImageName (Assets).
public struct LTSplashView: View {
    let appDisplayName: String
    let logoImageName: String
    let subtitle: String

    public init(appDisplayName: String, logoImageName: String = "SplashLogo", subtitle: String = "") {
        self.appDisplayName = appDisplayName
        self.logoImageName = logoImageName
        self.subtitle = subtitle
    }

    public var body: some View {
        VStack(spacing: LTSpacing.md) {
            Spacer()
            Group {
                if let uiImage = UIImage(named: logoImageName) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                } else {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.ltOnSurface.opacity(0.06))
                        .frame(width: 157, height: 160)
                }
            }
            .frame(width: 157, height: 160)
            VStack(spacing: LTSpacing.sm) {
                Text(appDisplayName)
                    .font(.ltLargeTitle)
                    .foregroundStyle(.primary)
                if !subtitle.isEmpty {
                    Text(subtitle)
                        .font(.ltCaption)
                        .foregroundStyle(.primary)
                }
            }
            .frame(maxWidth: .infinity)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, LTSpacing.lg)
        .padding(.vertical, LTSpacing.xl)
        .background(Color.ltSurface)
    }
}
