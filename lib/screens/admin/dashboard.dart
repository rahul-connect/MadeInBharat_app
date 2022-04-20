import 'package:flutter/material.dart';
import '../../model/user.dart';

class DashBoard extends StatefulWidget {
  final User user;

  const DashBoard({Key key, this.user}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Dashboard"),
      ),
      
    );
  }
}