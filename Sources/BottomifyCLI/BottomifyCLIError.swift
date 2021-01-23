import Foundation

typealias BottomifyCLIResult<T> = Result<T, BottomifyCLIError>

enum BottomifyCLIError: LocalizedError {
    case translationError
    case fileIOError(filename: String)
    
    var errorDescription: String? {
        switch self {
        case .translationError:
            return NSLocalizedString("Either input text or the --input options must be provided.", comment: "")
        case .fileIOError(let filename):
            return NSLocalizedString("Could not operate on file \(filename).", comment: "")
        }
    }
}
