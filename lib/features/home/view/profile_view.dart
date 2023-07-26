import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/common/rounded_small_button.dart';
import 'package:twitter_clone/features/home/widgets/user_info.dart';
import 'package:twitter_clone/theme/pallete.dart';

class ProfileView extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const ProfileView(),
      );
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 4, vsync: this);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Pallete.backgroundColor,
          ),
        ),
        title: const Text(
          "Abhi Jain",
          style: TextStyle(color: Pallete.backgroundColor),
        ),
        actions: [
          RoundedSmallButton(
            onTap: () {},
            label: "Edit",
            backgroundColor: Pallete.backgroundColor,
            textColor: Pallete.whiteColor,
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              CachedNetworkImage(
                imageBuilder: (context, imageProvider) => Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
                imageUrl:
                    "https://firebasestorage.googleapis.com/v0/b/grow-2d103.appspot.com/o/creditBookUsers%2FprofilePictures%2FprofileImagesaiIf5HwQZOWGO6gYYvGKtS65eBh1-2023-07-22%2022%3A48%3A29.073761?alt=media&token=4131a2f8-ac25-4d06-9941-ac11d821a07c",
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              const Text("Abhi Jain"),
              const SizedBox(
                height: 10,
              ),
              const UserInfo(
                  icon: Icon(Icons.calendar_month),
                  label: "Joined on 24 July 2023"),
              const SizedBox(
                height: 10,
              ),
              const UserInfo(
                  icon: Icon(Icons.person_3), label: "Abhi Kumar Jain"),
              const SizedBox(
                height: 10,
              ),
              const UserInfo(icon: Icon(Icons.shop_2), label: "Code Sqaure"),
              const SizedBox(
                height: 10,
              ),
              const UserInfo(icon: Icon(Icons.location_on), label: "Newai"),
              const SizedBox(
                height: 10,
              ),
              TabBar(
                isScrollable: true,
                labelPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                controller: tabController,
                labelColor: Pallete.backgroundColor,
                tabs: const [
                  Tab(
                    text: "Good You Wrote",
                  ),
                  Tab(
                    text: "Bad You Wrote",
                  ),
                  Tab(
                    text: "Good You Recieve",
                  ),
                  Tab(
                    text: "Bad You Recieve",
                  ),
                ],
              ),
              Flexible(
                child: TabBarView(
                  controller: tabController,
                  children: [Text("sv"), Text("sv"), Text("sv"), Text("sv")],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
