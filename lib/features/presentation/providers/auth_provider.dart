//
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../../domain/models/user.dart';
// import '../../domain/use_cases/get_current_user_use_case.dart';
// import '../../domain/use_cases/login_user_case.dart';
// import 'app_container.dart';
//
// final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
//   return AuthNotifier(
//     loginUseCase: ref.watch(loginUseCaseProvider),
//   );
// });
//
// class AuthNotifier extends StateNotifier<AuthState> {
//   final LoginUseCase _loginUseCase;
//
//   AuthNotifier({
//     required LoginUseCase loginUseCase,
//   })  : _loginUseCase = loginUseCase,
//         super(const AuthState.initial()) {
//     initialize();
//   }
//
//   Future<void> initialize() async {
//   }
//
//   void logout() async {
//     await _loginUseCase.logout();
//     state = state.copyWith(isLoading: false, user: null);
//   }
//
//
//   Future<bool> login({required token, required String baseUrl}) async {
//     state = state.copyWith(isLoading: true, error: null);
//
//     final result = await _loginUseCase.execute(baseUrl, token);
//
//     return result!.fold(
//           (error) {
//         state = state.copyWith(
//           isLoading: false,
//           error: error.message,
//         );
//         return false;
//       },
//           (user) {
//         state = state.copyWith(
//           isLoading: false,
//           user: user,
//         );
//         return true;
//       },
//     );
//   }
//
//   Future<void> checkAuthStatus() async {
//     state = state.copyWith(isLoading: true);
//   }
// }
//
// class AuthState {
//   final bool isLoading;
//   final User? user;
//   final String? error;
//
//   const AuthState({
//     this.isLoading = false,
//     this.user,
//     this.error,
//   });
//
//   const AuthState.initial()
//       : isLoading = false,
//         user = null,
//         error = null;
//
//   AuthState copyWith({
//     bool? isLoading,
//     User? user,
//     String? error,
//   }) {
//     return AuthState(
//       isLoading: isLoading ?? this.isLoading,
//       user: user ?? this.user,
//       error: error ?? this.error,
//     );
//   }
// }