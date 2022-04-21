
import 'dart:convert';

import '../constants.dart';
import '../widgets/SearchBox.dart';
import 'package:flutter/material.dart';
import '../widgets/App_Bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:multiple_services/constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/Expansion_card.dart';


class News extends StatefulWidget{

  @override
  State<News> createState() => _NewsState();
}

List<Widget> bodyElements = [];

_launchURLBrowser(String url) async {
  if (await canLaunch(url)) {
    await launch(url, forceSafariVC: true, forceWebView: true);
  } else {
    throw 'Could not launch $url';
  }
}

void addBodyElement(news) {
  bodyElements = [];
  for(int i=0; i<news["articles"].length;i++) {
    bodyElements.add(
      Padding(
        padding: const EdgeInsets.all(5),
        child: ExpansionCard(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  // Stroked text as border.
                  Text(
                    news["articles"][i]["title"],

                    style: TextStyle(
                      fontFamily: 'BalooBhai',
                      fontSize: 15.0,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 6
                        ..color = Colors.black,
                    ),
                  ),
                  // Solid text as fill.
                  Text(
                    news["articles"][i]["title"],
                    style: TextStyle(
                      fontFamily: 'BalooBhai',
                      fontSize: 15.0,
                      color: Colors.grey[300],
                    ),
                  ),
                ],
              ),
            //Tag
            Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 5.0,
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 10.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  child: Text(
                    news["articles"][i]["author"],
                    style: TextStyle(
                      fontFamily: 'BalooBhai',
                      color: Colors.grey[300],
                      fontSize: 11.0,
                    ),
                  ),
                ),
              ),
              ]
            )
            ],
          ),
          children: [
            ElevatedButton(
              style: raisedButtonStyle,
              onPressed: ()  {
                String url = news["articles"][i]["url"];
                url!=null
                    ? _launchURLBrowser(url)
                    :Fluttertoast.showToast(
                    msg: "Can't reach Article's page",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.lightBlue,
                    textColor: Colors.black,
                    fontSize: 13.0
                );
              },
              child: Text('Read'),
            )
          ],

          gif: news["articles"][i]["urlToImage"].toString()!=null ? news["articles"][i]["urlToImage"].toString(): null ,


        ),
      ),
    );
  }
}

class _NewsState extends State<News> {

  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var news;

    void searchNewsByKey(keyword){
      String url="https://newsapi.org/v2/everything?q=$keyword&apiKey=3d7d33afce2b4bb6942bdd93fc5e01d9";
      http.get(Uri.parse(url))
          .then((response) {
        setState(() {
           news = json.decode(response.body);
           addBodyElement(news);
        });
      }).catchError((onError){
        print(onError);
      });
    }

    return Scaffold(
      appBar: const AppBarr("News"),
      body:Column(
          children: <Widget>[
            SizedBox(
                height: size.height * 0.2,  // get 0.2 of screen height
                child:Stack(
                    children:<Widget>[
                      Container(
                        height: size.height * 0.2 - 20,
                        decoration: const BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50),
                            )
                        ),
                      ),

                      Container(
                          height:40,
                          margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                          child: Stack(
                            children: [
                              TextFormField(
                                controller: textController,
                                decoration: InputDecoration(
                                    labelText: "Enter keyword",
                                    labelStyle: const TextStyle(
                                      color: Colors.white,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(width: 1, color: Colors.white),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(width: 1, color: secondaryColor),
                                      borderRadius: BorderRadius.circular(15),
                                    )),
                              )

                            ],
                          )

                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          left: 0,
                          child:InkWell( // make container clickable
                            child: Container(
                              padding: const EdgeInsets.all(9.0),
                              margin: const EdgeInsets.symmetric(horizontal: 100),
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: const Offset(0,10),
                                      blurRadius: 50,
                                      color: primaryColor.withOpacity(0.3),
                                    ),
                                  ]
                              ),
                              child: const Text(
                                'Search',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            // ignore: avoid_print
                            onTap:() {
                              setState(() {
                                searchNewsByKey(textController.text);
                              });
                            }

                          )
                        // TODO : add search icon
                      )

                    ]
                )


            ),
            Expanded(child:
              ListView(
                children: <Widget>[
                  Column(
                  children: bodyElements,
                ),
              ],
            ),
            )
            /*Expanded(
                child: ExpansionCard(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(news["articles"][1]["title"]),
                          Text(news["articles"][1]["author"]),
                        ],
                      ),
                      gif: news["articles"][1]["urlToImage"],
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 7),
                          child: Text(news["articles"][1]["description"]),
                        )
                      ],

                  ),

            ),*/

          ]
      )



    );

  }
}