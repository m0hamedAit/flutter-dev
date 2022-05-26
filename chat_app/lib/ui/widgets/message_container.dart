import 'package:contact_app/model/Message.dart';
import 'package:contact_app/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';


class MessageContainer extends StatelessWidget {
  final String content;
  final Type received;

  MessageContainer({Key? key,
    required this.content, required this.received
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return

      /*Flexible(
      child: Row(
        mainAxisAlignment: received==Type.RECEIVED?MainAxisAlignment.start: MainAxisAlignment.end,
        crossAxisAlignment: received==Type.RECEIVED?CrossAxisAlignment.start:CrossAxisAlignment.start,
        children: <Widget>[
            received==Type.RECEIVED?Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(pi),
              child: CustomPaint(
                painter: CustomShape(Colors.grey),
              ),
            ) : SizedBox(),
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: received==Type.RECEIVED?Colors.cyan[300]:Colors.grey[300],
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(18),
                    bottomLeft: Radius.circular(18),
                    bottomRight: Radius.circular(18),
                  ),
                ),
                child: Text(
                  content,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ),

          ],

        ));*/
      Container(
      margin: received==Type.RECEIVED?const EdgeInsets.only(left: 20, right: 150, top:20):const EdgeInsets.only(left: 150, right: 20, top:20),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            content,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
          color: received==Type.RECEIVED?LightColors.kDarkYellow:LightColors.kDarkBlue,
          borderRadius: BorderRadius.circular(30.0)),
    );
  }
}