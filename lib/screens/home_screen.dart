import '../screens/location.dart';
import '../screens/profile.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  HomeScreen(this.user);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: widget.user.id.isEmpty
            ? AppBar(
                title: Text("Guest mode "),
                centerTitle: true,
                bottom: TabBar(
                  controller: _tabController,
                  tabs: [
                    Tab(text: "Profile"),
                    Tab(text: "Location"),
                  ],
                ),
              )
            : AppBar(
                title: Text(" User mode  "),
                centerTitle: true,
                bottom: TabBar(
                  controller: _tabController,
                  tabs: [
                    Tab(text: "Profile"),
                    Tab(text: "Location"),
                  ],
                ),
              ),
        body: TabBarView(
          controller: _tabController,
          children: [
            Profile(widget.user),
            Location(),
          ],
        ),
      ),
    );
  }
}
