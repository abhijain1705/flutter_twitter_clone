import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/apis/auth_api.dart';
import 'package:twitter_clone/apis/storage_provider.dart';
import 'package:twitter_clone/apis/user_api.dart';
import 'package:twitter_clone/modals/user_modal.dart';
import '../../../core/utils.dart';

enum ImageType {
  profilePicture,
  cardPicture,
}

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
      authAPI: ref.watch(authAPIProvider),
      userAPI: ref.watch(userApiProvider),
      storage: ref.watch(storageRepositoryProvider));
});

final currentUserAccountProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.currentUser();
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;
  final UserAPI _userAPI;
  final MyStorageRepository _storage;
  AuthController(
      {required AuthAPI authAPI,
      required UserAPI userAPI,
      required MyStorageRepository storage})
      : _authAPI = authAPI,
        _userAPI = userAPI,
        _storage = storage,
        super(false);

  Future<User?> currentUser() => _authAPI.currentUser();

  void addPicture(
      {File? picture,
      String? uniqueId,
      String? path,
      required BuildContext context,
      required UserModal userModal,
      required ImageType imageType}) async {
    if (picture != null && uniqueId != null && path != null) {
      final res =
          await _storage.storeFile(path: path, id: uniqueId, file: picture);
      res.fold((l) => showSnackBar(context, l.message), (r) {
        if (imageType == ImageType.cardPicture) {
          userModal = userModal.copyWith(cardPicture: r);
        } else {
          userModal = userModal.copyWith(profilePicture: r);
        }
      });
    }
  }
}
