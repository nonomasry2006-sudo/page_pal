import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/auth_repository.dart';
import '../models/user_account.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _repository;

  AuthCubit(this._repository) : super(AuthInitial()) {
    _checkInitialSession();
  }

  void _checkInitialSession() {
    if (_repository.isLoggedIn) {
      final user = _repository.getCurrentUser();
      if (user != null) {
        emit(AuthAuthenticated(user));
        return;
      }
    }
    emit(AuthUnauthenticated());
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    final normalizedEmail = email.trim().toLowerCase();
    final existing = _repository.findUser(normalizedEmail);

    if (existing != null) {
      emit(const AuthError(
        'Email is already registered',
        fieldError: AuthFieldError.emailAlreadyExists,
      ));
      return;
    }

    final (user, failure) = await _repository.signUp(
      name: name,
      email: email,
      password: password,
    );

    if (isClosed) return;

    if (failure != null) {
      emit(AuthError(failure.message));
    } else if (user != null) {
      emit(AuthAuthenticated(user));
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    final normalizedEmail = email.trim().toLowerCase();
    final existing = _repository.findUser(normalizedEmail);

    if (existing == null) {
      emit(const AuthError(
        'No account with this email',
        fieldError: AuthFieldError.emailNotFound,
      ));
      return;
    }

    if (existing.password != password) {
      emit(const AuthError(
        'Incorrect password',
        fieldError: AuthFieldError.passwordIncorrect,
      ));
      return;
    }

    final (user, failure) = await _repository.signIn(
      email: email,
      password: password,
    );

    if (isClosed) return;

    if (failure != null) {
      emit(AuthError(failure.message));
    } else if (user != null) {
      emit(AuthAuthenticated(user));
    }
  }

  Future<void> signOut() async {
    await _repository.signOut();
    if (isClosed) return;
    emit(AuthUnauthenticated());
  }

  Future<void> updateProfile({
    required String name,
    String? phone,
    String? bio,
  }) async {
    final currentState = state;
    if (currentState is! AuthAuthenticated) return;

    final updated = UserAccount(
      email: currentState.user.email,
      password: currentState.user.password,
      name: name,
      createdAt: currentState.user.createdAt,
      phone: phone,
      bio: bio,
    );

    await _repository.updateUser(updated);
    if (isClosed) return;
    emit(AuthAuthenticated(updated));
  }
}