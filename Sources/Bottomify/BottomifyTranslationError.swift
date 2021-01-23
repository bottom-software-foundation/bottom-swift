import Foundation

enum BottomifyTranslationError: LocalizedError {
    case incorrectlyEncoded(character: Character)
    case invalidUnicode(sequence: UInt32)
    
    var errorDescription: String? {
        switch self {
        case .incorrectlyEncoded(let character):
            return NSLocalizedString("Cannot decode character \(character).", comment: "")
        case .invalidUnicode(let sequence):
            return NSLocalizedString("Cannot decode unicode sequence \(sequence).", comment: "")
        }
    }
}
