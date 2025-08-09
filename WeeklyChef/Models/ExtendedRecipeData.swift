import Foundation

// 扩充的菜谱数据库，专为留学生设计
struct ExtendedRecipeData {
    static let allRecipes: [Recipe] = [
        // 快手菜系列
        Recipe(
            name: "番茄炒蛋",
            description: "经典的家常菜，简单易做，营养丰富",
            ingredients: [
                RecipeIngredient(name: "番茄", quantity: 2, unit: "个", estimatedCost: 1.0),
                RecipeIngredient(name: "鸡蛋", quantity: 3, unit: "个", estimatedCost: 0.5),
                RecipeIngredient(name: "盐", quantity: 1, unit: "茶匙", estimatedCost: 0.1),
                RecipeIngredient(name: "油", quantity: 2, unit: "汤匙", estimatedCost: 0.2),
                RecipeIngredient(name: "糖", quantity: 0.5, unit: "茶匙", estimatedCost: 0.1, isOptional: true)
            ],
            instructions: [
                "番茄洗净，用开水烫一下去皮，切块",
                "鸡蛋打散，加少许盐调味",
                "热锅下油，炒散鸡蛋，盛起备用",
                "同一锅下番茄翻炒出汁",
                "加入炒蛋翻炒，调味即可"
            ],
            cookingTime: 10,
            difficulty: .easy,
            category: .chinese,
            tags: ["快手菜", "家常菜", "素食"],
            nutritionInfo: NutritionInfo(calories: 180, protein: 12, carbohydrates: 8, fat: 12)
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
            tags: ["肉类", "经典菜", "下饭菜"],
            nutritionInfo: NutritionInfo(calories: 280, protein: 25, carbohydrates: 15, fat: 15)
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
            tags: ["西餐", "素食", "快手菜"],
            nutritionInfo: NutritionInfo(calories: 350, protein: 12, carbohydrates: 65, fat: 8)
        ),
        
        // 简单早餐系列
        Recipe(
            name: "香蕉燕麦粥",
            description: "营养丰富的快手早餐",
            ingredients: [
                RecipeIngredient(name: "燕麦", quantity: 0.5, unit: "杯", estimatedCost: 0.5),
                RecipeIngredient(name: "香蕉", quantity: 1, unit: "个", estimatedCost: 0.5),
                RecipeIngredient(name: "牛奶", quantity: 1, unit: "杯", estimatedCost: 0.8),
                RecipeIngredient(name: "蜂蜜", quantity: 1, unit: "茶匙", estimatedCost: 0.3, isOptional: true),
                RecipeIngredient(name: "核桃", quantity: 5, unit: "个", estimatedCost: 0.5, isOptional: true)
            ],
            instructions: [
                "燕麦用牛奶煮5分钟至软烂",
                "香蕉切片",
                "将香蕉片加入燕麦粥中",
                "根据喜好加入蜂蜜调味",
                "撒上核桃碎即可"
            ],
            cookingTime: 8,
            difficulty: .easy,
            category: .breakfast,
            tags: ["早餐", "健康", "素食"],
            nutritionInfo: NutritionInfo(calories: 320, protein: 12, carbohydrates: 45, fat: 10, fiber: 8)
        ),
        
        Recipe(
            name: "煎蛋三明治",
            description: "简单快手的营养早餐",
            ingredients: [
                RecipeIngredient(name: "面包片", quantity: 2, unit: "片", estimatedCost: 0.5),
                RecipeIngredient(name: "鸡蛋", quantity: 1, unit: "个", estimatedCost: 0.3),
                RecipeIngredient(name: "生菜", quantity: 2, unit: "片", estimatedCost: 0.3),
                RecipeIngredient(name: "番茄", quantity: 0.5, unit: "个", estimatedCost: 0.3),
                RecipeIngredient(name: "奶酪", quantity: 1, unit: "片", estimatedCost: 0.5, isOptional: true),
                RecipeIngredient(name: "黄油", quantity: 1, unit: "茶匙", estimatedCost: 0.2)
            ],
            instructions: [
                "平底锅刷黄油，煎蛋至半熟",
                "面包片烤至微黄",
                "番茄切片，生菜洗净",
                "依次叠放：面包-生菜-煎蛋-番茄-奶酪-面包",
                "对半切开即可享用"
            ],
            cookingTime: 10,
            difficulty: .easy,
            category: .breakfast,
            tags: ["早餐", "快手菜", "西式"],
            nutritionInfo: NutritionInfo(calories: 280, protein: 15, carbohydrates: 25, fat: 14)
        ),
        
        // 一锅炖系列（适合宿舍）
        Recipe(
            name: "电饭煲焖饭",
            description: "一锅搞定的营养焖饭",
            ingredients: [
                RecipeIngredient(name: "大米", quantity: 1, unit: "杯", estimatedCost: 0.5),
                RecipeIngredient(name: "胡萝卜", quantity: 1, unit: "根", estimatedCost: 0.3),
                RecipeIngredient(name: "香肠", quantity: 2, unit: "根", estimatedCost: 1.0),
                RecipeIngredient(name: "豌豆", quantity: 0.5, unit: "杯", estimatedCost: 0.5),
                RecipeIngredient(name: "生抽", quantity: 2, unit: "汤匙", estimatedCost: 0.2),
                RecipeIngredient(name: "香油", quantity: 1, unit: "茶匙", estimatedCost: 0.2)
            ],
            instructions: [
                "大米洗净，加水1.2倍",
                "胡萝卜切丁，香肠切片",
                "所有食材加入电饭煲",
                "加入调料拌匀",
                "按煮饭键，跳闸后焖10分钟",
                "拌匀即可享用"
            ],
            cookingTime: 35,
            difficulty: .easy,
            category: .lunch,
            tags: ["一锅炖", "简单", "营养"],
            nutritionInfo: NutritionInfo(calories: 420, protein: 18, carbohydrates: 55, fat: 12)
        ),
        
        Recipe(
            name: "土豆炖牛肉",
            description: "经典的家常炖菜",
            ingredients: [
                RecipeIngredient(name: "牛肉", quantity: 300, unit: "克", estimatedCost: 4.0),
                RecipeIngredient(name: "土豆", quantity: 2, unit: "个", estimatedCost: 1.0),
                RecipeIngredient(name: "洋葱", quantity: 1, unit: "个", estimatedCost: 0.5),
                RecipeIngredient(name: "胡萝卜", quantity: 1, unit: "根", estimatedCost: 0.3),
                RecipeIngredient(name: "生抽", quantity: 3, unit: "汤匙", estimatedCost: 0.3),
                RecipeIngredient(name: "料酒", quantity: 2, unit: "汤匙", estimatedCost: 0.3),
                RecipeIngredient(name: "八角", quantity: 2, unit: "个", estimatedCost: 0.2, isOptional: true)
            ],
            instructions: [
                "牛肉切块，冷水下锅焯水去血沫",
                "土豆、胡萝卜切块，洋葱切丝",
                "热锅下油，爆香洋葱",
                "下牛肉翻炒，加料酒和生抽",
                "加水没过牛肉，大火烧开转小火炖1小时",
                "加入土豆和胡萝卜，继续炖30分钟至软烂"
            ],
            cookingTime: 100,
            difficulty: .medium,
            category: .dinner,
            tags: ["炖菜", "下饭菜", "营养"],
            nutritionInfo: NutritionInfo(calories: 380, protein: 30, carbohydrates: 25, fat: 18)
        ),
        
        // 健康轻食系列
        Recipe(
            name: "蔬菜沙拉",
            description: "新鲜健康的轻食选择",
            ingredients: [
                RecipeIngredient(name: "生菜", quantity: 100, unit: "克", estimatedCost: 1.0),
                RecipeIngredient(name: "黄瓜", quantity: 1, unit: "根", estimatedCost: 0.5),
                RecipeIngredient(name: "番茄", quantity: 1, unit: "个", estimatedCost: 0.5),
                RecipeIngredient(name: "胡萝卜", quantity: 0.5, unit: "根", estimatedCost: 0.3),
                RecipeIngredient(name: "橄榄油", quantity: 2, unit: "汤匙", estimatedCost: 0.4),
                RecipeIngredient(name: "柠檬汁", quantity: 1, unit: "汤匙", estimatedCost: 0.3),
                RecipeIngredient(name: "盐", quantity: 0.5, unit: "茶匙", estimatedCost: 0.1)
            ],
            instructions: [
                "所有蔬菜洗净切块或切丝",
                "生菜撕成小片",
                "将所有蔬菜混合在大碗中",
                "橄榄油、柠檬汁、盐调成沙拉汁",
                "淋在蔬菜上拌匀即可"
            ],
            cookingTime: 10,
            difficulty: .easy,
            category: .healthy,
            tags: ["轻食", "素食", "健康"],
            nutritionInfo: NutritionInfo(calories: 120, protein: 2, carbohydrates: 8, fat: 10, fiber: 4)
        ),
        
        Recipe(
            name: "鸡胸肉蔬菜卷",
            description: "高蛋白低脂的健康餐",
            ingredients: [
                RecipeIngredient(name: "鸡胸肉", quantity: 150, unit: "克", estimatedCost: 2.0),
                RecipeIngredient(name: "全麦薄饼", quantity: 1, unit: "张", estimatedCost: 0.5),
                RecipeIngredient(name: "生菜", quantity: 3, unit: "片", estimatedCost: 0.3),
                RecipeIngredient(name: "黄瓜", quantity: 0.5, unit: "根", estimatedCost: 0.3),
                RecipeIngredient(name: "番茄", quantity: 0.5, unit: "个", estimatedCost: 0.3),
                RecipeIngredient(name: "希腊酸奶", quantity: 2, unit: "汤匙", estimatedCost: 0.5),
                RecipeIngredient(name: "柠檬汁", quantity: 1, unit: "茶匙", estimatedCost: 0.1)
            ],
            instructions: [
                "鸡胸肉用盐胡椒调味，煎至熟透切丝",
                "蔬菜洗净切丝",
                "希腊酸奶加柠檬汁调成酱",
                "薄饼铺平，刷上酸奶酱",
                "依次放入蔬菜和鸡丝",
                "卷成卷状，对半切开"
            ],
            cookingTime: 15,
            difficulty: .medium,
            category: .healthy,
            tags: ["健康", "高蛋白", "轻食"],
            nutritionInfo: NutritionInfo(calories: 280, protein: 28, carbohydrates: 20, fat: 8)
        ),
        
        // 夜宵/小食系列
        Recipe(
            name: "泡面升级版",
            description: "把普通泡面变成营养大餐",
            ingredients: [
                RecipeIngredient(name: "方便面", quantity: 1, unit: "包", estimatedCost: 0.5),
                RecipeIngredient(name: "鸡蛋", quantity: 1, unit: "个", estimatedCost: 0.3),
                RecipeIngredient(name: "青菜", quantity: 50, unit: "克", estimatedCost: 0.5),
                RecipeIngredient(name: "火腿肠", quantity: 0.5, unit: "根", estimatedCost: 0.5),
                RecipeIngredient(name: "海苔", quantity: 1, unit: "片", estimatedCost: 0.3, isOptional: true)
            ],
            instructions: [
                "水开后下面条煮2分钟",
                "打入鸡蛋，不要搅散",
                "加入切好的青菜和火腿片",
                "继续煮1分钟",
                "加入调料包，撒海苔丝"
            ],
            cookingTime: 8,
            difficulty: .easy,
            category: .snack,
            tags: ["夜宵", "快手", "学生餐"],
            nutritionInfo: NutritionInfo(calories: 380, protein: 15, carbohydrates: 45, fat: 15)
        ),
        
        Recipe(
            name: "烤红薯",
            description: "简单的健康小食",
            ingredients: [
                RecipeIngredient(name: "红薯", quantity: 1, unit: "个", estimatedCost: 0.8),
                RecipeIngredient(name: "黄油", quantity: 1, unit: "茶匙", estimatedCost: 0.2, isOptional: true),
                RecipeIngredient(name: "蜂蜜", quantity: 1, unit: "茶匙", estimatedCost: 0.3, isOptional: true)
            ],
            instructions: [
                "红薯洗净，用叉子扎几个洞",
                "烤箱预热200度",
                "红薯包锡纸，烤45分钟",
                "取出切开，可加黄油或蜂蜜"
            ],
            cookingTime: 50,
            difficulty: .easy,
            category: .snack,
            tags: ["健康", "小食", "烘烤"],
            nutritionInfo: NutritionInfo(calories: 160, protein: 2, carbohydrates: 37, fat: 0.5, fiber: 6)
        ),
        
        // 汤品系列
        Recipe(
            name: "番茄鸡蛋汤",
            description: "清爽的家常汤品",
            ingredients: [
                RecipeIngredient(name: "番茄", quantity: 2, unit: "个", estimatedCost: 1.0),
                RecipeIngredient(name: "鸡蛋", quantity: 2, unit: "个", estimatedCost: 0.6),
                RecipeIngredient(name: "香菜", quantity: 2, unit: "根", estimatedCost: 0.3, isOptional: true),
                RecipeIngredient(name: "盐", quantity: 1, unit: "茶匙", estimatedCost: 0.1),
                RecipeIngredient(name: "香油", quantity: 1, unit: "茶匙", estimatedCost: 0.2)
            ],
            instructions: [
                "番茄去皮切块",
                "锅中放油，炒番茄出汁",
                "加水烧开",
                "鸡蛋打散，慢慢倒入形成蛋花",
                "调味，撒香菜和香油"
            ],
            cookingTime: 15,
            difficulty: .easy,
            category: .chinese,
            tags: ["汤品", "清淡", "家常"],
            nutritionInfo: NutritionInfo(calories: 120, protein: 8, carbohydrates: 6, fat: 8)
        ),
        
        Recipe(
            name: "紫菜蛋花汤",
            description: "简单营养的汤品",
            ingredients: [
                RecipeIngredient(name: "紫菜", quantity: 10, unit: "克", estimatedCost: 0.5),
                RecipeIngredient(name: "鸡蛋", quantity: 1, unit: "个", estimatedCost: 0.3),
                RecipeIngredient(name: "小葱", quantity: 1, unit: "根", estimatedCost: 0.2),
                RecipeIngredient(name: "盐", quantity: 1, unit: "茶匙", estimatedCost: 0.1),
                RecipeIngredient(name: "香油", quantity: 1, unit: "茶匙", estimatedCost: 0.2),
                RecipeIngredient(name: "虾皮", quantity: 1, unit: "汤匙", estimatedCost: 0.3, isOptional: true)
            ],
            instructions: [
                "紫菜用水泡发",
                "锅中加水烧开",
                "下紫菜煮2分钟",
                "鸡蛋打散，慢慢倒入",
                "调味，撒葱花和香油"
            ],
            cookingTime: 10,
            difficulty: .easy,
            category: .chinese,
            tags: ["汤品", "清淡", "快手"],
            nutritionInfo: NutritionInfo(calories: 90, protein: 6, carbohydrates: 4, fat: 6)
        )
    ]
}