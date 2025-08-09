import SwiftUI

struct FridgeView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var showingAddIngredient = false
    
    private var toolbarPlacement: ToolbarItemPlacement {
        #if os(iOS)
        return .navigationBarTrailing
        #else
        return .automatic
        #endif
    }
    @State private var selectedCategory: IngredientCategory?
    
    var body: some View {
        NavigationView {
            List {
                // 过期提醒
                if !dataManager.getExpiringIngredients().isEmpty {
                    Section("即将过期") {
                        ForEach(dataManager.getExpiringIngredients()) { ingredient in
                            ExpiringIngredientRow(ingredient: ingredient)
                        }
                    }
                }
                
                // 按分类显示食材
                ForEach(IngredientCategory.allCases, id: \.self) { category in
                    Section(category.rawValue) {
                        let categoryIngredients = dataManager.getIngredientsByCategory(category)
                        if categoryIngredients.isEmpty {
                            Text("暂无食材")
                                .foregroundColor(.secondary)
                                .italic()
                        } else {
                            ForEach(categoryIngredients) { ingredient in
                                IngredientRow(ingredient: ingredient)
                            }
                            .onDelete { indexSet in
                                for index in indexSet {
                                    dataManager.removeIngredient(categoryIngredients[index])
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("我的冰箱")
            .toolbar {
                ToolbarItem(placement: toolbarPlacement) {
                    Button(action: {
                        showingAddIngredient = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddIngredient) {
                AddIngredientView()
            }
        }
    }
}

struct IngredientRow: View {
    let ingredient: Ingredient
    
    var body: some View {
        HStack {
            Image(systemName: ingredient.category.icon)
                .foregroundColor(.blue)
                .frame(width: 30)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(ingredient.name)
                    .font(.headline)
                Text("\(ingredient.quantity, specifier: "%.1f") \(ingredient.unit)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            if let daysUntilExpiration = ingredient.daysUntilExpiration {
                if daysUntilExpiration < 0 {
                    Text("已过期")
                        .font(.caption)
                        .foregroundColor(.red)
                } else if daysUntilExpiration <= 3 {
                    Text("\(daysUntilExpiration)天后过期")
                        .font(.caption)
                        .foregroundColor(.orange)
                } else {
                    Text("\(daysUntilExpiration)天后过期")
                        .font(.caption)
                        .foregroundColor(.green)
                }
            }
        }
        .padding(.vertical, 4)
    }
}

struct ExpiringIngredientRow: View {
    let ingredient: Ingredient
    
    var body: some View {
        HStack {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(.orange)
            
            Text(ingredient.name)
                .font(.headline)
            
            Spacer()
            
            if let daysUntilExpiration = ingredient.daysUntilExpiration {
                Text("\(daysUntilExpiration)天后过期")
                    .font(.caption)
                    .foregroundColor(.orange)
            }
        }
    }
}

#Preview {
    FridgeView()
        .environmentObject(DataManager())
} 