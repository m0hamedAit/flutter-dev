
import '../constants.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class AppBarr extends StatelessWidget implements PreferredSizeWidget{
  final String title;

  const AppBarr( this.title);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: primaryColor,
        elevation: 0,// ?
        title: Text(title),
        //leading:IconButton(
          //icon: Image.asset("assets/menuIcon.png"),
          //onPressed: () => Scaffold.of(context).openDrawer(),
        //)
    );
  }

  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);
}