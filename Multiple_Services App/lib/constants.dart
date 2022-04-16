

import 'package:flutter/material.dart';

const primaryColor = Color(0xff292935);
const secondaryColor = Color(0xff007fff);
const backgroundColor = Color(0xff2F3140);
const tColor = Color(0xffffffff);

final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  onPrimary: backgroundColor,
  primary: Colors.white,
  minimumSize: Size(88, 36),
  padding: EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(30)),
  ),
);