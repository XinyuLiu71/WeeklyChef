# WeeklyChef - 留学生厨房助手

## 项目简介

WeeklyChef 是一款专为海外留学生设计的智能厨房助手应用，帮助留学生解决"吃什么、买什么、怎么做"的日常困扰。

## 核心功能

### 🥬 冰箱管理
- **食材录入**: 手动添加食材，包含名称、数量、分类、购买日期和过期日期
- **分类管理**: 按蔬菜、水果、肉类、海鲜、乳制品等分类管理
- **过期提醒**: 智能提醒即将过期的食材，减少浪费
- **库存追踪**: 实时显示食材剩余数量和状态

### 📖 智能菜谱
- **菜谱库**: 精选适合留学生的简单菜谱
- **分类浏览**: 按中餐、西餐、快手菜、健康餐等分类
- **详细步骤**: 清晰的制作步骤和食材清单
- **难度标识**: 简单、中等、困难三个难度等级

### 💡 智能推荐
- **基于食材推荐**: 根据冰箱中的食材智能推荐可制作的菜谱
- **匹配度显示**: 显示菜谱与现有食材的匹配百分比
- **缺失提醒**: 显示制作菜谱还缺少哪些食材
- **筛选功能**: 可按"可立即制作"、"差1-2种食材"等条件筛选

## 技术栈

- **前端**: SwiftUI (iOS 17.0+)
- **后端**: Firebase (Firestore数据库)
- **认证**: Firebase Authentication (匿名登录)
- **数据存储**: Firebase Firestore + 本地缓存
- **架构**: MVVM模式
- **语言**: Swift 5.0

## 项目结构

```
WeeklyChef/
├── Models/                 # 数据模型
│   ├── Ingredient.swift   # 食材模型
│   ├── Recipe.swift       # 菜谱模型
│   ├── UserPreferences.swift # 用户偏好设置
│   ├── DataManager.swift  # 数据管理器
│   ├── TestData.swift     # 测试数据
│   └── ExtendedRecipeData.swift # 扩展菜谱数据库
├── Services/               # 服务层
│   └── FirebaseService.swift # Firebase服务
├── Views/                  # 界面视图
│   ├── FridgeView.swift   # 冰箱管理界面
│   ├── AddIngredientView.swift # 添加食材界面
│   ├── RecipeView.swift   # 菜谱浏览界面
│   ├── RecipeDetailView.swift # 菜谱详情界面
│   ├── RecommendationsView.swift # 推荐界面
│   └── SettingsView.swift # 设置界面
├── ContentView.swift      # 主界面
├── WeeklyChefApp.swift    # 应用入口
├── GoogleService-Info.plist # Firebase配置
└── Assets.xcassets/       # 资源文件
```

## 安装和运行

### 系统要求
- Xcode 15.0+
- iOS 17.0+
- macOS 14.0+

### 运行步骤
1. 克隆项目到本地
2. 配置Firebase（详见 `FIREBASE_SETUP.md`）
3. 使用Xcode打开 `WeeklyChef.xcodeproj`
4. 添加Firebase SDK依赖
5. 替换 `GoogleService-Info.plist` 为你的Firebase项目配置
6. 选择目标设备（iPhone模拟器或真机）
7. 点击运行按钮或按 `Cmd+R`

## 使用指南

### 添加食材
1. 打开应用，点击"冰箱"标签
2. 点击右上角的"+"按钮
3. 填写食材信息（名称、数量、单位、分类、日期）
4. 点击"保存"

### 浏览菜谱
1. 点击"菜谱"标签
2. 使用顶部分类筛选器筛选菜谱
3. 点击菜谱查看详细信息
4. 使用搜索功能快速找到想要的菜谱

### 获取推荐
1. 点击"推荐"标签
2. 系统会根据冰箱中的食材自动推荐菜谱
3. 使用筛选器查看不同匹配度的推荐
4. 点击菜谱查看详细信息和制作步骤

## 开发计划

### 当前版本 (v2.0)
- ✅ 基础冰箱管理功能
- ✅ 菜谱浏览和详情
- ✅ 基于食材的智能推荐
- ✅ 云端数据同步 (Firebase)
- ✅ 用户偏好设置
- ✅ 离线缓存功能
- ✅ 扩展菜谱数据库（15+菜谱）
- ✅ 营养信息显示

### 未来版本
- 🔄 购物清单功能
- 🔄 周度饮食计划
- 🔄 健康数据集成 (HealthKit)
- 🔄 社区分享功能
- 🔄 条码扫描功能
- 🔄 多语言支持
- 🔄 用户账户系统
- 🔄 推送通知

## 贡献指南

欢迎提交Issue和Pull Request来帮助改进这个项目！

## 许可证

MIT License

## 联系方式

如有问题或建议，请通过以下方式联系：
- 邮箱: [your-email@example.com]
- GitHub: [your-github-username]

---

**注意**: 这是一个MVP版本，专注于核心功能的实现。后续版本将逐步添加更多高级功能。 