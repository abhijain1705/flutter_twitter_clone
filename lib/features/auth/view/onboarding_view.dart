import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/constants/assets_constants.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/core/providers.dart';
import 'package:twitter_clone/core/utils.dart';
import 'package:twitter_clone/features/auth/view/otp_view.dart';
import 'package:twitter_clone/theme/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OnboardingView extends ConsumerStatefulWidget {
  const OnboardingView({Key? key}) : super(key: key);

  static String verificationId = '';

  @override
  ConsumerState<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends ConsumerState<OnboardingView> {
  final TextEditingController numberController = TextEditingController();
  @override
  void initState() {
    super.initState();
    // Fetch the SIM mobile number when the view is loaded
    getSimMobileNumber();
  }

  Future<void> getSimMobileNumber() async {
    if (!mounted) return;
    final phoneNumber = await SmsAutoFill().hint;
    if (phoneNumber == null) return;
    if (!mounted) return;
    numberController.text = phoneNumber;
    getOtp();
  }

  bool loading = false;
  Future getOtp() async {
    if (numberController.text.length < 10) {
      showSnackBar(context, "Please write correct Phone Number");
      return;
    }
    try {
      setState(() {
        loading = true;
      });
      await ref.watch(fireAuthProvider).verifyPhoneNumber(
          phoneNumber: numberController.text.startsWith("+91")
              ? numberController.text
              : "+91${numberController.text}",
          verificationCompleted: (PhoneAuthCredential credential) async {
            loading = false;
            await ref.watch(fireAuthProvider).signInWithCredential(credential);
          },
          verificationFailed: (FirebaseAuthException e) {
            setState(() {
              loading = false;
            });
            showSnackBar(context, e.toString());
          },
          codeSent: (verificationId, forceResendingToken) async {
            setState(() {
              loading = false;
            });
            OnboardingView.verificationId = verificationId;
            Navigator.push(context, OTPView.route());
          },
          codeAutoRetrievalTimeout: (String verificationId) {});
    } catch (e) {
      setState(() {
        loading = false;
      });
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
          color: Pallete.blueColor,
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
                      RoundedSmallButton(
                        onTap: getOtp,
                        label: "Get OTP",
                        loading: loading,
                      )
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
