import Foundation

// MARK: - Mock Firebase Service (用于开发阶段，避免Firebase依赖)
// 当需要真实Firebase功能时，请参考 FIREBASE_SETUP.md
@MainActor
class FirebaseService: ObservableObject {
    @Published var isAuthenticated = false
    @Published var currentUser: MockUser?
    
    func signInAnonymously() async throws {
        // 模拟异步操作
        try await Task.sleep(nanoseconds: 1_000_000_000)
        currentUser = MockUser(uid: "mock-user-id")
        isAuthenticated = true
    }
    
    func signOut() throws {
        currentUser = nil
        isAuthenticated = false
    }
    
    func saveIngredient(_ ingredient: Ingredient) async throws {
        // 模拟保存操作
        try await Task.sleep(nanoseconds: 500_000_000)
        print("模拟保存食材到Firebase: \(ingredient.name)")
    }
    
    func loadIngredients() async throws -> [Ingredient] {
        // 模拟加载操作
        try await Task.sleep(nanoseconds: 500_000_000)
        return [] // 返回空数组，使用本地数据
    }
    
    func deleteIngredient(_ ingredient: Ingredient) async throws {
        // 模拟删除操作
        try await Task.sleep(nanoseconds: 500_000_000)
        print("模拟从Firebase删除食材: \(ingredient.name)")
    }
    
    func loadRecipes() async throws -> [Recipe] {
        // 模拟加载操作
        try await Task.sleep(nanoseconds: 500_000_000)
        return [] // 返回空数组，使用本地数据
    }
    
    func saveRecipe(_ recipe: Recipe) async throws {
        // 模拟保存操作
        try await Task.sleep(nanoseconds: 500_000_000)
        print("模拟保存菜谱到Firebase: \(recipe.name)")
    }
    
    func saveUserPreferences(_ preferences: UserPreferences) async throws {
        // 模拟保存操作
        try await Task.sleep(nanoseconds: 500_000_000)
        print("模拟保存用户偏好到Firebase")
    }
    
    func loadUserPreferences() async throws -> UserPreferences? {
        // 模拟加载操作
        try await Task.sleep(nanoseconds: 500_000_000)
        return nil
    }
}

// MARK: - Mock User for development
struct MockUser {
    let uid: String
}

enum FirebaseError: Error, LocalizedError {
    case notAuthenticated
    case dataCorrupted
    case networkError
    
    var errorDescription: String? {
        switch self {
        case .notAuthenticated:
            return "用户未登录"
        case .dataCorrupted:
            return "数据格式错误"
        case .networkError:
            return "网络连接错误"
        }
    }
}

// MARK: - Extensions for Codable to Dictionary conversion
extension Ingredient {
    func toDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        let json = try JSONSerialization.jsonObject(with: data)
        return json as? [String: Any] ?? [:]
    }
    
    static func fromDictionary(_ dict: [String: Any]) throws -> Ingredient {
        let data = try JSONSerialization.data(withJSONObject: dict)
        return try JSONDecoder().decode(Ingredient.self, from: data)
    }
}

extension Recipe {
    func toDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        let json = try JSONSerialization.jsonObject(with: data)
        return json as? [String: Any] ?? [:]
    }
    
    static func fromDictionary(_ dict: [String: Any], id: String? = nil) throws -> Recipe {
        let data = try JSONSerialization.data(withJSONObject: dict)
        var recipe = try JSONDecoder().decode(Recipe.self, from: data)
        if let id = id, let uuid = UUID(uuidString: id) {
            recipe.id = uuid
        }
        return recipe
    }
}