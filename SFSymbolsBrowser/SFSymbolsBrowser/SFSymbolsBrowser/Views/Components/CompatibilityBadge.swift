import SwiftUI
import SFSymbols

/// Badge showing iOS version compatibility for a symbol
struct CompatibilityBadge: View {
    let symbolName: String
    let targetVersion: Double

    private var minimumVersion: Double {
        // Determine minimum iOS version for symbol
        // Most SF Symbols are available from iOS 13+
        // Newer symbols require iOS 14+, 15+, 16+, 17+, or 18+
        SymbolVersionInfo.minimumVersion(for: symbolName)
    }

    private var isCompatible: Bool {
        minimumVersion <= targetVersion
    }

    var body: some View {
        HStack(spacing: 4) {
            Image(symbol: isCompatible ? .checkmarkCircleFill : .exclamationmarkTriangleFill)
                .font(.caption2)
                .foregroundStyle(isCompatible ? .green : .orange)

            Text("iOS \(formattedVersion)+")
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(
            Capsule()
                .fill(isCompatible ? Color.green.opacity(0.1) : Color.orange.opacity(0.1))
        )
    }

    private var formattedVersion: String {
        if minimumVersion == floor(minimumVersion) {
            return String(format: "%.0f", minimumVersion)
        }
        return String(format: "%.1f", minimumVersion)
    }
}

// MARK: - Premium Compatibility Badge
struct PremiumCompatibilityBadge: View {
    let symbolName: String
    let targetVersion: Double

    private var minimumVersion: Double {
        SymbolVersionInfo.minimumVersion(for: symbolName)
    }

    private var isCompatible: Bool {
        minimumVersion <= targetVersion
    }

    var body: some View {
        HStack(spacing: 6) {
            Image(symbol: isCompatible ? .checkmarkCircleFill : .exclamationmarkTriangleFill)
                .font(.caption)
                .foregroundStyle(isCompatible ? .green : .orange)

            VStack(alignment: .leading, spacing: 0) {
                Text("iOS \(formattedVersion)+")
                    .font(.caption.weight(.medium))
                    .foregroundStyle(.primary)

                Text(isCompatible ? "Compatible" : "Requires newer iOS")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.horizontal, DesignSystem.Spacing.md)
        .padding(.vertical, DesignSystem.Spacing.sm)
        .background(
            RoundedRectangle(cornerRadius: DesignSystem.Radius.medium, style: .continuous)
                .fill(isCompatible ? Color.green.opacity(0.1) : Color.orange.opacity(0.1))
        )
        .overlay(
            RoundedRectangle(cornerRadius: DesignSystem.Radius.medium, style: .continuous)
                .strokeBorder(isCompatible ? Color.green.opacity(0.3) : Color.orange.opacity(0.3), lineWidth: 1)
        )
    }

    private var formattedVersion: String {
        if minimumVersion == floor(minimumVersion) {
            return String(format: "%.0f", minimumVersion)
        }
        return String(format: "%.1f", minimumVersion)
    }
}

// MARK: - Symbol Version Info
struct SymbolVersionInfo {
    /// Determine minimum iOS version for a symbol based on naming conventions
    static func minimumVersion(for symbolName: String) -> Double {
        // iOS 18+ symbols (2024) - typically newest additions
        let ios18Keywords = [
            "apple.intelligence", "writing.tools", "genmoji",
            "gamecontroller.fill", "visionpro", "spatial"
        ]
        for keyword in ios18Keywords {
            if symbolName.contains(keyword) { return 18.0 }
        }

        // iOS 17+ symbols (2023)
        let ios17Keywords = [
            "apple.logo", "storefront", "shared.with.you",
            "theatermask", "figure.run", "figure.walk",
            "figure.stand", "figure.wave", "figure.fall",
            "chair.lounge", "tent", "balloon", "party.popper",
            "lamp.desk", "lamp.floor", "lamp.ceiling"
        ]
        for keyword in ios17Keywords {
            if symbolName.contains(keyword) { return 17.0 }
        }

        // iOS 16+ symbols (2022)
        let ios16Keywords = [
            "aqi", "sensor", "carbon.dioxide", "humidity",
            "gauge.with.dots", "syringe", "cross.vial",
            "allergens", "microbe", "ivfluid.bag",
            "medical.thermometer", "pill", "pills",
            "stethoscope", "bandage", "brain.head.profile"
        ]
        for keyword in ios16Keywords {
            if symbolName.contains(keyword) { return 16.0 }
        }

        // iOS 15+ symbols (2021)
        let ios15Keywords = [
            "shareplay", "faceid", "touchid", "person.badge.key",
            "lanyardcard", "character.bubble", "text.bubble",
            "checklist", "list.bullet.clipboard", "clock.badge",
            "platter", "tray.2", "folder.badge.gear"
        ]
        for keyword in ios15Keywords {
            if symbolName.contains(keyword) { return 15.0 }
        }

        // iOS 14+ symbols (2020)
        let ios14Keywords = [
            "applewatch", "homepod", "hifispeaker", "appletv",
            "car", "bicycle", "scooter", "airplane",
            "tram", "bus", "ferry", "cablecar",
            "character", "textformat", "a.magnify",
            "case", "latch", "face.smiling", "face.dashed"
        ]
        for keyword in ios14Keywords {
            if symbolName.contains(keyword) { return 14.0 }
        }

        // Default to iOS 13 (original SF Symbols)
        return 13.0
    }

    /// Get detailed version info
    static func versionInfo(for symbolName: String) -> (version: Double, year: Int, sfSymbolsVersion: String) {
        let version = minimumVersion(for: symbolName)
        switch version {
        case 18.0: return (18.0, 2024, "SF Symbols 6")
        case 17.0: return (17.0, 2023, "SF Symbols 5")
        case 16.0: return (16.0, 2022, "SF Symbols 4")
        case 15.0: return (15.0, 2021, "SF Symbols 3")
        case 14.0: return (14.0, 2020, "SF Symbols 2")
        default: return (13.0, 2019, "SF Symbols 1")
        }
    }
}

// MARK: - Compact Badge
struct CompactCompatibilityBadge: View {
    let symbolName: String
    let targetVersion: Double

    private var minimumVersion: Double {
        SymbolVersionInfo.minimumVersion(for: symbolName)
    }

    private var isCompatible: Bool {
        minimumVersion <= targetVersion
    }

    var body: some View {
        Image(symbol: isCompatible ? .checkmarkCircleFill : .exclamationmarkTriangleFill)
            .font(.caption)
            .foregroundStyle(isCompatible ? .green : .orange)
            .help("Requires iOS \(String(format: "%.0f", minimumVersion))+")
    }
}

#Preview {
    VStack(spacing: 16) {
        CompatibilityBadge(symbolName: "heart.fill", targetVersion: 15.0)
        CompatibilityBadge(symbolName: "shareplay", targetVersion: 14.0)

        Divider()

        PremiumCompatibilityBadge(symbolName: "heart.fill", targetVersion: 15.0)
        PremiumCompatibilityBadge(symbolName: "storefront", targetVersion: 15.0)

        Divider()

        HStack {
            CompactCompatibilityBadge(symbolName: "heart.fill", targetVersion: 15.0)
            CompactCompatibilityBadge(symbolName: "brain.head.profile", targetVersion: 14.0)
        }
    }
    .padding()
}
