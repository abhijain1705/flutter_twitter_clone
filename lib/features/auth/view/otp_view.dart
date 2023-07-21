import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/core/providers.dart';
import 'package:twitter_clone/core/utils.dart';
import 'package:twitter_clone/features/auth/view/onboarding_view.dart';
import 'package:twitter_clone/features/home/view/home_view.dart';
import 'package:twitter_clone/theme/pallete.dart';

class OTPView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const OTPView(),
      );
  const OTPView({super.key});

  @override
  ConsumerState<OTPView> createState() => _OTPViewState();
}

class _OTPViewState extends ConsumerState<OTPView> with CodeAutoFill {
  final TextEditingController otpController = TextEditingController();
  String _code = ''; // Add this variable to store the OTP code.

  String? appSignature;
  String? otpCode;

  @override
  void codeUpdated() {
    debugPrint("dfwdfr$code");
    setState(() {
      _code = code!;
    });
  }

  @override
  void initState() {
    super.initState();
    listenForCode();

    SmsAutoFill().getAppSignature.then((signature) {
      setState(() {
        appSignature = signature;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    cancel();
  }

  bool loading = false;

  Future verifyOTP() async {
    setState(() {
      loading = true;
    });
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: OnboardingView.verificationId,
        smsCode: otpController.text);

    await ref
        .watch(fireAuthProvider)
        .signInWithCredential(credential)
        .then((value) {
      setState(() {
        loading = false;
      });
      showSnackBar(context, "OTP Verifies Successully");
      Future.delayed(const Duration(seconds: 2), () {
        HomeView.route();
      });
    }).catchError((e) {
      setState(() {
        loading = false;
      });
      showSnackBar(
        context,
        e.toString(),
      );
    });
    // Show Snackbar after successful verification
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Enter the code we texted you"),
                const SizedBox(
                  height: 15,
                ),
                PinFieldAutoFill(
                  currentCode: _code,
                  onCodeSubmitted: (code) {},
                  onCodeChanged: (code) {
                    if (code!.length == 6) {
                      FocusScope.of(context).requestFocus(FocusNode());
                    }
                  },
                  controller: otpController,
                ),
                // InputField(
                //   hintText: "Enter Code",
                //   controller: otpController,
                //   isPhoneNumber: true,
                //   textColor: Pallete.backgroundColor,
                // ),
                const SizedBox(
                  height: 15,
                ),
                RoundedSmallButton(
                  onTap: verifyOTP,
                  label: "Verify",
                  textColor: Pallete.whiteColor,
                  loading: loading,
                  backgroundColor: Pallete.backgroundColor,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
