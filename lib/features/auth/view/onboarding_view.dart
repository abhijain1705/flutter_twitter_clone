import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/constants/assets_constants.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/core/providers.dart';
import 'package:twitter_clone/core/utils.dart';
import 'package:twitter_clone/features/auth/view/otp_view.dart';
import 'package:twitter_clone/theme/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingView extends ConsumerStatefulWidget {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  ConsumerState<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends ConsumerState<OnboardingView> {
  final TextEditingController numberController = TextEditingController();

  Future getOtp() async {
    try {
      await ref.watch(fireAuthProvider).verifyPhoneNumber(
          phoneNumber: numberController.text.startsWith("+91")
              ? numberController.text
              : "+91${numberController.text}",
          verificationCompleted: (PhoneAuthCredential credential) async {
            await ref.watch(fireAuthProvider).signInWithCredential(credential);
          },
          verificationFailed: (FirebaseAuthException e) {
            showSnackBar(context, e.toString());
          },
          codeSent: (verificationId, forceResendingToken) async {
            String smsCode = '';
            PhoneAuthCredential credential = PhoneAuthProvider.credential(
                verificationId: verificationId, smsCode: smsCode);
            Navigator.push(context, OTPView.route());
            await ref.watch(fireAuthProvider).signInWithCredential(credential);
          },
          codeAutoRetrievalTimeout: (String verificationId) {});
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: const Color.fromRGBO(82, 105, 247, 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Image.asset(
                  AssetsConstants.onboardingImage,
                  fit: BoxFit.contain,
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: const TextSpan(
                          style: TextStyle(
                              color: Pallete.whiteColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(text: 'Continue with your'),
                            TextSpan(text: '\nmobile number'),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InputField(
                        hintText: "+91 9876543210",
                        controller: numberController,
                        isPhoneNumber: true,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      RoundedSmallButton(onTap: () {}, label: "Get OTP")
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
