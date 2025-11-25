import SwiftUI
import SFSymbols

/// A toast notification view
struct ToastView: View {
    let message: String
    let icon: SFSymbol

    var body: some View {
        HStack(spacing: 12) {
            Image(symbol: icon)
                .foregroundStyle(.white)

            Text(message)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundStyle(.white)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 14)
        .background(
            Capsule()
                .fill(Color(.systemGray))
        )
        .shadow(color: .black.opacity(0.15), radius: 10, y: 5)
        .padding(.bottom, 20)
    }
}

// MARK: - Success Toast
struct SuccessToast: View {
    let message: String

    var body: some View {
        ToastView(message: message, icon: .checkmarkCircleFill)
    }
}

// MARK: - Error Toast
struct ErrorToast: View {
    let message: String

    var body: some View {
        HStack(spacing: 12) {
            Image(symbol: .exclamationmarkCircleFill)
                .foregroundStyle(.white)

            Text(message)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundStyle(.white)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 14)
        .background(
            Capsule()
                .fill(Color.red)
        )
        .shadow(color: .black.opacity(0.15), radius: 10, y: 5)
        .padding(.bottom, 20)
    }
}

// MARK: - Toast Modifier
struct ToastModifier: ViewModifier {
    @Binding var isShowing: Bool
    let message: String
    let icon: SFSymbol
    var duration: TimeInterval = 2.0

    func body(content: Content) -> some View {
        content
            .overlay(alignment: .bottom) {
                if isShowing {
                    ToastView(message: message, icon: icon)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                        .onAppear {
                            Task {
                                try? await Task.sleep(nanoseconds: UInt64(duration * 1_000_000_000))
                                withAnimation {
                                    isShowing = false
                                }
                            }
                        }
                }
            }
            .animation(.spring(response: 0.3), value: isShowing)
    }
}

extension View {
    func toast(isShowing: Binding<Bool>, message: String, icon: SFSymbol = .checkmarkCircleFill, duration: TimeInterval = 2.0) -> some View {
        modifier(ToastModifier(isShowing: isShowing, message: message, icon: icon, duration: duration))
    }
}

#Preview {
    VStack {
        ToastView(message: "Copied to clipboard", icon: .docOnDoc)
        SuccessToast(message: "Export complete")
        ErrorToast(message: "Something went wrong")
    }
    .padding()
}
