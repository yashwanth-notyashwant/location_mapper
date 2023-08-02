import 'package:flutter/material.dart';

import '../models/user.dart';

class Profile extends StatefulWidget {
  final User loadedUser;

  Profile(this.loadedUser);

  @override
  State<Profile> createState() => _ProfileState();

  static const routeName = '/user-detail-screen';
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    setState(() {
      //
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var devicelength = MediaQuery.of(context).size.height;

    return widget.loadedUser.id == ''
        ? MaterialApp(
            theme: ThemeData.dark(),
            home: Scaffold(
              body: Center(
                child: Text('To view profile Signup'),
              ),
            ),
          )
        : MaterialApp(
            theme: ThemeData.dark(),
            home: Scaffold(
              body: SingleChildScrollView(
                child: Column(children: [
                  sbox(15),
                  const Text(
                    ' ',
                    style: TextStyle(fontSize: 25),
                  ),
                  sbox(5),
                  const Divider(
                    thickness: 3,
                    indent: 20,
                    endIndent: 20,
                  ),
                  sbox(15),
                  ListTile(
                    title: Text(
                      'Name',
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    subtitle: Text(widget.loadedUser.name),
                  ),
                  Divider(indent: 30, endIndent: 30),
                  sbox(15),
                  ListTile(
                    title: Text(
                      'Current Password ',
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    subtitle: Text(widget.loadedUser.password),
                  ),
                  Divider(indent: 30, endIndent: 30),
                  sbox(15),
                  ListTile(
                    title: Text(
                      'Mail address  ',
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    subtitle: Text(widget.loadedUser.mail),
                  ),
                  Divider(indent: 30, endIndent: 30),
                  sbox(15),
                  Container(
                    height: 20,
                    width: deviceWidth - 20,
                    child: Text(
                      '    Address',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  sbox(15),
                  Container(
                    width: deviceWidth - 60,
                    height: devicelength - 680,
                    child: Text(widget.loadedUser.address),
                  ),
                  sbox(30),
                  sbox(30),
                ]),
              ),
            ),
          );
  }
}

Widget sbox(double? size) {
  return SizedBox(
    height: size,
  );
}
