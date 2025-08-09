import Foundation

struct Ingredient: Identifiable, Codable {
    var id: UUID = UUID()
    var name: String
    var quantity: Double
    var unit: String
    var category: IngredientCategory
    var purchaseDate: Date
    var expirationDate: Date?
    var isExpired: Bool {
        guard let expirationDate = expirationDate else { return false }
        return Date() > expirationDate
    }
    var daysUntilExpiration: Int? {
        guard let expirationDate = expirationDate else { return nil }
        let calendar = Calendar.current
        return calendar.dateComponents([.day], from: Date(), to: expirationDate).day
    }
}

enum IngredientCategory: String, CaseIterable, Codable {
    case vegetables = "蔬菜"
    case fruits = "水果"
    case meat = "肉类"
    case seafood = "海鲜"
    case dairy = "乳制品"
    case grains = "主食"
    case condiments = "调料"
    case snacks = "零食"
    case beverages = "饮料"
    case other = "其他"
    
    var icon: String {
        switch self {
        case .vegetables: return "leaf.fill"
        case .fruits: return "applelogo"
        case .meat: return "flame.fill"
        case .seafood: return "fish.fill"
        case .dairy: return "drop.fill"
        case .grains: return "circle.fill"
        case .condiments: return "sparkles"
        case .snacks: return "star.fill"
        case .beverages: return "cup.and.saucer.fill"
        case .other: return "questionmark.circle.fill"
        }
    }
} 