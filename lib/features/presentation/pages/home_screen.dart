import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/routes/app_route.dart';

import '../providers/auth_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider.select((state) => state.user));

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false, //禁用自动返回箭头
        leading: IconButton(onPressed: () {
          ref.read(appRouterProvider).pushNamed(RouteNames.profile);
        }, icon: const Icon(Icons.person)),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => {

            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome ${user?.username ?? 'Guest'}'),
            const SizedBox(height: 20),
            const Text('You are logged in!'),
          ],
        ),
      ),
    );
  }
}