import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    @EnvironmentObject var dataManager: DataManager
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // 头部信息
                VStack(alignment: .leading, spacing: 8) {
                    Text(recipe.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text(recipe.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                    
                    // 标签
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(recipe.tags, id: \.self) { tag in
                                Text(tag)
                                    .font(.caption)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.blue.opacity(0.1))
                                    .foregroundColor(.blue)
                                    .cornerRadius(8)
                            }
                        }
                    }
                }
                .padding(.horizontal)
                
                // 基本信息卡片
                VStack(spacing: 16) {
                    HStack {
                        InfoCard(
                            icon: "clock",
                            title: "烹饪时间",
                            value: "\(recipe.cookingTime)分钟"
                        )
                        
                        InfoCard(
                            icon: "star.fill",
                            title: "难度",
                            value: recipe.difficulty.rawValue
                        )
                        
                        InfoCard(
                            icon: "dollarsign.circle",
                            title: "预估成本",
                            value: String(format: "$%.1f", recipe.estimatedCost)
                        )
                    }
                }
                .padding(.horizontal)
                
                // 营养信息卡片
                if let nutrition = recipe.nutritionInfo {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("营养信息")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                        
                        NutritionInfoCard(nutrition: nutrition)
                            .padding(.horizontal)
                    }
                }
                
                // 食材列表
                VStack(alignment: .leading, spacing: 12) {
                    Text("食材")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                    
                    VStack(spacing: 8) {
                        ForEach(recipe.ingredients) { ingredient in
                            IngredientDetailRow(
                                ingredient: ingredient,
                                isAvailable: isIngredientAvailable(ingredient)
                            )
                        }
                    }
                    .padding(.horizontal)
                }
                
                // 制作步骤
                VStack(alignment: .leading, spacing: 12) {
                    Text("制作步骤")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                    
                    VStack(spacing: 12) {
                        ForEach(Array(recipe.instructions.enumerated()), id: \.offset) { index, instruction in
                            StepRow(stepNumber: index + 1, instruction: instruction)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
        .navigationTitle("")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
    
    private func isIngredientAvailable(_ recipeIngredient: RecipeIngredient) -> Bool {
        return dataManager.ingredients.contains { ingredient in
            ingredient.name.lowercased().contains(recipeIngredient.name.lowercased()) ||
            recipeIngredient.name.lowercased().contains(ingredient.name.lowercased())
        }
    }
}

struct InfoCard: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.blue)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            
            Text(value)
                .font(.headline)
                .fontWeight(.semibold)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
}

struct IngredientDetailRow: View {
    let ingredient: RecipeIngredient
    let isAvailable: Bool
    
    var body: some View {
        HStack {
            Image(systemName: isAvailable ? "checkmark.circle.fill" : "circle")
                .foregroundColor(isAvailable ? .green : .gray)
            
            Text(ingredient.name)
                .font(.body)
            
            Spacer()
            
            Text(String(format: "%.1f %@", ingredient.quantity, ingredient.unit))
                .font(.body)
                .foregroundColor(.secondary)
            
            if ingredient.isOptional {
                Text("可选")
                    .font(.caption)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(Color.orange.opacity(0.2))
                    .foregroundColor(.orange)
                    .cornerRadius(4)
            }
        }
        .padding(.vertical, 4)
    }
}

struct StepRow: View {
    let stepNumber: Int
    let instruction: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            ZStack {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 24, height: 24)
                
                Text("\(stepNumber)")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            
            Text(instruction)
                .font(.body)
                .multilineTextAlignment(.leading)
            
            Spacer()
        }
    }
}

#Preview {
    NavigationView {
        RecipeDetailView(recipe: Recipe(
            name: "番茄炒蛋",
            description: "经典的家常菜，简单易做，营养丰富",
            ingredients: [
                RecipeIngredient(name: "番茄", quantity: 2, unit: "个", estimatedCost: 1.0),
                RecipeIngredient(name: "鸡蛋", quantity: 3, unit: "个", estimatedCost: 0.5)
            ],
            instructions: [
                "番茄洗净切块",
                "鸡蛋打散加盐",
                "热锅下油，炒散鸡蛋",
                "加入番茄翻炒",
                "加盐调味即可"
            ],
            cookingTime: 10,
            difficulty: .easy,
            category: .chinese,
            tags: ["快手菜", "家常菜", "素食"],
            nutritionInfo: NutritionInfo(calories: 180, protein: 12, carbohydrates: 8, fat: 12, fiber: 2, sugar: 6, sodium: 300)
        ))
        .environmentObject(DataManager())
    }
}

// MARK: - 营养信息卡片
struct NutritionInfoCard: View {
    let nutrition: NutritionInfo
    
    var body: some View {
        VStack(spacing: 16) {
            // 卡路里信息（突出显示）
            HStack {
                CalorieInfoCard(calories: nutrition.calories)
                Spacer()
            }
            
            // 主要营养素
            VStack(spacing: 12) {
                Text("主要营养素")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 12) {
                    NutritionItem(name: "蛋白质", value: nutrition.protein, unit: "g", color: .blue)
                    NutritionItem(name: "碳水化合物", value: nutrition.carbohydrates, unit: "g", color: .orange)
                    NutritionItem(name: "脂肪", value: nutrition.fat, unit: "g", color: .purple)
                    
                    if nutrition.fiber > 0 {
                        NutritionItem(name: "纤维", value: nutrition.fiber, unit: "g", color: .green)
                    }
                    
                    if nutrition.sugar > 0 {
                        NutritionItem(name: "糖分", value: nutrition.sugar, unit: "g", color: .red)
                    }
                    
                    if nutrition.sodium > 0 {
                        NutritionItem(name: "钠", value: nutrition.sodium, unit: "mg", color: .gray)
                    }
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

struct CalorieInfoCard: View {
    let calories: Double
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "flame.fill")
                .font(.title2)
                .foregroundColor(.orange)
            
            VStack(alignment: .leading, spacing: 2) {
                Text("总热量")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Text("\(Int(calories)) 千卡")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
            }
            
            Spacer()
        }
        .padding()
        .background(Color.orange.opacity(0.1))
        .cornerRadius(10)
    }
}

struct NutritionItem: View {
    let name: String
    let value: Double
    let unit: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Circle()
                    .fill(color)
                    .frame(width: 8, height: 8)
                
                Text(name)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
            }
            
            HStack {
                Text(String(format: "%.1f", value))
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Text(unit)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(color.opacity(0.05))
        .cornerRadius(8)
    }
} 