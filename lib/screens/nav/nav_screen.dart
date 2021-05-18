import 'package:flutter/material.dart';

class NavScreen extends StatelessWidget {
  static final routeName = "nav";

  const NavScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text('Nav Screen'),
          ),
          body: Center(
            child: Text('Nav screen'),
          )),
    );
    ;
  }
}
