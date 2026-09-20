import '../../../../core/errors/failures.dart';
import '../models/user_account.dart';
import 'auth_local_data_source.dart';

abstract class AuthRepository {
  Future<(UserAccount?, Failure?)> signUp({
    required String name,
    required String email,
    required String password,
  });

  Future<(UserAccount?, Failure?)> signIn({
    required String email,
    required String password,
  });

  Future<Failure?> signOut();

  Future<void> updateUser(UserAccount account);

  UserAccount? findUser(String email);
  UserAccount? getCurrentUser();
  bool get isLoggedIn;
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource _local;
  AuthRepositoryImpl(this._local);

  @override
  Future<(UserAccount?, Failure?)> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final normalizedEmail = email.trim().toLowerCase();

      final existing = _local.findUser(normalizedEmail);
      if (existing != null) {
        return (null, const ServerFailure('Email is already registered'));
      }

      final account = UserAccount(
        email: normalizedEmail,
        password: password,
        name: name.trim(),
        createdAt: DateTime.now(),
      );

      await _local.saveUser(account);
      await _local.saveSession(normalizedEmail);
      return (account, null);
    } catch (e) {
      return (null, const ServerFailure('Failed to create account'));
    }
  }

  @override
  Future<(UserAccount?, Failure?)> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final normalizedEmail = email.trim().toLowerCase();
      final account = _local.findUser(normalizedEmail);

      if (account == null) {
        return (null, const ServerFailure('No account with this email'));
      }
      if (account.password != password) {
        return (null, const ServerFailure('Incorrect password'));
      }

      await _local.saveSession(normalizedEmail);
      return (account, null);
    } catch (e) {
      return (null, const ServerFailure('Failed to sign in'));
    }
  }

  @override
  Future<Failure?> signOut() async {
    try {
      await _local.clearSession();
      return null;
    } catch (e) {
      return const ServerFailure('Failed to sign out');
    }
  }

  @override
  Future<void> updateUser(UserAccount account) async {
    await _local.saveUser(account);
  }

  @override
  UserAccount? findUser(String email) => _local.findUser(email);

  @override
  UserAccount? getCurrentUser() {
    final email = _local.getCurrentUserEmail();
    if (email == null) return null;
    return _local.findUser(email);
  }

  @override
  bool get isLoggedIn => _local.isLoggedIn;
}