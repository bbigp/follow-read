

lib/
├── main.dart
├── routes/
│   └── app_pages.dart        # 所有路由注册表
│   └── app_routes.dart       # 路由路径常量
├── core/                     # 核心功能模块（全局通用）
│   ├── bindings/             # 全局绑定
│   ├── services/             # 全局服务（如网络、数据库）
│   ├── utils/                # 工具类
│   └── themes/               # 主题配置
├── data/                     # 数据处理层（如 API、model）
│   ├── models/
│   ├── providers/            # API调用
│   └── repositories/         # 数据仓库（封装业务逻辑）
├── modules/                  # 按功能模块划分
│   ├── home/
│   │   ├── bindings/         # home_binding.dart
│   │   ├── controllers/      # home_controller.dart
│   │   ├── views/            # home_view.dart
│   │   └── widgets/          # home模块专属组件
│   ├── login/
│   │   ├── bindings/
│   │   ├── controllers/
│   │   ├── views/
│   │   └── widgets/
│   └── ... 更多模块
├── global/                  # 全局组件/控制器
│   ├── controllers/         # 例如全局 AuthController
│   └── widgets/             # 通用组件（按钮、弹窗等）




生成.g.dart文件

flutter pub run build_runner build
flutter run -v > build.log 2>&1

flutter pub run flutter_launcher_icons:main



# 执行同步命令
./gradlew clean && ./gradlew assembleDebug

> https://juejin.cn/post/6924104248275763208
> https://juejin.cn/post/6984593635681517582
> https://github.com/jonataslaw/getx