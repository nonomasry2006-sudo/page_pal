import '../../../../core/storage/hive_service.dart';
import '../models/user_account.dart';

class AuthLocalDataSource {
  UserAccount? findUser(String email) {
    return HiveService.users.get(email.toLowerCase());
  }

  Future<void> saveUser(UserAccount account) async {
    await HiveService.users.put(account.email.toLowerCase(), account);
    await HiveService.users.flush();
  }

  String? getCurrentUserEmail() {
    return HiveService.session.get('currentEmail');
  }

  Future<void> saveSession(String email) async {
    await HiveService.session.put('currentEmail', email.toLowerCase());
    await HiveService.session.flush();
  }

  Future<void> clearSession() async {
    await HiveService.session.delete('currentEmail');
    await HiveService.session.flush();
  }

  bool get isLoggedIn => getCurrentUserEmail() != null;
}