import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var preferences = UserPreferences()
    @State private var showingSync = false
    @State private var syncMessage = ""
    
    private var toolbarPlacement: ToolbarItemPlacement {
        #if os(iOS)
        return .navigationBarTrailing
        #else
        return .automatic
        #endif
    }
    
    var body: some View {
        NavigationView {
            List {
                // 数据同步状态
                Section("数据同步") {
                    HStack {
                        Image(systemName: dataManager.isOnline ? "wifi" : "wifi.slash")
                            .foregroundColor(dataManager.isOnline ? .green : .red)
                        
                        Text(dataManager.isOnline ? "已连接云端" : "离线模式")
                        
                        Spacer()
                        
                        if dataManager.isLoading {
                            ProgressView()
                                .scaleEffect(0.7)
                        }
                    }
                    
                    if !dataManager.isOnline {
                        Button("重新连接") {
                            Task {
                                await dataManager.retryConnection()
                            }
                        }
                    }
                    
                    Button("手动同步") {
                        syncData()
                    }
                    .disabled(!dataManager.isOnline || dataManager.isLoading)
                }
                
                // 饮食偏好
                Section("饮食偏好") {
                    Picker("烹饪技能", selection: $preferences.skillLevel) {
                        ForEach(CookingSkillLevel.allCases, id: \.self) { level in
                            Text(level.rawValue).tag(level)
                        }
                    }
                    
                    Picker("预算范围", selection: $preferences.budgetRange) {
                        ForEach(BudgetRange.allCases, id: \.self) { range in
                            Text(range.rawValue).tag(range)
                        }
                    }
                    
                    HStack {
                        Text("最大烹饪时间")
                        Spacer()
                        Text("\(preferences.maxCookingTime)分钟")
                            .foregroundColor(.secondary)
                    }
                    
                    Slider(value: Binding(
                        get: { Double(preferences.maxCookingTime) },
                        set: { preferences.maxCookingTime = Int($0) }
                    ), in: 10...120, step: 10)
                }
                
                // 偏好菜系
                Section("偏好菜系") {
                    ForEach(RecipeCategory.allCases, id: \.self) { category in
                        HStack {
                            Image(systemName: category.icon)
                                .foregroundColor(.blue)
                            
                            Text(category.rawValue)
                            
                            Spacer()
                            
                            if preferences.preferredCuisines.contains(category) {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            toggleCuisine(category)
                        }
                    }
                }
                
                // 饮食限制
                Section("饮食限制") {
                    ForEach(DietaryRestriction.allCases, id: \.self) { restriction in
                        HStack {
                            Text(restriction.rawValue)
                            
                            Spacer()
                            
                            if preferences.dietaryRestrictions.contains(restriction) {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            toggleRestriction(restriction)
                        }
                    }
                }
                
                // 过敏信息
                Section("过敏信息") {
                    ForEach(preferences.allergies.indices, id: \.self) { index in
                        HStack {
                            TextField("过敏食材", text: $preferences.allergies[index])
                            
                            Button("删除") {
                                preferences.allergies.remove(at: index)
                            }
                            .foregroundColor(.red)
                        }
                    }
                    
                    Button("添加过敏食材") {
                        preferences.allergies.append("")
                    }
                }
                
                // 错误信息
                if let errorMessage = dataManager.errorMessage {
                    Section("系统信息") {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                }
            }
            .navigationTitle("设置")
            .toolbar {
                ToolbarItem(placement: toolbarPlacement) {
                    Button("保存") {
                        savePreferences()
                    }
                }
            }
            .alert("同步结果", isPresented: $showingSync) {
                Button("确定") { }
            } message: {
                Text(syncMessage)
            }
        }
    }
    
    private func toggleCuisine(_ category: RecipeCategory) {
        if preferences.preferredCuisines.contains(category) {
            preferences.preferredCuisines.removeAll { $0 == category }
        } else {
            preferences.preferredCuisines.append(category)
        }
    }
    
    private func toggleRestriction(_ restriction: DietaryRestriction) {
        if preferences.dietaryRestrictions.contains(restriction) {
            preferences.dietaryRestrictions.removeAll { $0 == restriction }
        } else {
            preferences.dietaryRestrictions.append(restriction)
        }
    }
    
    private func savePreferences() {
        // 这里可以添加保存用户偏好设置的逻辑
        // 暂时先保存到本地
        if let encoded = try? JSONEncoder().encode(preferences) {
            UserDefaults.standard.set(encoded, forKey: "userPreferences")
        }
    }
    
    private func loadPreferences() {
        if let data = UserDefaults.standard.data(forKey: "userPreferences"),
           let decoded = try? JSONDecoder().decode(UserPreferences.self, from: data) {
            preferences = decoded
        }
    }
    
    private func syncData() {
        Task {
            await dataManager.syncWithFirebase()
            DispatchQueue.main.async {
                syncMessage = dataManager.errorMessage ?? "同步成功"
                showingSync = true
            }
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(DataManager())
}