import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone/constants/constants.dart';
import 'package:twitter_clone/core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/core/providers.dart';
import 'package:twitter_clone/modals/user_modal.dart';

final userApiProvider = Provider((ref) {
  final db = ref.watch(firestoreProvider);
  return UserAPI(db: db);
});

abstract class IUserAPI {
  FutureEitherVoid saveUserData(UserModal userModal, String uiqueId);
  FutureEither<UserModal> currentUser(String uniqueId);
}

class UserAPI implements IUserAPI {
  final FirebaseFirestore _db;
  UserAPI({required FirebaseFirestore db}) : _db = db;
  @override
  FutureEitherVoid saveUserData(UserModal userModal, String uiqueId) async {
    try {
      await _db
          .collection(FirebaseConstants.databseId)
          .doc(uiqueId)
          .set(userModal.toMap());
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
  FutureEither<UserModal> currentUser(String uniqueId) async {
    try {
      final userSnapshot =
          await _db.collection(FirebaseConstants.databseId).doc(uniqueId).get();
      final userData = userSnapshot.data();
      if (userData != null) {
        final userModal = UserModal.fromMap(userData);
        return right(userModal);
      } else {
        return left(const Failure('User not found', StackTrace.empty));
      }
    } on FirebaseException catch (e, stackTrace) {
      return left(
          Failure(e.message ?? 'Some Unexpected Error Occured!', stackTrace));
    } catch (e, stackTrace) {
      debugPrint("llaggaye$e");
      return left(Failure(e.toString(), stackTrace));
    }
  }
}
