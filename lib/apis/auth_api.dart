import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone/core/providers.dart';

import '../core/failure.dart';
import '../core/type_def.dart';

final authAPIProvider = Provider((ref) {
  final account = ref.watch(fireAuthProvider);
  return AuthAPI(account: account);
});

abstract class IAuthAPI {
  Stream<User?> authStateChange();
  Future<User?> currentUser();
  FutureEitherVoid getOTp(
    String number,
    VoidCallback onComplete,
    VoidCallback onFailed,
    Function(String verificationID) onSent,
  );
  FutureEitherVoid verifyOTp(
    String verificationID,
    String otp,
    VoidCallback onComplete,
    VoidCallback onFailed,
  );
}

class AuthAPI implements IAuthAPI {
  final FirebaseAuth _account;
  AuthAPI({required FirebaseAuth account}) : _account = account;

  @override
  Stream<User?> authStateChange() {
    return _account.authStateChanges();
  }

  @override
  FutureEitherVoid verifyOTp(
    String verificationID,
    String otp,
    VoidCallback onComplete,
    VoidCallback onFailed,
  ) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationID, smsCode: otp);

      await _account.signInWithCredential(credential).then((value) {
        // setState(() {
        //   loading = false;
        // });
        // showSnackBar(context, "OTP Verifies Successully");
        onComplete.call();
      }).catchError((e) {
        // setState(() {
        //   loading = false;
        // });
        // showSnackBar(
        //   context,
        //   e.toString(),
        // );
        onComplete.call();
      });
      return right(null);
    } on FirebaseException catch (e, stackTrace) {
      return left(
          Failure(e.message ?? 'Some Unexpected Error Occured!', stackTrace));
    } catch (e, stackTrace) {
      debugPrint("llaggaye$e");
      return left(Failure(e.toString(), stackTrace));
    }
    // Show Snackbar after successful verification
  }

  @override
  FutureEitherVoid getOTp(
    String number,
    VoidCallback onComplete,
    VoidCallback onFailed,
    Function(String verificationID) onSent,
  ) async {
    try {
      await _account.verifyPhoneNumber(
          phoneNumber: number.startsWith("+91") ? number : "+91$number",
          verificationCompleted: (PhoneAuthCredential credential) async {
            // loading = false;
            await _account.signInWithCredential(credential);
            onComplete.call();
          },
          verificationFailed: (FirebaseAuthException e) {
            // setState(() {
            //   loading = false;
            // });
            onFailed.call();
          },
          codeSent: (verificationId, forceResendingToken) async {
            // setState(() {
            //   loading = false;
            // });
            // OnboardingView.verificationId = verificationId;
            // Navigator.push(context, OTPView.route());
            onSent(verificationId);
          },
          codeAutoRetrievalTimeout: (String verificationId) {});
      return right(null);
    } on FirebaseException catch (e, stackTrace) {
      return left(
          Failure(e.message ?? 'Some Unexpected Error Occured!', stackTrace));
    } catch (e, stackTrace) {
      debugPrint("llaggaye$e");
      return left(Failure(e.toString(), stackTrace));
    }
  }

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
