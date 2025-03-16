import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/routes/app_route.dart';

import '../../domain/models/user.dart';
import '../providers/auth_provider.dart'; // 用于复制操作

class ProfilePage extends ConsumerWidget {


  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider.select((state) => state.user));
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          _buildUserInfoSection(user!),
          const SizedBox(height: 24),
          _buildPreferencesSection(user),
          const SizedBox(height: 24),
          _buildServerInfoSection(user),
          const SizedBox(height: 40),  // 新增与上方内容的间距
          _buildLogoutButton(ref),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red.shade600,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 8), // 减小垂直内边距
          minimumSize: const Size.fromHeight(40), // 设置最小高度
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          // 退出登录逻辑
          ref.read(authProvider.notifier).logout();
          ref.read(appRouterProvider).goNamed(RouteNames.login);
        },
        child: const Text(
          "退出登录",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }


  Widget _buildUserInfoSection(User user) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center, // 垂直居中
            children: [
              // 左侧用户信息 + VIP
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          user.username,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          user.isAdmin ? Icons.verified_user : Icons.person_outlined,
                          color: user.isAdmin ? Colors.blue : Colors.grey,
                          size: 20,
                        ),
                        const SizedBox(width: 8), // 管理员和VIP间距
                        user.isAdmin ? _buildInfoBadge("Admin", Colors.amber) : Container(), // VIP徽章
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "上次登录: ${user.lastLoginAt}",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),

              // 右侧编辑按钮
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(Icons.edit, color: Colors.grey[600]), // 灰色
                  iconSize: 20,
                  onPressed: () => {

                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

// 信息徽章组件（保持原样）
  Widget _buildInfoBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: color.withAlpha((255 * 0.1).round()),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withAlpha((255 * 0.3).round())),
      ),
      child: Row(
        children: [
          Icon(Icons.star, color: color, size: 14),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // 偏好设置
  Widget _buildPreferencesSection(User user) {
    return Column(
     children: [
        _buildPreferenceItem("主题模式", user.theme, Icons.color_lens, Icons.chevron_right),
        _buildPreferenceItem("语言", user.language, Icons.language, Icons.chevron_right),
        _buildPreferenceItem("时区", user.timezone, Icons.access_time, Icons.chevron_right),
      ],
    );
  }

  // 服务器信息
  Widget _buildServerInfoSection(User user) {
    return Column(
      children: [
        _buildPreferenceItem("服务器地址", user.baseUrl, Icons.cloud, Icons.content_copy),
        _buildPreferenceItem("访问令牌", user.token, Icons.security, Icons.content_copy),
      ],
    );
  }

  // 通用设置项组件
  Widget _buildPreferenceItem(String title, String value, IconData icon, IconData right) {
    return  Material(
      color: Colors.white, // 保持与背景色一致
      child: InkWell(
        onTap: () {},     // 点击事件
        splashColor: Colors.blue.withAlpha((255 * 0.1).round()),
        highlightColor: Colors.blue.withAlpha((255 * 0.05).round()),
        child: Container(
          width: double.infinity, // 撑满父容器
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8), // 内容边距
          child: Column(
            children: [
              Row(
                children: [
                  Icon(icon, size: 24,),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: const TextStyle(fontSize: 16)),
                        Padding(padding: EdgeInsets.only(right: 16),
                        child:Text(value, maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ))
                          ,)
                        ,
                      ],
                    ),
                  ),
                  Icon(right, size: 20)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 复制到剪贴板
  void _copyToClipboard(String text) {
    // Clipboard.setData(ClipboardData(text: text));
    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(content: Text("已复制到剪贴板")),
    // );
  }

  // 令牌脱敏处理
  String _obscureToken(String token) {
    if (token.length <= 8) return "****";
    return "${token.substring(0, 4)}****${token.substring(token.length - 4)}";
  }
}

// 模拟用户数据（实际应从状态管理获取）
// final String username = "Guest";
// final bool isAdmin = false;
// final String lastLogin = "2024-02-20 14:30 UTC";
// final String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...";
// final String server = "api.example.com";
// final String theme = "Dark";
// final String language = "简体中文";
// final String timezone = "UTC+8";