// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
//
// // 领域层依赖
// import 'package:your_app/features/auth/presentation/providers/auth_provider.dart';
// import 'package:your_app/core/styles/app_colors.dart';
// import 'package:your_app/core/styles/app_text_styles.dart';
// import 'package:your_app/core/utils/validators.dart';
// import 'package:your_app/core/widgets/loading_overlay.dart';
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   bool _obscurePassword = true;
//
//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _submit(WidgetRef ref) async {
//     // 通过 ref 参数访问 provider
//     await ref.read(authProvider.notifier).login(
//       _emailController.text,
//       _passwordController.text,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final authState = ref.watch(authProvider);
//
//     return Scaffold(
//       body: LoadingOverlay(
//         isLoading: authState.isLoading,
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(20),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 const SizedBox(height: 100),
//                 Text(
//                   'Welcome Back',
//                   style: AppTextStyles.headlineLarge.copyWith(
//                     color: AppColors.primary,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 40),
//                 TextFormField(
//                   controller: _emailController,
//                   decoration: const InputDecoration(
//                     labelText: 'Email',
//                     prefixIcon: Icon(Icons.email_outlined),
//                   ),
//                   keyboardType: TextInputType.emailAddress,
//                   autovalidateMode: AutovalidateMode.onUserInteraction,
//                   validator: Validators.emailValidator,
//                 ),
//                 const SizedBox(height: 20),
//                 TextFormField(
//                   controller: _passwordController,
//                   decoration: InputDecoration(
//                     labelText: 'Password',
//                     prefixIcon: const Icon(Icons.lock_outline),
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         _obscurePassword
//                             ? Icons.visibility_off
//                             : Icons.visibility,
//                       ),
//                       onPressed: () => setState(() {
//                         _obscurePassword = !_obscurePassword;
//                       }),
//                     ),
//                   ),
//                   obscureText: _obscurePassword,
//                   autovalidateMode: AutovalidateMode.onUserInteraction,
//                   validator: Validators.passwordValidator,
//                 ),
//                 const SizedBox(height: 30),
//                 ElevatedButton(
//                   onPressed: _submit,
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                   ),
//                   child: const Text('Sign In'),
//                 ),
//                 const SizedBox(height: 20),
//                 if (authState.error != null)
//                   Text(
//                     authState.error!,
//                     style: AppTextStyles.bodyMedium.copyWith(
//                       color: AppColors.error,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 TextButton(
//                   onPressed: () => context.push('/forgot-password'),
//                   child: const Text('Forgot Password?'),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text("Don't have an account?"),
//                     TextButton(
//                       onPressed: () => context.push('/register'),
//                       child: const Text('Sign Up'),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }