import SwiftUI

struct ContentView: View {
    @StateObject private var dataManager = DataManager()
    
    var body: some View {
        TabView {
            FridgeView()
                .tabItem {
                    Image(systemName: "refrigerator")
                    Text("冰箱")
                }
            
            RecipeView()
                .tabItem {
                    Image(systemName: "book.closed")
                    Text("菜谱")
                }
            
            RecommendationsView()
                .tabItem {
                    Image(systemName: "lightbulb")
                    Text("推荐")
                }
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("设置")
                }
        }
        .environmentObject(dataManager)
    }
}

#Preview {
    ContentView()
} 