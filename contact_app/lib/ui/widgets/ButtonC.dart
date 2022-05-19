

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Constants.dart';
import '../../bloc/Contact_bloc.dart';
import '../../bloc/Contact_event.dart';

class ButtonC extends StatelessWidget{
   String text;
   ContactEvent event;


  // ignore: use_key_in_widget_constructors
  ButtonC( this.text, this.event);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: (){
          context.read<ContactBloc>().add(event);
        },
        child: Text(text,
          style: const TextStyle(
            color: Colors.white,
          ),),

      style: ElevatedButton.styleFrom(
          primary: (context.read<ContactBloc>().lastEvent == text)?Colors.lightBlue:primaryColor,
          onPrimary: backgroundColor,
          minimumSize: const Size(88, 36),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
      ),
    );
  }

}