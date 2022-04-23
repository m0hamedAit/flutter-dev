

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multiple_services/screens/News.dart';
import 'package:multiple_services/widgets/Expansion_card.dart';
import 'package:url_launcher/url_launcher.dart';

const primaryColor = Color(0xff292935);
const secondaryColor = Color(0xff007fff);
const backgroundColor = Color(0xff2F3140);
const tColor = Color(0xffffffff);
const defaultBackground = "https://images.alphacoders.com/812/thumb-1920-81223.jpg";

final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  onPrimary: backgroundColor,
  primary: Colors.white,
  minimumSize: Size(88, 36),
  padding: EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(30)),
  ),
);


