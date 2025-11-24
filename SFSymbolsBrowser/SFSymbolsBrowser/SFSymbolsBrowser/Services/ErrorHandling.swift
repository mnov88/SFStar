import Foundation

/// Common errors used throughout the app
enum AppError: LocalizedError, Identifiable {
    case exportFailed(String)
    case saveFailed(String)
    case loadFailed(String)
    case invalidData
    case unknown(Error)

    var id: String {
        switch self {
        case .exportFailed: return "export"
        case .saveFailed: return "save"
        case .loadFailed: return "load"
        case .invalidData: return "invalid"
        case .unknown: return "unknown"
        }
    }

    var errorDescription: String? {
        switch self {
        case .exportFailed(let message):
            return "Export failed: \(message)"
        case .saveFailed(let message):
            return "Save failed: \(message)"
        case .loadFailed(let message):
            return "Load failed: \(message)"
        case .invalidData:
            return "Invalid data encountered"
        case .unknown(let error):
            return error.localizedDescription
        }
    }

    var recoverySuggestion: String? {
        switch self {
        case .exportFailed:
            return "Please try again or check your storage space."
        case .saveFailed:
            return "Make sure you have enough storage space and try again."
        case .loadFailed:
            return "Please restart the app and try again."
        case .invalidData:
            return "The data appears to be corrupted. Try clearing app data."
        case .unknown:
            return "Please try again. If the problem persists, contact support."
        }
    }
}

// MARK: - Result Extension
extension Result where Success == Void {
    static var success: Result<Void, Failure> {
        .success(())
    }
}

// MARK: - Error Handling Utilities
@MainActor
@Observable
final class ErrorHandler {
    var currentError: AppError?
    var isShowingError: Bool = false

    func handle(_ error: Error) {
        if let appError = error as? AppError {
            currentError = appError
        } else {
            currentError = .unknown(error)
        }
        isShowingError = true
    }

    func clear() {
        currentError = nil
        isShowingError = false
    }
}
