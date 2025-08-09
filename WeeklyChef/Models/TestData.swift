import Foundation

// 测试数据，用于验证应用功能
struct TestData {
    static let sampleIngredients: [Ingredient] = [
        Ingredient(
            name: "番茄",
            quantity: 3,
            unit: "个",
            category: .vegetables,
            purchaseDate: Date(),
            expirationDate: Date().addingTimeInterval(5 * 24 * 60 * 60)
        ),
        Ingredient(
            name: "鸡蛋",
            quantity: 6,
            unit: "个",
            category: .dairy,
            purchaseDate: Date(),
            expirationDate: Date().addingTimeInterval(10 * 24 * 60 * 60)
        ),
        Ingredient(
            name: "鸡翅",
            quantity: 8,
            unit: "个",
            category: .meat,
            purchaseDate: Date(),
            expirationDate: Date().addingTimeInterval(3 * 24 * 60 * 60)
        ),
        Ingredient(
            name: "意面",
            quantity: 500,
            unit: "克",
            category: .grains,
            purchaseDate: Date(),
            expirationDate: Date().addingTimeInterval(30 * 24 * 60 * 60)
        ),
        Ingredient(
            name: "洋葱",
            quantity: 2,
            unit: "个",
            category: .vegetables,
            purchaseDate: Date(),
            expirationDate: Date().addingTimeInterval(7 * 24 * 60 * 60)
        )
    ]
    
    static let sampleRecipes: [Recipe] = [
        Recipe(
            name: "番茄炒蛋",
            description: "经典的家常菜，简单易做，营养丰富",
            ingredients: [
                RecipeIngredient(name: "番茄", quantity: 2, unit: "个", estimatedCost: 1.0),
                RecipeIngredient(name: "鸡蛋", quantity: 3, unit: "个", estimatedCost: 0.5),
                RecipeIngredient(name: "盐", quantity: 1, unit: "茶匙", estimatedCost: 0.1),
                RecipeIngredient(name: "油", quantity: 2, unit: "汤匙", estimatedCost: 0.2)
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
            tags: ["快手菜", "家常菜", "素食"]
        ),
        Recipe(
            name: "可乐鸡翅",
            description: "甜咸可口的经典菜，留学生必备",
            ingredients: [
                RecipeIngredient(name: "鸡翅", quantity: 8, unit: "个", estimatedCost: 3.0),
                RecipeIngredient(name: "可乐", quantity: 1, unit: "罐", estimatedCost: 1.0),
                RecipeIngredient(name: "生抽", quantity: 2, unit: "汤匙", estimatedCost: 0.3),
                RecipeIngredient(name: "老抽", quantity: 1, unit: "汤匙", estimatedCost: 0.3),
                RecipeIngredient(name: "姜", quantity: 3, unit: "片", estimatedCost: 0.2)
            ],
            instructions: [
                "鸡翅洗净，用牙签扎几个小孔",
                "锅中放油，煎至两面金黄",
                "加入可乐、生抽、老抽、姜片",
                "大火烧开后转小火炖20分钟",
                "收汁即可"
            ],
            cookingTime: 30,
            difficulty: .medium,
            category: .chinese,
            tags: ["肉类", "经典菜", "下饭菜"]
        ),
        Recipe(
            name: "意面配番茄酱",
            description: "简单美味的西式料理",
            ingredients: [
                RecipeIngredient(name: "意面", quantity: 200, unit: "克", estimatedCost: 1.0),
                RecipeIngredient(name: "番茄", quantity: 3, unit: "个", estimatedCost: 1.5),
                RecipeIngredient(name: "洋葱", quantity: 1, unit: "个", estimatedCost: 0.5),
                RecipeIngredient(name: "蒜", quantity: 3, unit: "瓣", estimatedCost: 0.2),
                RecipeIngredient(name: "橄榄油", quantity: 2, unit: "汤匙", estimatedCost: 0.4),
                RecipeIngredient(name: "盐", quantity: 1, unit: "茶匙", estimatedCost: 0.1)
            ],
            instructions: [
                "意面按包装说明煮至8分熟",
                "番茄切块，洋葱切丁，蒜切碎",
                "锅中放橄榄油，爆香蒜末",
                "加入洋葱炒软",
                "加入番茄翻炒出汁",
                "加入煮好的意面，加盐调味"
            ],
            cookingTime: 20,
            difficulty: .easy,
            category: .western,
            tags: ["西餐", "素食", "快手菜"]
        )
    ]
} 