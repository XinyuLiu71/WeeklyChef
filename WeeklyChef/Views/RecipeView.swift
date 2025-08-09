import SwiftUI

struct RecipeView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var selectedCategory: RecipeCategory?
    @State private var searchText = ""
    
    var filteredRecipes: [Recipe] {
        var recipes = dataManager.recipes
        
        if let selectedCategory = selectedCategory {
            recipes = recipes.filter { $0.category == selectedCategory }
        }
        
        if !searchText.isEmpty {
            recipes = recipes.filter { recipe in
                recipe.name.localizedCaseInsensitiveContains(searchText) ||
                recipe.description.localizedCaseInsensitiveContains(searchText) ||
                recipe.tags.contains { $0.localizedCaseInsensitiveContains(searchText) }
            }
        }
        
        return recipes
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // 分类筛选
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        CategoryFilterButton(
                            title: "全部",
                            isSelected: selectedCategory == nil
                        ) {
                            selectedCategory = nil
                        }
                        
                        ForEach(RecipeCategory.allCases, id: \.self) { category in
                            CategoryFilterButton(
                                title: category.rawValue,
                                isSelected: selectedCategory == category
                            ) {
                                selectedCategory = category
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical, 8)
                
                // 菜谱列表
                List(filteredRecipes) { recipe in
                    NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                        RecipeRow(recipe: recipe)
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("菜谱")
            .searchable(text: $searchText, prompt: "搜索菜谱")
        }
    }
}

struct RecipeRow: View {
    let recipe: Recipe
    
    var body: some View {
        HStack(spacing: 12) {
            // 菜谱图标
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.blue.opacity(0.1))
                    .frame(width: 60, height: 60)
                
                Image(systemName: recipe.category.icon)
                    .font(.title2)
                    .foregroundColor(.blue)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(recipe.name)
                    .font(.headline)
                    .lineLimit(1)
                
                Text(recipe.description)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                
                HStack(spacing: 8) {
                    Label("\(recipe.cookingTime)分钟", systemImage: "clock")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Label(recipe.difficulty.rawValue, systemImage: "star.fill")
                        .font(.caption)
                        .foregroundColor(difficultyColor)
                }
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text("$\(recipe.estimatedCost, specifier: "%.1f")")
                    .font(.caption)
                    .foregroundColor(.green)
                
                Text("\(recipe.totalIngredients)种食材")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
    
    private var difficultyColor: Color {
        switch recipe.difficulty {
        case .easy: return .green
        case .medium: return .orange
        case .hard: return .red
        }
    }
}

struct CategoryFilterButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.caption)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(isSelected ? Color.blue : Color.gray.opacity(0.2))
                .foregroundColor(isSelected ? .white : .primary)
                .cornerRadius(16)
        }
    }
}

#Preview {
    RecipeView()
        .environmentObject(DataManager())
} 