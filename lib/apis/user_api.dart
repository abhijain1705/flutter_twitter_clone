import 'package:appwrite/appwrite.dart';
import 'package:twitter_clone/core/core.dart';

abstract class IUserAPI {
  FutureEitherVoid saveUserData();
}

class UserAPI implements IUserAPI {
  @override
  FutureEitherVoid saveUserData() {
    throw UnimplementedError();
  }
}
