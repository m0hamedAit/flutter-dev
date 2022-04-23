import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:multiple_services/constants.dart';
import 'package:multiple_services/providers/ListGithubState.dart';
import 'package:multiple_services/widgets/App_Bar.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class GitHubUsers extends StatelessWidget {

  TextEditingController textController = TextEditingController();

  _launchURLBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  /*void searchGithubUser(userKey){
    String url="https://api.github.com/search/users?q=${userKey}&per_page=50&page=0";
    http.get(Uri.parse(url))
        .then((response) {
      setState(() {
        users= json.decode(response.body);
      });
    }).catchError((onError){
      print(onError);
    });
  }*/
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const AppBarr("Github"),
      body: Column(
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
                           Provider.of<ListGithubState>(context,listen: false)
                                  .searchGithubUser(textController.text);
                          }

                    )

                )

              ]
          )
      ),

          Expanded(
            child: Consumer<ListGithubState>(
            builder: (context, listUsers, child) {
              return ListView.builder(
                itemCount: listUsers.users==null || listUsers.users["items"] == null ? 0 : listUsers
                    .users["items"].length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          listUsers.users["items"][index]["avatar_url"]),
                    ),
                    title: Text(listUsers.users["items"][index]["login"]),
                    onTap: () {
                      _launchURLBrowser(
                          listUsers.users["items"][index]["html_url"]);
                    },
                  );
                },);
            })
            ),

          ],

        ),

    );
  }
}
