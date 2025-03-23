

lib/
├── features/
│   └── auth/
│       ├── domain/                  # 领域层
│       │   ├── entities/            # 业务实体（如 UserEntity）
│       │   └── use_cases/           # 业务逻辑（如 LoginUseCase）  具体的用户用例
│       └── data/                    # 数据层
│           ├── datasources/         # 数据源（API/DB 实现）  单表实现
│           ├── models/              # 数据模型（JSON/DB 结构）
│           └── repositories/        # ✅ 仓库具体实现     同一数据的多数据源组合





生成.g.dart文件

flutter pub run build_runner build
flutter run -v > build.log 2>&1

flutter pub run flutter_launcher_icons:main



# 执行同步命令
./gradlew clean && ./gradlew assembleDebug