import Foundation

public extension String {
    private static let sectionSeparator = "👉👈"
    
    func encodeCharacter(_ charValue: UInt32) -> String {
        if charValue == .zero { return .init() }
        let currentCase = BottomifyCharacter.allCases.first { charValue >= $0.rawValue } ?? .default
        return "\(currentCase.emoji.rawValue)\(encodeCharacter(charValue - currentCase.rawValue))"
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
            .map { letters throws -> [BottomifyCharacter.Emoji] in
                try letters.map { character throws -> BottomifyCharacter.Emoji in
                    guard let emoji = BottomifyCharacter.Emoji(rawValue: character) else {
                        throw BottomifyTranslationError.incorrectlyEncoded(character: character)
                    }
                    return emoji
                }
            }.map { letters -> UInt32 in
                letters.map { BottomifyCharacter(from: $0).rawValue }.reduce(.zero, +)
            }.map { letter -> Unicode.Scalar in
                guard let scalar = Unicode.Scalar(letter) else {
                    throw BottomifyTranslationError.invalidUnicode(sequence: letter)
                }
                return scalar
            }.map { String($0) }.joined()
    }
    
    init?(regressingCharactersIn bottomifiedString: String) {
        guard let result = try? bottomifiedString.regressed() else { return nil }
        self = result
    }
}
