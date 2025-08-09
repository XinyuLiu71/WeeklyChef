import SwiftUI

struct AddIngredientView: View {
    @EnvironmentObject var dataManager: DataManager
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var quantity = 1.0
    @State private var unit = "个"
    @State private var category = IngredientCategory.vegetables
    @State private var purchaseDate = Date()
    @State private var expirationDate = Date().addingTimeInterval(7 * 24 * 60 * 60) // 默认7天后过期
    @State private var hasExpirationDate = true
    
    let units = ["个", "克", "千克", "包", "瓶", "罐", "袋", "盒", "片", "瓣", "根", "把", "勺", "茶匙", "汤匙"]
    
    private var leadingPlacement: ToolbarItemPlacement {
        #if os(iOS)
        return .navigationBarLeading
        #else
        return .automatic
        #endif
    }
    
    private var trailingPlacement: ToolbarItemPlacement {
        #if os(iOS)
        return .navigationBarTrailing
        #else
        return .automatic
        #endif
    }
    
    var body: some View {
        NavigationView {
            Form {
                VStack(spacing: 16) {
                    TextField("食材名称", text: $name)
                    
                    HStack {
                        Text("数量")
                        Spacer()
                        TextField("数量", value: $quantity, format: .number)
                            #if os(iOS)
                            .keyboardType(.decimalPad)
                            #endif
                            .multilineTextAlignment(.trailing)
                    }
                    
                    Picker("单位", selection: $unit) {
                        ForEach(units, id: \.self) { unit in
                            Text(unit).tag(unit)
                        }
                    }
                    
                    Picker("分类", selection: $category) {
                        ForEach(IngredientCategory.allCases, id: \.self) { category in
                            HStack {
                                Image(systemName: category.icon)
                                Text(category.rawValue)
                            }
                            .tag(category)
                        }
                    }
                    
                    DatePicker("购买日期", selection: $purchaseDate, displayedComponents: .date)
                    
                    Toggle("设置过期日期", isOn: $hasExpirationDate)
                    
                    if hasExpirationDate {
                        DatePicker("过期日期", selection: $expirationDate, displayedComponents: .date)
                    }
                }
                .padding()
            }
            .navigationTitle("添加食材")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                ToolbarItem(placement: leadingPlacement) {
                    Button("取消") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: trailingPlacement) {
                    Button("保存") {
                        saveIngredient()
                    }
                    .disabled(name.isEmpty)
                }
            }
        }
    }
    
    private func saveIngredient() {
        let ingredient = Ingredient(
            name: name,
            quantity: quantity,
            unit: unit,
            category: category,
            purchaseDate: purchaseDate,
            expirationDate: hasExpirationDate ? expirationDate : nil
        )
        
        dataManager.addIngredient(ingredient)
        dismiss()
    }
}

#Preview {
    AddIngredientView()
        .environmentObject(DataManager())
} 