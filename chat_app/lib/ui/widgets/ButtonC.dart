

import 'package:contact_app/theme/colors/light_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/contact/Contact_bloc.dart';
import '../../bloc/contact/Contact_event.dart';

class ButtonC extends StatelessWidget{
   String text;
   ContactEvent event;


  // ignore: use_key_in_widget_constructors
  ButtonC( this.text, this.event);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: (){
          context.read<ContactBloc>().add(event);  // envoyer nouveau state
        },
        child: Text(text,
          style: const TextStyle(
            color: Colors.white,
          ),),

      style: ElevatedButton.styleFrom(
          primary: (context.read<ContactBloc>().lastEvent == text)?LightColors.kDarkBlue:LightColors.kDarkYellow,
          onPrimary: LightColors.kBlue,
          minimumSize: const Size(88, 36),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
      ),
    );
  }

}