import 'package:flutter/material.dart';
import '../constants.dart';

import 'Drawer_item.dart';

class AppDrawer extends StatelessWidget {
@override
Widget build(BuildContext context) {
  return Drawer(
    backgroundColor: primaryColor,
    child: ListView(
      children: [
        DrawerHeader(child: Column(
          children: const [
            CircleAvatar(
              radius: 50,
            ),
            SizedBox(height: 10),
            Text("Mohamed AIT IHIE"),
          ],
        )),
        DrawerItem("Home","/",const Icon(Icons.home, color: Colors.white)),
        DrawerItem("Contacts","/contacts",const Icon(Icons.contacts, color: Colors.white)),
        DrawerItem("Github Users","/github",const Icon(Icons.supervised_user_circle, color: Colors.white)),
        DrawerItem("News","/news",const Icon(Icons.newspaper, color: Colors.white)),
        DrawerItem("Covid 19","/news",const Icon(Icons.airplay_rounded, color: Colors.white)),
        DrawerItem("About","/about",const Icon(Icons.error, color: Colors.white)),

      ],
    ),
  );
}
}
