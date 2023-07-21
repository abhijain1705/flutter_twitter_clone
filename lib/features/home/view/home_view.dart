import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twitter_clone/constants/ui_constants.dart';
import 'package:twitter_clone/theme/pallete.dart';
import '../../../constants/assets_constants.dart';

class HomeView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const HomeView(),
      );
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: UIConstants.appbar(() {
          _scaffoldKey.currentState?.openDrawer();
        }, true),
        body: Center(
          child: Text("hello world"),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                title: Text("Helo bro"),
              ),
              ListTile(
                title: Text("how are you"),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Add your onPressed code here!
            },
            backgroundColor: Pallete.blueColor,
            child: const Icon(Icons.add)),
      ),
    );
  }
}
