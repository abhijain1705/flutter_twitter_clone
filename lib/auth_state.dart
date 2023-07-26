import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/auth/view/onboarding_view.dart';
import 'package:twitter_clone/features/home/view/home_view.dart';
import 'package:twitter_clone/modals/user_modal.dart';

class AuthState extends ConsumerStatefulWidget {
  final String phoneNumber;
  final String uid;
  const AuthState({super.key, required this.phoneNumber, required this.uid});

  @override
  ConsumerState<AuthState> createState() => _AuthStateState();
}

class _AuthStateState extends ConsumerState<AuthState> {
  // This widget is the root of your application.
  bool isLoading = false;

  getData(WidgetRef ref) {
    setState(() {
      isLoading = true;
    });
    ref.watch(authControllerProvider.notifier).currentUserDocumentData(
        uniqueId: widget.uid,
        context: context,
        callback: () {
          setState(() {
            isLoading = false;
          });
        });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getData(ref);
  }

  @override
  Widget build(BuildContext context) {
    UserModal? cbUser = ref.watch(userProvider);
    debugPrint("fasf$cbUser");
    return Scaffold(
      body: isLoading
          ? const Center(child: Loader())
          : cbUser == null
              ? const OnboardingView()
              : const HomeView(),
    );
  }
}

// RegisterView(
//                   phoneNumber: user.phoneNumber!,
//                   uid: user.uid,
//                 );