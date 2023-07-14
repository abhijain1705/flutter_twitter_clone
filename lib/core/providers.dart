import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/constants/appwrite_constants.dart';

final appwriteClientProvider = Provider<Client>((ref) {
  Client client = Client();
  client
      .setEndpoint(AppwriteConstants.endPoint)
      .setProject(AppwriteConstants.projectId)
      .setSelfSigned(status: true);
  return client;
});

final appwriteAccountProvider = Provider((ref) {
  final client = ref.watch(appwriteClientProvider);
  return Account(client);
});
