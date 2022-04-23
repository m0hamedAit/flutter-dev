
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../widgets/CountryStats.dart';


class ListCountriesState extends ChangeNotifier{
  List<CountryStats> countries = [];
  List<CountryStats> data = [];

  void addNews(CountryStats country){
    countries.add(country);
    notifyListeners();
  }

  void emptyList(){
    countries = [];
    notifyListeners();
  }

  Future searchStats() async{
    countries = [];
    String url="https://covid-api.mmediagroup.fr/v1/cases";
    await http.get(Uri.parse(url))
        .then((response) {

        Map stats = json.decode(response.body);
        stats.forEach((k, v){
          Map data = v;
          data.forEach((k2, v2) {
            var flag = v2["abbreviation"].toString().toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
                    (match) => String.fromCharCode((match.group(0)?.codeUnitAt(0))!+127397));
            if(v2["country"]!=null && v2["population"]!=null && v2["confirmed"]!=null
                && v2["deaths"]!=null) {
              CountryStats country = CountryStats(
                  v2["country"].toString(), flag, v2["population"].toString(),
                  v2["confirmed"].toString(), v2["deaths"].toString());
              countries.add(country);
            }
          });
        });

    }).catchError((onError){
      print(onError.toString());
      Fluttertoast.showToast(
          msg: "Can't get data",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.lightBlue[50],
          textColor: Colors.black,
          fontSize: 13.0
      );
    });

    notifyListeners();
  }



  void searchStatsByCountry(Keyword) {
    data = [];
    countries = [];
    searchStats();
    for (var element in countries) {
      if(element.name.toLowerCase().contains(Keyword.toLowerCase())==true){
        data.add(element);
      }
    }

    for(var e in data) {
      countries.add(e);
    }
    notifyListeners();
  }

}