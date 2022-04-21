import 'package:flutter/material.dart';
import 'package:multiple_services/widgets/App_Bar.dart';

import '../constants.dart';
import '../widgets/App_drawer.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: AppDrawer(),
      appBar: const AppBarr(""),
      body: Column(
        children: <Widget>[
          SizedBox(
              height: size.height * 0.2, // get 0.2 of screen height
              child: Stack(children: <Widget>[
                Container(
                  height: size.height * 0.2 - 20,
                  decoration: const BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      )),
                ),
              ])),
          GridView.count(
            crossAxisCount: 2,
            children: [
              InkWell(
                child: Container(
                  decoration: const BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.newspaper,
                        color: Colors.white,
                      ),
                      Text("News", style: TextStyle(color: Colors.white))
                    ],
                  ),
                ),
                onTap: (){
                  Navigator.of(context).pushNamed("/news");
                },
              ),

              InkWell(
                child: Container(
                  decoration: const BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.supervised_user_circle,
                        color: Colors.white,
                      ),
                      Text("Github Users",
                          style: TextStyle(color: Colors.white))
                    ],
                  ),
                ),
                onTap: (){
                  Navigator.of(context).pushNamed("/github");
                },
              ),

              InkWell(
                child: Container(
                  decoration: const BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.airplay_rounded,
                        color: Colors.white,
                      ),
                      Text("Covid 19", style: TextStyle(color: Colors.white))
                    ],
                  ),
                ),
                onTap: (){
                  Navigator.of(context).pushNamed("/covid");
                },
              ),

              InkWell(
                child: Container(
                  decoration: const BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.error,
                        color: Colors.white,
                      ),
                      Text("About", style: TextStyle(color: Colors.white))
                    ],
                  ),
                ),

              ),
            ],
            padding: const EdgeInsets.all(10),
            shrinkWrap: true,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          )
        ],
      ),
    );
  }
}
