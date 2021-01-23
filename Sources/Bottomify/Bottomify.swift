import Foundation

enum TranslationError: LocalizedError {
    case incorrectlyEncoded(_ str: String)

    var errorDescription: String? {
    switch self {
        case .incorrectlyEncoded(let str):
            return NSLocalizedString("Cannot decode character \(str).", comment: "")
      }
    }
}

enum BottomEmoji: String, CaseIterable {
    case hug = "🫂"
    case sparkleHearts = "💖"
    case sparkles = "✨"
    case pleadingFace = "🥺"
    case comma = ","
    case heart = "❤️"

    static let `default` = Self.heart
}

enum BottomCharacter: UInt32, CaseIterable {
    case hug = 200
    case sparkleHearts = 50
    case sparkles = 10
    case pleadingFace = 5
    case comma = 1
    case heart = 0

    var emoji: BottomEmoji {
        switch self {
            case .hug:
                return .hug
            case .sparkleHearts:
                return .sparkleHearts
            case .sparkles:
                return .sparkles
            case .pleadingFace:
                return .pleadingFace
            case .comma:
                return .comma // although this is not an emoji
            case .heart:
                return .heart
        }
    }

    init(from emoji: BottomEmoji) {
        switch emoji {
            case .hug:
                self = .hug
            case .sparkleHearts:
                self = .sparkleHearts
            case .sparkles:
                self = .sparkles
            case .pleadingFace:
                self = .pleadingFace
            case .comma:
                self = .comma
            case .heart:
                self = .heart
        }
    }

    static let `default` = Self.heart
}

public extension String {
    private static let sectionSeparator = "👉👈"

    func encodeCharacter(_ charValue: UInt32) -> String {
        if charValue == .zero { return .init() }
        let currentCase = BottomCharacter.allCases.first { charValue >= $0.rawValue } ?? .default
        return currentCase.emoji.rawValue + encodeCharacter(charValue - currentCase.rawValue)
    }

    func bottomified() -> String {
        unicodeScalars.compactMap { char -> String in
            encodeCharacter(char.value) + Self.sectionSeparator
        }.joined()
    }

    func regressed() throws -> String {
        try trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "\(Self.sectionSeparator)?$", with: Self(), options: .regularExpression)
            .components(separatedBy: Self.sectionSeparator)
            .map { letters throws -> [BottomEmoji] in
                try letters.map { value throws -> BottomEmoji in
                    guard let emoji = BottomEmoji(rawValue: String(value)) else {
                        throw TranslationError.incorrectlyEncoded(String(value))
                    }
                    return emoji
                }
            }.map { letters -> UInt32 in
                letters.reduce(.zero, { initial, bottomEmoji in initial + BottomCharacter(from: bottomEmoji).rawValue }) 
            }.map { letter -> Unicode.Scalar in
                Unicode.Scalar(letter)!
            }.map { String($0) }.joined()
    }
}
