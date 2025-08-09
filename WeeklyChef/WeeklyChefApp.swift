import SwiftUI
import FirebaseCore // 添加Firebase SDK后取消注释

@main
struct WeeklyChefApp: App {
    
    init() {
        // 配置Firebase - 添加Firebase SDK后取消注释
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
