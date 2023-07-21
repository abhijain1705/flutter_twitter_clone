import 'package:cloud_firestore/cloud_firestore.dart';
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
  FutureEitherVoid saveUserData(UserModal userModal);
}

class UserAPI implements IUserAPI {
  final FirebaseFirestore _db;
  UserAPI({required FirebaseFirestore db}) : _db = db;
  @override
  FutureEitherVoid saveUserData(UserModal userModal) async {
    try {
      await _db.collection(FirebaseConstants.databseId).add(userModal.toMap());
      return right(null);
    } on FirebaseException catch (e, stackTrace) {
      return left(
          Failure(e.message ?? 'Some Unexpected Error Occured!', stackTrace));
    } catch (e, stackTrace) {
      return left(Failure(e.toString(), stackTrace));
    }
  }
}
