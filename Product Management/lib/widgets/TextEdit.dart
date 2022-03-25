
import 'dart:ui';

import 'package:flutter/material.dart';

class TextEdit extends StatelessWidget{
  final String _name ;
  final TextEditingController _controller;

  TextEdit(this._name, this._controller);

  @override
  Widget build(BuildContext context) {
    return Row(
        children: <Widget>[
            Text(_name, style: const TextStyle(fontSize: 18, color: Colors.grey, fontFamily: "Ubuntu", fontWeight: FontWeight.w600)),
            Expanded(child:TextField(
              controller: _controller,
              style: const TextStyle(fontSize: 15,color: Colors.black, fontFamily: "Ubuntu", fontWeight: FontWeight.w400),
            )),

    ]

    );
  }


}