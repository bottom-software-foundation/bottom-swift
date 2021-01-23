import Foundation

enum BottomifyCharacter: UInt32, CaseIterable {
    enum Emoji: Character, CaseIterable {
        case hug = "🫂"
        case sparkleHearts = "💖"
        case sparkles = "✨"
        case pleadingFace = "🥺"
        case comma = ","
        case heart = "❤️"
        
        static let `default` = Self.heart
    }
    
    case hug = 200
    case sparkleHearts = 50
    case sparkles = 10
    case pleadingFace = 5
    case comma = 1
    case heart = 0
    
    var emoji: Emoji {
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
            return .comma
        case .heart:
            return .heart
        }
    }
    
    init(from emoji: Emoji) {
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
