import SwiftUI

struct RecommendationsView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var selectedFilter: RecommendationFilter = .all
    
    enum RecommendationFilter: String, CaseIterable {
        case all = "全部"
        case canMake = "可立即制作"
        case needFew = "差1-2种食材"
        case needMore = "差更多食材"
    }
    
    var recommendedRecipes: [Recipe] {
        let recipes = dataManager.getRecipesForIngredients(dataManager.ingredients)
        
        switch selectedFilter {
        case .all:
            return recipes
        case .canMake:
            return recipes.filter { recipe in
                let requiredIngredients = recipe.ingredients.filter { !$0.isOptional }
                let availableIngredientNames = dataManager.ingredients.map { $0.name.lowercased() }
                let matchingIngredients = requiredIngredients.filter { required in
                    availableIngredientNames.contains { available in
                        available.contains(required.name.lowercased()) || 
                        required.name.lowercased().contains(available)
                    }
                }
                return Double(matchingIngredients.count) / Double(requiredIngredients.count) >= 0.9
            }
        case .needFew:
            return recipes.filter { recipe in
                let requiredIngredients = recipe.ingredients.filter { !$0.isOptional }
                let availableIngredientNames = dataManager.ingredients.map { $0.name.lowercased() }
                let matchingIngredients = requiredIngredients.filter { required in
                    availableIngredientNames.contains { available in
                        available.contains(required.name.lowercased()) || 
                        required.name.lowercased().contains(available)
                    }
                }
                let missingCount = requiredIngredients.count - matchingIngredients.count
                return missingCount >= 1 && missingCount <= 2
            }
        case .needMore:
            return recipes.filter { recipe in
                let requiredIngredients = recipe.ingredients.filter { !$0.isOptional }
                let availableIngredientNames = dataManager.ingredients.map { $0.name.lowercased() }
                let matchingIngredients = requiredIngredients.filter { required in
                    availableIngredientNames.contains { available in
                        available.contains(required.name.lowercased()) || 
                        required.name.lowercased().contains(available)
                    }
                }
                let missingCount = requiredIngredients.count - matchingIngredients.count
                return missingCount > 2
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // 筛选器
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(RecommendationFilter.allCases, id: \.self) { filter in
                            CategoryFilterButton(
                                title: filter.rawValue,
                                isSelected: selectedFilter == filter
                            ) {
                                selectedFilter = filter
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical, 8)
                
                if dataManager.ingredients.isEmpty {
                    // 空状态
                    VStack(spacing: 20) {
                        Image(systemName: "refrigerator")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                        
                        Text("冰箱是空的")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text("添加一些食材到冰箱中，我们就能为你推荐合适的菜谱了")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        
                        NavigationLink(destination: AddIngredientView()) {
                            Text("添加食材")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(12)
                        }
                    }
                    .padding()
                } else if recommendedRecipes.isEmpty {
                    // 没有推荐
                    VStack(spacing: 20) {
                        Image(systemName: "lightbulb")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                        
                        Text("暂无推荐")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text("根据你冰箱中的食材，暂时没有找到合适的菜谱推荐")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .padding()
                } else {
                    // 推荐列表
                    List(recommendedRecipes) { recipe in
                        NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                            RecommendedRecipeRow(
                                recipe: recipe,
                                availableIngredients: dataManager.ingredients
                            )
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("智能推荐")
        }
    }
}

struct RecommendedRecipeRow: View {
    let recipe: Recipe
    let availableIngredients: [Ingredient]
    
    var matchingPercentage: Double {
        let requiredIngredients = recipe.ingredients.filter { !$0.isOptional }
        let availableIngredientNames = availableIngredients.map { $0.name.lowercased() }
        
        let matchingIngredients = requiredIngredients.filter { required in
            availableIngredientNames.contains { available in
                available.contains(required.name.lowercased()) || 
                required.name.lowercased().contains(available)
            }
        }
        
        return Double(matchingIngredients.count) / Double(requiredIngredients.count)
    }
    
    var missingIngredients: [RecipeIngredient] {
        let requiredIngredients = recipe.ingredients.filter { !$0.isOptional }
        let availableIngredientNames = availableIngredients.map { $0.name.lowercased() }
        
        return requiredIngredients.filter { required in
            !availableIngredientNames.contains { available in
                available.contains(required.name.lowercased()) || 
                required.name.lowercased().contains(available)
            }
        }
    }
    
    var body: some View {
        HStack(spacing: 12) {
            // 匹配度指示器
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.3), lineWidth: 4)
                    .frame(width: 50, height: 50)
                
                Circle()
                    .trim(from: 0, to: matchingPercentage)
                    .stroke(matchingPercentageColor, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                    .frame(width: 50, height: 50)
                    .rotationEffect(.degrees(-90))
                
                Text("\(Int(matchingPercentage * 100))%")
                    .font(.caption)
                    .fontWeight(.bold)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(recipe.name)
                    .font(.headline)
                    .lineLimit(1)
                
                Text(recipe.description)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                
                if !missingIngredients.isEmpty {
                    Text("缺少: \(missingIngredients.prefix(2).map { $0.name }.joined(separator: ", "))")
                        .font(.caption)
                        .foregroundColor(.orange)
                }
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text("\(recipe.cookingTime)分钟")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Text(recipe.difficulty.rawValue)
                    .font(.caption)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(difficultyColor.opacity(0.2))
                    .foregroundColor(difficultyColor)
                    .cornerRadius(4)
            }
        }
        .padding(.vertical, 4)
    }
    
    private var matchingPercentageColor: Color {
        if matchingPercentage >= 0.9 {
            return .green
        } else if matchingPercentage >= 0.7 {
            return .orange
        } else {
            return .red
        }
    }
    
    private var difficultyColor: Color {
        switch recipe.difficulty {
        case .easy: return .green
        case .medium: return .orange
        case .hard: return .red
        }
    }
}

#Preview {
    RecommendationsView()
        .environmentObject(DataManager())
} 