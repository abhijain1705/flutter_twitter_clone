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

final userProvider = StateProvider<UserModal?>((ref) => null);

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
      authAPI: ref.watch(authAPIProvider),
      userAPI: ref.watch(userApiProvider),
      ref: ref,
      storage: ref.watch(storageRepositoryProvider));
});

final authStateChangeProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.authStateChange();
});

final currentUserAccountProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.currentUser();
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;
  final Ref _ref;
  final UserAPI _userAPI;
  final MyStorageRepository _storage;
  AuthController(
      {required AuthAPI authAPI,
      required UserAPI userAPI,
      required Ref ref,
      required MyStorageRepository storage})
      : _authAPI = authAPI,
        _ref = ref,
        _userAPI = userAPI,
        _storage = storage,
        super(false);

  Future<User?> currentUser() => _authAPI.currentUser();

  Stream<User?> authStateChange() {
    return _authAPI.authStateChange();
  }

  void verifyOTp(
      {required String verificationID,
      required String otp,
      required VoidCallback onComplete,
      required VoidCallback onFailed,
      required BuildContext context}) async {
    final res = await _authAPI.verifyOTp(verificationID, otp, () {
      onComplete.call();
    }, onFailed);
    res.fold((l) => showSnackBar(context, l.message), (r) => null);
  }

  void signInWithPhoneNumber({
    required String number,
    required VoidCallback onComplete,
    required VoidCallback onFailed,
    required Function(String verificationId) onSent,
    required BuildContext context,
  }) async {
    final res = await _authAPI.getOTp(
        number,
        () {
          onComplete.call();
        },
        onFailed,
        (String verificationId) {
          onSent(verificationId);
        });
    res.fold((l) => showSnackBar(context, l.message), (r) => null);
  }

  void currentUserDocumentData(
      {required BuildContext context,
      required VoidCallback callback,
      required String uniqueId}) async {
    final res = await _userAPI.currentUser(uniqueId);
    callback.call();
    res.fold((l) {
      showSnackBar(context, "Failed to Fetch Data");
    }, (r) {
      _ref.read(userProvider.notifier).update((state) => r);
    });
  }

  Future<UserModal> addPicture(
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
        debugPrint("imageurl$r");
        if (imageType == ImageType.cardPicture) {
          userModal = userModal.copyWith(cardPicture: r);
        } else {
          userModal = userModal.copyWith(profilePicture: r);
        }
      });
    }
    return userModal;
  }

  void addUserToDatabase({
    required UserModal userModal,
    required VoidCallback callToStop,
    required BuildContext context,
    File? profilePicture,
    String? profilePictureUniqueId,
    File? cardPicture,
    String? cardPictureUniqueId,
    String? profilePicturePath,
    String? cardPicturePath,
    required String uiqueId,
  }) async {
    debugPrint("call here 1");
    userModal = await addPicture(
        context: context,
        userModal: userModal,
        imageType: ImageType.profilePicture,
        picture: profilePicture,
        path: profilePicturePath,
        uniqueId: profilePictureUniqueId);
    debugPrint("call here 2$userModal");
    // ignore: use_build_context_synchronously
    userModal = await addPicture(
        context: context,
        userModal: userModal,
        imageType: ImageType.cardPicture,
        picture: cardPicture,
        path: cardPicturePath,
        uniqueId: cardPictureUniqueId);

    debugPrint("3$userModal");
    if (userModal.cardPicture.isNotEmpty &&
        userModal.profilePicture.isNotEmpty) {
      final res = await _userAPI.saveUserData(userModal, uiqueId);
      debugPrint("donewithres#$res");
      callToStop.call();
      res.fold((l) => showSnackBar(context, l.message),
          (r) => showSnackBar(context, "Data Saved Successfully"));
    }
  }
}
