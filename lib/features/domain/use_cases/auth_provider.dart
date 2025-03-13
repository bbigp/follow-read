//
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../../data/models/user_model.dart';
// import 'login_use_case.dart';
//
// final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
//   return AuthNotifier(
//     loginUseCase: ref.watch(loginUseCaseProvider),
//     getCurrentUserUseCase: ref.watch(getCurrentUserUseCaseProvider),
//   );
// });
//
// class AuthNotifier extends StateNotifier<AuthState> {
//   final LoginUseCase _loginUseCase;
//   final GetCurrentUserUseCase _getCurrentUserUseCase;
//
//   AuthNotifier({
//     required LoginUseCase loginUseCase,
//     required GetCurrentUserUseCase getCurrentUserUseCase,
//   })  : _loginUseCase = loginUseCase,
//         _getCurrentUserUseCase = getCurrentUserUseCase,
//         super(const AuthState.initial());
//
//   Future<bool> login({required String email, required String password}) async {
//     state = state.copyWith(isLoading: true, error: null);
//
//     final result = await _loginUseCase.execute(email, password);
//
//     return result.fold(
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
//     final user = await _getCurrentUserUseCase.execute();
//     state = state.copyWith(isLoading: false, user: user);
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