

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import '../widgets/Expansion_card.dart';

class ListArticlesState extends ChangeNotifier{
  // ignore: prefer_typing_uninitialized_variables
  var articles;
  List<Widget> articlesCard = [];

  void addNews(dynamic article){
    articlesCard.add(article);
    notifyListeners();
  }

  void emptyList(){
    articlesCard = [];
    notifyListeners();
  }

  _launchURLBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future searchNewsByKey(keyword) async{
    String url="https://newsapi.org/v2/everything?q=$keyword&apiKey=3d7d33afce2b4bb6942bdd93fc5e01d9";
     await http.get(Uri.parse(url))
        .then((response) {
        articles = json.decode(response.body);
      }).catchError((onError){
      print("onError : Importing articles");
    });

    notifyListeners();
  }

  Future searchNews() async{
    String url="https://newsapi.org/v2/top-headlines?country=us&apiKey=3d7d33afce2b4bb6942bdd93fc5e01d9";
    await http.get(Uri.parse(url))
        .then((response) {
      articles = json.decode(response.body);
      print(articles);
    }).catchError((onError){
      print("onError : Importing articles");
    });

    notifyListeners();
  }


  void addBodyElement() {
    articlesCard = [];
    for(int i=0; i<articles["articles"].length;i++) {
      articlesCard.add(
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
                      articles["articles"][i]["title"] ?? "",

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
                      articles["articles"][i]["title"] ?? "",
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
                            articles["articles"][i]["author"],
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
                  String url = articles["articles"][i]["url"];
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

            // ignore: unnecessary_null_comparison
            gif: articles["articles"][i]["urlToImage"] ?? defaultBackground ,
          ),
        ),
      );
    }
    notifyListeners();
  }

}