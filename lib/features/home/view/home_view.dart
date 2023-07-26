import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/constants/ui_constants.dart';
import 'package:twitter_clone/features/home/view/profile_view.dart';
import 'package:twitter_clone/theme/pallete.dart';

class HomeView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const HomeView(),
      );
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);
    return Scaffold(
      key: _scaffoldKey,
      appBar: UIConstants.appbar(() {
        Navigator.of(context).push(ProfileView.route());
      }, true),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              TabBar(
                controller: tabController,
                labelColor: Pallete.backgroundColor,
                tabs: const [
                  Tab(
                    text: "Good Reviews",
                  ),
                  Tab(
                    text: "Bad Reviews",
                  ),
                ],
              ),
              Flexible(
                  child: TabBarView(
                controller: tabController,
                children: [Text("data"), Text("data")],
              ))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your onPressed code here!
          },
          backgroundColor: Pallete.blueColor,
          child: const Icon(Icons.add)),
    );
  }
}
