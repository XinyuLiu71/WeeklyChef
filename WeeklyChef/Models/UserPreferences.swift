import Foundation

struct UserPreferences: Codable {
    var dietaryRestrictions: [DietaryRestriction]
    var preferredCuisines: [RecipeCategory]
    var skillLevel: CookingSkillLevel
    var maxCookingTime: Int // 分钟
    var budgetRange: BudgetRange
    var allergies: [String]
    var favoriteIngredients: [String]
    var dislikedIngredients: [String]
    
    init() {
        self.dietaryRestrictions = []
        self.preferredCuisines = [.chinese, .quick]
        self.skillLevel = .beginner
        self.maxCookingTime = 30
        self.budgetRange = .medium
        self.allergies = []
        self.favoriteIngredients = []
        self.dislikedIngredients = []
    }
}

enum DietaryRestriction: String, CaseIterable, Codable {
    case vegetarian = "素食主义者"
    case vegan = "纯素食者"
    case glutenFree = "无麸质"
    case lactoseFree = "无乳糖"
    case lowSodium = "低钠"
    case lowFat = "低脂"
    case diabetic = "糖尿病饮食"
    case halal = "清真"
    case kosher = "犹太洁食"
}

enum CookingSkillLevel: String, CaseIterable, Codable {
    case beginner = "新手"
    case intermediate = "中级"
    case advanced = "高级"
    
    var maxDifficulty: Difficulty {
        switch self {
        case .beginner: return .easy
        case .intermediate: return .medium
        case .advanced: return .hard
        }
    }
}

enum BudgetRange: String, CaseIterable, Codable {
    case low = "经济型（<$10/餐）"
    case medium = "中等（$10-20/餐）"
    case high = "较高（>$20/餐）"
    
    var maxCost: Double {
        switch self {
        case .low: return 10.0
        case .medium: return 20.0
        case .high: return 50.0
        }
    }
}

// MARK: - Dictionary conversion
extension UserPreferences {
    func toDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        let json = try JSONSerialization.jsonObject(with: data)
        return json as? [String: Any] ?? [:]
    }
    
    static func fromDictionary(_ dict: [String: Any]) throws -> UserPreferences {
        let data = try JSONSerialization.data(withJSONObject: dict)
        return try JSONDecoder().decode(UserPreferences.self, from: data)
    }
}