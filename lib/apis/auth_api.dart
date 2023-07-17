import 'package:appwrite/appwrite.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone/core/core.dart';
import 'package:appwrite/models.dart' as model;
import 'package:twitter_clone/core/providers.dart';

final authAPIProvider = Provider((ref) {
  final account = ref.watch(appwriteAccountProvider);
  return AuthAPI(account: account);
});

abstract class IAuthAPI {
  // FutureEither<User> login({required String phoneNumber});

  Future<model.User?> currentUser();
}

class AuthAPI implements IAuthAPI {
  final Account _account;
  AuthAPI({required Account account}) : _account = account;

  @override
  Future<model.User?> currentUser() async {
    try {
      return await _account.get();
    } catch (e) {
      return null;
    }
  }

  // @override
  // FutureEither<User> login({required String phoneNumber}) async {
  //   try {
  //     await .verifyPhoneNumber(
  //       phoneNumber: '+44 7123 123 456',
  //       verificationCompleted: (PhoneAuthCredential credential) {},
  //       verificationFailed: (FirebaseAuthException e) {},
  //       codeSent: (String verificationId, int? resendToken) {},
  //       codeAutoRetrievalTimeout: (String verificationId) {},
  //     );
  //   } on FirebaseAuthException catch (e, stackTrace) {
  //     return left(Failure(e.message ?? 'Some unexpected Error', stackTrace));
  //   } catch (e, stackTrace) {
  //     return left(Failure(e.toString(), stackTrace));
  //   }
  // }
}
