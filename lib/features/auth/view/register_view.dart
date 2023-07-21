import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/constants/ui_constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twitter_clone/core/utils.dart';
import 'package:twitter_clone/theme/pallete.dart';
import '../../../constants/assets_constants.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

enum ImageType {
  profileImage,
  cardImage,
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController ownerName = TextEditingController();
  TextEditingController shopName = TextEditingController();
  TextEditingController shopAddress = TextEditingController();
  TextEditingController pinCode = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController document = TextEditingController();
  File? profileImage;
  File? cardImage;

  Future<void> pickImage(ImageType imageType) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image != null) {
        File img = File(image.path);
        setState(() {
          if (imageType == ImageType.profileImage) {
            profileImage = img;
          } else if (imageType == ImageType.cardImage) {
            cardImage = img;
          }
        });
      }
    } on PlatformException catch (e) {
      debugPrint('sadcd${e.toString()}');
      showSnackBar(context, "Error In Opening Camera");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIConstants.appbar(() {}, false),
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  child: profileImage == null
                      ? SvgPicture.asset(
                          AssetsConstants.emojiIcon,
                        )
                      : CircleAvatar(
                          radius: 50,
                          backgroundImage: FileImage(profileImage!.absolute),
                        ),
                ),
                OutlinedButton(
                  child: const Text("upload"),
                  onPressed: () {
                    // Perform some action here
                    pickImage(ImageType.profileImage);
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                InputField(
                  hintText: "Owner Name",
                  controller: ownerName,
                  textColor: Pallete.backgroundColor,
                ),
                const SizedBox(
                  height: 15,
                ),
                InputField(
                  hintText: "Shop Name",
                  controller: shopName,
                  textColor: Pallete.backgroundColor,
                ),
                const SizedBox(
                  height: 15,
                ),
                InputField(
                  hintText: "Shop Address",
                  controller: shopAddress,
                  textColor: Pallete.backgroundColor,
                ),
                const SizedBox(
                  height: 15,
                ),
                InputField(
                  hintText: "Pin Code",
                  controller: pinCode,
                  textColor: Pallete.backgroundColor,
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () async {
                    await pickImage(ImageType.cardImage);
                  },
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: cardImage == null
                        ? const Center(
                            child: Text("Pick Card"),
                          )
                        : Image.file(cardImage!.absolute, fit: BoxFit.cover,),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                InputField(
                  hintText: "Pan card/Aadhar card",
                  controller: document,
                  textColor: Pallete.backgroundColor,
                ),
                const SizedBox(
                  height: 15,
                ),
                RoundedSmallButton(onTap: () {}, label: "Register Business", backgroundColor: Pallete.backgroundColor, textColor: Pallete.whiteColor,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}