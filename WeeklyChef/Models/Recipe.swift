import Foundation

struct Recipe: Identifiable, Codable {
    var id: UUID = UUID()
    var name: String
    var description: String
    var ingredients: [RecipeIngredient]
    var instructions: [String]
    var cookingTime: Int // 分钟
    var difficulty: Difficulty
    var category: RecipeCategory
    var imageURL: String?
    var tags: [String]
    var authorId: String? // Firebase用户ID
    var createdAt: Date
    var updatedAt: Date
    var likes: Int
    var nutritionInfo: NutritionInfo?
    
    var totalIngredients: Int {
        return ingredients.count
    }
    
    var estimatedCost: Double {
        return ingredients.reduce(0) { $0 + $1.estimatedCost }
    }
    
    // 初始化方法，用于向后兼容
    init(id: UUID = UUID(), name: String, description: String, ingredients: [RecipeIngredient], instructions: [String], cookingTime: Int, difficulty: Difficulty, category: RecipeCategory, imageURL: String? = nil, tags: [String], authorId: String? = nil, createdAt: Date = Date(), updatedAt: Date = Date(), likes: Int = 0, nutritionInfo: NutritionInfo? = nil) {
        self.id = id
        self.name = name
        self.description = description
        self.ingredients = ingredients
        self.instructions = instructions
        self.cookingTime = cookingTime
        self.difficulty = difficulty
        self.category = category
        self.imageURL = imageURL
        self.tags = tags
        self.authorId = authorId
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.likes = likes
        self.nutritionInfo = nutritionInfo
    }
}

struct RecipeIngredient: Identifiable, Codable {
    var id: UUID = UUID()
    var name: String
    var quantity: Double
    var unit: String
    var estimatedCost: Double
    var isOptional: Bool = false
}

enum Difficulty: String, CaseIterable, Codable {
    case easy = "简单"
    case medium = "中等"
    case hard = "困难"
    
    var color: String {
        switch self {
        case .easy: return "green"
        case .medium: return "orange"
        case .hard: return "red"
        }
    }
}

enum RecipeCategory: String, CaseIterable, Codable {
    case chinese = "中餐"
    case western = "西餐"
    case quick = "快手菜"
    case healthy = "健康餐"
    case breakfast = "早餐"
    case lunch = "午餐"
    case dinner = "晚餐"
    case snack = "小食"
    
    var icon: String {
        switch self {
        case .chinese: return "fork.knife"
        case .western: return "birthday.cake"
        case .quick: return "bolt.fill"
        case .healthy: return "heart.fill"
        case .breakfast: return "sunrise.fill"
        case .lunch: return "sun.max.fill"
        case .dinner: return "moon.fill"
        case .snack: return "star.fill"
        }
    }
}

// MARK: - Nutrition Info
struct NutritionInfo: Codable {
    var calories: Double
    var protein: Double // 克
    var carbohydrates: Double // 克
    var fat: Double // 克
    var fiber: Double // 克
    var sugar: Double // 克
    var sodium: Double // 毫克
    
    init(calories: Double = 0, protein: Double = 0, carbohydrates: Double = 0, fat: Double = 0, fiber: Double = 0, sugar: Double = 0, sodium: Double = 0) {
        self.calories = calories
        self.protein = protein
        self.carbohydrates = carbohydrates
        self.fat = fat
        self.fiber = fiber
        self.sugar = sugar
        self.sodium = sodium
    }
} 