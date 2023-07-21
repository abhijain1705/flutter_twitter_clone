import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/core/providers.dart';

final authAPIProvider = Provider((ref) {
  final account = ref.watch(fireAuthProvider);
  return AuthAPI(account: account);
});

abstract class IAuthAPI {
  Future<User?> currentUser();
}

class AuthAPI implements IAuthAPI {
  final FirebaseAuth _account;
  AuthAPI({required FirebaseAuth account}) : _account = account;

  @override
  Future<User?> currentUser() async {
    try {
      final user = _account.currentUser;
      return user;
    } catch (e) {
      return null;
    }
  }
}
