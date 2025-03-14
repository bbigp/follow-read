import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_provider.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final urlController = TextEditingController();
    final tokenController = TextEditingController();
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
                  labelText: 'API Endpoint',
                  hintText: 'https://api.example.com/auth',
                ),
                keyboardType: TextInputType.url,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'API endpoint is required';
                  }
                  if (!urlRegExp.hasMatch(value)) {
                    return 'Please enter a valid URL';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              // Token 输入框
              TextFormField(
                controller: tokenController,
                decoration: const InputDecoration(
                  labelText: 'Access Token',
                  hintText: 'Enter your authentication token',
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Access token is required';
                  }
                  if (value.length < 16) {
                    return 'Token must be at least 16 characters';
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
                  child: const Text('Authenticate'),
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
                  'Token should be obtained from your API provider\n'
                      'Example endpoint: https://api.example.com/v1/auth',
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