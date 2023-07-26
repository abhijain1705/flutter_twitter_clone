import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/auth_state.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/auth/view/onboarding_view.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:twitter_clone/theme/theme.dart';
import 'package:stack_trace/stack_trace.dart' as stack_trace;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    await Firebase.initializeApp();
    await FirebaseAppCheck.instance.activate(
        webRecaptchaSiteKey: '6LdPykUnAAAAACN9oKt4HgQasJyyi3_l5lqezltK',
        androidProvider: AndroidProvider.playIntegrity);
    runApp(const ProviderScope(child: MyApp()));
  });
  FlutterError.demangleStackTrace = (StackTrace stack) {
    if (stack is stack_trace.Trace) return stack.vmTrace;
    if (stack is stack_trace.Chain) return stack.toTrace().vmTrace;
    return stack;
  };
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        home: ref.watch(authStateChangeProvider).when(
            data: (user) {
              if (user != null) {
                return AuthState(
                  phoneNumber: user.phoneNumber ?? '',
                  uid: user.uid,
                );
              }
              return const OnboardingView();
            },
            error: (error, st) => ErrorPage(text: error.toString()),
            loading: () => const LoadingPage()));
  }
}
