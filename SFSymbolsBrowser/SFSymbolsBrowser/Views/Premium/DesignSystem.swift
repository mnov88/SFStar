import SwiftUI

// MARK: - Design System Constants
/// Apple Design Award-worthy design system with carefully crafted values
enum DesignSystem {
    // MARK: - Animation Presets
    enum Animation {
        /// Bouncy spring for playful interactions
        static let bouncy = SwiftUI.Animation.spring(response: 0.4, dampingFraction: 0.6, blendDuration: 0)

        /// Snappy spring for quick feedback
        static let snappy = SwiftUI.Animation.spring(response: 0.3, dampingFraction: 0.7, blendDuration: 0)

        /// Smooth spring for elegant transitions
        static let smooth = SwiftUI.Animation.spring(response: 0.5, dampingFraction: 0.8, blendDuration: 0)

        /// Gentle spring for subtle movements
        static let gentle = SwiftUI.Animation.spring(response: 0.6, dampingFraction: 0.9, blendDuration: 0)

        /// Interactive spring for real-time gestures
        static let interactive = SwiftUI.Animation.interactiveSpring(response: 0.3, dampingFraction: 0.7, blendDuration: 0.25)
    }

    // MARK: - Spacing
    enum Spacing {
        static let xxs: CGFloat = 2
        static let xs: CGFloat = 4
        static let sm: CGFloat = 8
        static let md: CGFloat = 16
        static let lg: CGFloat = 24
        static let xl: CGFloat = 32
        static let xxl: CGFloat = 48
    }

    // MARK: - Corner Radius
    enum Radius {
        static let small: CGFloat = 8
        static let medium: CGFloat = 12
        static let large: CGFloat = 16
        static let xl: CGFloat = 24
        static let capsule: CGFloat = 100
    }

    // MARK: - Shadows
    enum Shadow {
        static func soft(color: Color = .black.opacity(0.1)) -> some View {
            Color.clear.shadow(color: color, radius: 10, x: 0, y: 4)
        }

        static func medium(color: Color = .black.opacity(0.15)) -> some View {
            Color.clear.shadow(color: color, radius: 20, x: 0, y: 8)
        }

        static func strong(color: Color = .black.opacity(0.2)) -> some View {
            Color.clear.shadow(color: color, radius: 30, x: 0, y: 12)
        }
    }

    // MARK: - Gradient Colors
    enum Gradient {
        static let dawn: [Color] = [
            Color(red: 1.0, green: 0.6, blue: 0.4),
            Color(red: 1.0, green: 0.4, blue: 0.6),
            Color(red: 0.8, green: 0.4, blue: 0.8)
        ]

        static let ocean: [Color] = [
            Color(red: 0.2, green: 0.6, blue: 0.9),
            Color(red: 0.4, green: 0.8, blue: 0.9),
            Color(red: 0.3, green: 0.9, blue: 0.7)
        ]

        static let forest: [Color] = [
            Color(red: 0.2, green: 0.7, blue: 0.4),
            Color(red: 0.4, green: 0.8, blue: 0.5),
            Color(red: 0.3, green: 0.6, blue: 0.5)
        ]

        static let midnight: [Color] = [
            Color(red: 0.1, green: 0.1, blue: 0.3),
            Color(red: 0.2, green: 0.2, blue: 0.5),
            Color(red: 0.3, green: 0.2, blue: 0.4)
        ]

        static let subtle: [Color] = [
            Color(red: 0.95, green: 0.95, blue: 0.97),
            Color(red: 0.92, green: 0.94, blue: 0.98),
            Color(red: 0.94, green: 0.92, blue: 0.96)
        ]
    }
}

// MARK: - Haptic Feedback Manager
@MainActor
final class HapticManager {
    static let shared = HapticManager()

    private init() {}

    /// Light tap - for selections
    func lightTap() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }

    /// Medium tap - for confirmations
    func mediumTap() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }

    /// Heavy tap - for important actions
    func heavyTap() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
    }

    /// Soft tap - for subtle feedback
    func softTap() {
        let generator = UIImpactFeedbackGenerator(style: .soft)
        generator.impactOccurred()
    }

    /// Rigid tap - for precise feedback
    func rigidTap() {
        let generator = UIImpactFeedbackGenerator(style: .rigid)
        generator.impactOccurred()
    }

    /// Selection changed
    func selection() {
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
    }

    /// Success notification
    func success() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }

    /// Warning notification
    func warning() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)
    }

    /// Error notification
    func error() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }

    /// Custom pattern - heartbeat
    func heartbeat() {
        Task {
            lightTap()
            try? await Task.sleep(nanoseconds: 100_000_000)
            mediumTap()
        }
    }

    /// Custom pattern - celebration
    func celebration() {
        Task {
            for _ in 0..<3 {
                lightTap()
                try? await Task.sleep(nanoseconds: 80_000_000)
            }
            success()
        }
    }
}

// MARK: - View Extensions
extension View {
    /// Apply design system shadow
    func softShadow() -> some View {
        self.shadow(color: .black.opacity(0.08), radius: 10, x: 0, y: 4)
    }

    func mediumShadow() -> some View {
        self.shadow(color: .black.opacity(0.12), radius: 20, x: 0, y: 8)
    }

    /// Apply glass morphism effect
    func glassEffect(cornerRadius: CGFloat = DesignSystem.Radius.large) -> some View {
        self
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
    }

    /// Apply floating card style
    func floatingCard() -> some View {
        self
            .background(
                RoundedRectangle(cornerRadius: DesignSystem.Radius.large, style: .continuous)
                    .fill(.background)
                    .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 2)
                    .shadow(color: .black.opacity(0.04), radius: 20, x: 0, y: 10)
            )
    }

    /// Interactive scale effect
    func interactiveScale(isPressed: Bool) -> some View {
        self.scaleEffect(isPressed ? 0.96 : 1.0)
            .animation(DesignSystem.Animation.snappy, value: isPressed)
    }

    /// Shimmer loading effect
    @ViewBuilder
    func shimmer(_ isActive: Bool = true) -> some View {
        if isActive {
            self.modifier(ShimmerModifier())
        } else {
            self
        }
    }
}

// MARK: - Shimmer Modifier
struct ShimmerModifier: ViewModifier {
    @State private var phase: CGFloat = 0

    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { geometry in
                    LinearGradient(
                        colors: [
                            .clear,
                            .white.opacity(0.4),
                            .clear
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .frame(width: geometry.size.width * 2)
                    .offset(x: -geometry.size.width + phase * geometry.size.width * 2)
                }
                .mask(content)
            )
            .onAppear {
                withAnimation(.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                    phase = 1
                }
            }
    }
}

// MARK: - Animated Mesh Gradient
struct AnimatedMeshGradient: View {
    @State private var animate = false
    let colors: [Color]

    init(colors: [Color] = DesignSystem.Gradient.ocean) {
        self.colors = colors
    }

    var body: some View {
        if #available(iOS 18.0, *) {
            MeshGradient(
                width: 3,
                height: 3,
                points: [
                    [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
                    [0.0, 0.5], [animate ? 0.6 : 0.4, 0.5], [1.0, 0.5],
                    [0.0, 1.0], [0.5, 1.0], [1.0, 1.0]
                ],
                colors: meshColors
            )
            .onAppear {
                withAnimation(.easeInOut(duration: 4).repeatForever(autoreverses: true)) {
                    animate = true
                }
            }
            .ignoresSafeArea()
        } else {
            // Fallback for iOS 17
            LinearGradient(
                colors: colors,
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
        }
    }

    private var meshColors: [Color] {
        guard colors.count >= 3 else {
            return Array(repeating: .blue, count: 9)
        }
        return [
            colors[0], colors[1], colors[2],
            colors[1], colors[2], colors[0],
            colors[2], colors[0], colors[1]
        ]
    }
}

// MARK: - Breathing Animation
struct BreathingModifier: ViewModifier {
    @State private var isBreathing = false
    let intensity: CGFloat

    init(intensity: CGFloat = 0.03) {
        self.intensity = intensity
    }

    func body(content: Content) -> some View {
        content
            .scaleEffect(isBreathing ? 1 + intensity : 1 - intensity)
            .animation(
                .easeInOut(duration: 2).repeatForever(autoreverses: true),
                value: isBreathing
            )
            .onAppear {
                isBreathing = true
            }
    }
}

extension View {
    func breathing(intensity: CGFloat = 0.03) -> some View {
        modifier(BreathingModifier(intensity: intensity))
    }
}
