import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_provider.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final urlController = TextEditingController(text: 'https://mflux.coolbet.cn/v1/');
    final tokenController = TextEditingController(text: 'lOEQiLk-6QtDmiIz9_AsoBmZrdeKBarjZyjTLyo4600=');
    final formKey = GlobalKey<FormState>();

    // 验证 URL 格式的正则表达式
    final urlRegExp = RegExp(
      r'^(http|https):\/\/([\w-]+(\.[\w-]+)+)(:\d+)?(\/[\w-./?%&=]*)?$',
      caseSensitive: false,
    );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // URL 输入框
              TextFormField(
                controller: urlController,
                decoration: const InputDecoration(
                  labelText: '服务器URL',
                  hintText: 'ex. https://api.example.cn/v1/',
                ),
                keyboardType: TextInputType.url,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '服务器URL必填';
                  }
                  if (!urlRegExp.hasMatch(value)) {
                    return '请输入正确的服务器URL';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              // Token 输入框
              TextFormField(
                controller: tokenController,
                decoration: const InputDecoration(
                  labelText: 'API密钥',
                  hintText: '',
                ),
                obscureText: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'API密钥必填';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // 状态指示器
              if (authState.isLoading)
                const CircularProgressIndicator()
              else
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      await ref.read(authProvider.notifier).login(
                        baseUrl: urlController.text,
                        token: tokenController.text,
                      );
                    }
                  },
                  child: const Text('继续'),
                ),
              // 错误信息显示
              if (authState.error != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    authState.error!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                      fontSize: 14,
                    ),
                  ),
                ),
              // 补充说明文本
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  'API密钥需从您的 API 提供商处获取\n'
                      '示例服务器URL: https://api.example.com/v1/',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}