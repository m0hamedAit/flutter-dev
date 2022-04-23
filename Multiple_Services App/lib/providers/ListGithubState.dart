

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ListGithubState extends ChangeNotifier{
  var users;

  void addNews(dynamic user){
    users.add(user);
    notifyListeners();
  }

  void emptyList(){
    users = null;
    notifyListeners();
  }

  Future searchGithubUser(userKey) async{
    String url="https://api.github.com/search/users?q=${userKey}&per_page=50&page=0";
    await http.get(Uri.parse(url))
        .then((response) {
        users = json.decode(response.body);
    }).catchError((onError){
      print(onError);
    });
    notifyListeners();
  }

}