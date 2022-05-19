import 'package:contact_app/bloc/Contact_bloc.dart';
import 'package:contact_app/bloc/Contact_state.dart';
import 'package:contact_app/repositories/ContactRepository.dart';
import 'package:contact_app/ui/pages/ContactPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create:(context)=>ContactBloc(ContactState([],RequestStatus.None,""), ContactRepository()))
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,  // remove debug banner
          theme: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            scaffoldBackgroundColor: backgroundColor ,
            primaryColor: backgroundColor,
            textTheme: Theme.of(context).textTheme.apply(bodyColor: tColor),
          ),
          routes: {
            "/contacts":(context) => const ContactPage(),
          },
          initialRoute: '/contacts',
        )
    );
  }
}
