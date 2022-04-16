

import 'package:flutter/material.dart';
import '../constants.dart';

class SearchBox extends StatelessWidget{
  String text;
  TextEditingController textEditingController;
  SearchBox(this.text, this.textEditingController );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
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
                              decoration: InputDecoration(
                                  labelText: text,
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
                            padding: EdgeInsets.all(9.0),
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
                          onTap: ()=> print("touched"),

                        )
                      // TODO : add search icon
                    )

                  ]
              )


          )
        ]
    );
  }
}