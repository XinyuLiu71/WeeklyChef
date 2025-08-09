import Foundation
import SwiftUI

@MainActor
class DataManager: ObservableObject {
    @Published var ingredients: [Ingredient] = []
    @Published var recipes: [Recipe] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isOnline = true
    
    private let firebaseService = FirebaseService()
    private let localStorageKey = "savedIngredients"
    
    init() {
        Task {
            await initialize()
        }
    }
    
    // MARK: - Initialization
    
    private func initialize() async {
        isLoading = true
        
        do {
            // 尝试匿名登录Firebase
            try await firebaseService.signInAnonymously()
            await loadDataFromFirebase()
            isOnline = true
        } catch {
            print("Firebase初始化失败，使用本地数据: \(error)")
            isOnline = false
            loadLocalData()
        }
        
        isLoading = false
    }
    
    // MARK: - Data Loading
    
    private func loadDataFromFirebase() async {
        do {
            // 加载食材
            let firebaseIngredients = try await firebaseService.loadIngredients()
            ingredients = firebaseIngredients
            
            // 加载菜谱
            let firebaseRecipes = try await firebaseService.loadRecipes()
            recipes = firebaseRecipes.isEmpty ? ExtendedRecipeData.allRecipes : firebaseRecipes
            
            // 同步到本地
            saveIngredientsLocally()
        } catch {
            errorMessage = "云端数据加载失败: \(error.localizedDescription)"
            loadLocalData()
        }
    }
    
    private func loadLocalData() {
        loadIngredientsLocally()
        recipes = ExtendedRecipeData.allRecipes
    }
    
    // MARK: - Ingredients Management
    
    func addIngredient(_ ingredient: Ingredient) {
        ingredients.append(ingredient)
        saveIngredient(ingredient)
    }
    
    func removeIngredient(_ ingredient: Ingredient) {
        ingredients.removeAll { $0.id == ingredient.id }
        deleteIngredient(ingredient)
    }
    
    func updateIngredient(_ ingredient: Ingredient) {
        if let index = ingredients.firstIndex(where: { $0.id == ingredient.id }) {
            ingredients[index] = ingredient
            saveIngredient(ingredient)
        }
    }
    
    private func saveIngredient(_ ingredient: Ingredient) {
        // 本地保存
        saveIngredientsLocally()
        
        // 云端保存
        if isOnline {
            Task {
                do {
                    try await firebaseService.saveIngredient(ingredient)
                } catch {
                    errorMessage = "云端保存失败: \(error.localizedDescription)"
                }
            }
        }
    }
    
    private func deleteIngredient(_ ingredient: Ingredient) {
        // 本地删除
        saveIngredientsLocally()
        
        // 云端删除
        if isOnline {
            Task {
                do {
                    try await firebaseService.deleteIngredient(ingredient)
                } catch {
                    errorMessage = "云端删除失败: \(error.localizedDescription)"
                }
            }
        }
    }
    
    func getIngredientsByCategory(_ category: IngredientCategory) -> [Ingredient] {
        return ingredients.filter { $0.category == category }
    }
    
    func getExpiringIngredients() -> [Ingredient] {
        return ingredients.filter { ingredient in
            guard let daysUntilExpiration = ingredient.daysUntilExpiration else { return false }
            return daysUntilExpiration <= 3 && daysUntilExpiration >= 0
        }
    }
    
    // MARK: - Recipe Management
    
    func getRecipesForIngredients(_ availableIngredients: [Ingredient]) -> [Recipe] {
        return recipes.filter { recipe in
            let requiredIngredients = recipe.ingredients.filter { !$0.isOptional }
            let availableIngredientNames = availableIngredients.map { $0.name.lowercased() }
            
            let matchingIngredients = requiredIngredients.filter { required in
                availableIngredientNames.contains { available in
                    available.contains(required.name.lowercased()) || 
                    required.name.lowercased().contains(available)
                }
            }
            
            // 如果匹配的食材数量超过所需食材的70%，就推荐这个菜谱
            return Double(matchingIngredients.count) / Double(requiredIngredients.count) >= 0.7
        }
    }
    
    func likeRecipe(_ recipe: Recipe) {
        if let index = recipes.firstIndex(where: { $0.id == recipe.id }) {
            recipes[index].likes += 1
            
            if isOnline {
                Task {
                    do {
                        try await firebaseService.saveRecipe(recipes[index])
                    } catch {
                        errorMessage = "菜谱更新失败: \(error.localizedDescription)"
                    }
                }
            }
        }
    }
    
    // MARK: - Local Data Persistence
    
    private func saveIngredientsLocally() {
        if let encoded = try? JSONEncoder().encode(ingredients) {
            UserDefaults.standard.set(encoded, forKey: localStorageKey)
        }
    }
    
    private func loadIngredientsLocally() {
        if let data = UserDefaults.standard.data(forKey: localStorageKey),
           let decoded = try? JSONDecoder().decode([Ingredient].self, from: data) {
            ingredients = decoded
        } else {
            // 如果没有本地数据，加载示例数据
            ingredients = TestData.sampleIngredients
        }
    }
    
    // MARK: - Sync Methods
    
    func syncWithFirebase() async {
        guard isOnline else { return }
        
        isLoading = true
        do {
            // 上传本地数据到Firebase
            for ingredient in ingredients {
                try await firebaseService.saveIngredient(ingredient)
            }
            
            // 从 Firebase 加载数据
            await loadDataFromFirebase()
            
            errorMessage = nil
        } catch {
            errorMessage = "同步失败: \(error.localizedDescription)"
        }
        isLoading = false
    }
    
    func retryConnection() async {
        await initialize()
    }
}