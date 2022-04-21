

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:multiple_services/CountryStats.dart';
import 'package:multiple_services/constants.dart';
import '../widgets/App_Bar.dart';


class CovidStats extends StatefulWidget{
  @override
  State<CovidStats> createState() => _CovidStatsState();
}


class _CovidStatsState extends State<CovidStats> {

  List<CountryStats> countries = [];
  List<CountryStats> data = [];
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
    searchStats();
    });
  }

  void searchStatsByCountry(Keyword){
    searchStats();
    for (var element in countries) {
      if(element.name.toString().toLowerCase().contains(Keyword.toLowerCase())){
        data.add(element);
      }
    }
    countries = data;
  }

  void searchStats(){
    countries = [];
    String url="https://covid-api.mmediagroup.fr/v1/cases";
    http.get(Uri.parse(url))
        .then((response) {
      setState(() {
        Map stats = json.decode(response.body);
        //var data = [];
        stats.forEach((k, v){
          Map data = v;
          data.forEach((k, v) {
            var flag = v["abbreviation"].toString().toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
                    (match) => String.fromCharCode((match.group(0)?.codeUnitAt(0))!+127397));
            if(v["country"]!=null && v["population"]!=null && v["confirmed"]!=null && v["deaths"]!=null && flag!=null) {
              CountryStats country = CountryStats(
                  v["country"].toString(), flag, v["population"].toString(),
                  v["confirmed"].toString(), v["deaths"].toString());
              countries.add(country);
            }
          });
        });
      });
    }).catchError((onError){
      print(onError.toString());
      Fluttertoast.showToast(
          msg: "Can't get data from API",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.lightBlue[50],
          textColor: Colors.black,
          fontSize: 13.0
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: const AppBarr("Covid-19"),
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
                                labelText: "Enter country...",
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
                              searchStatsByCountry(textController.text);
                            });
                          }

                      )
                    // TODO : add search icon
                  )

                ]
            )
        ),
              Expanded(
                child: ListView.builder(
                  itemCount:countries.length,
                  itemBuilder: (context, index) {
                    return Card(
                        elevation: 6,
                        color: primaryColor,
                        margin: EdgeInsets.all(10),
                        child:ListTile(
                          leading: CircleAvatar(
                            child: Text(countries[index].flag),
                            backgroundColor: Colors.transparent,
                          ),
                        title:RichText(
                          text: TextSpan(
                            children:<TextSpan>[
                              TextSpan(
                                text: countries[index].name+"\n",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                )
                              ),
                              TextSpan(
                                text: "\t\tPopulation : "+ countries[index].population+"\n",
                                style: const TextStyle(
                                  color: secondaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                                TextSpan(
                                text: "\t\tConfirmed : "+ countries[index].confirmed+"\n",
                                style: const TextStyle(
                                  color: Colors.deepOrangeAccent,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                                ),
                              TextSpan(
                                      text: "\t\tDeaths : "+ countries[index].deaths+"\n",
                                      style: const TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                              )
                            ]
                          ),
                        ),
                    )
                    );
                  },),
              ),

    ]


        )


    );
  }
}
