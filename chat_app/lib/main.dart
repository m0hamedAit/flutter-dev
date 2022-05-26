import 'package:contact_app/bloc/contact/Contact_bloc.dart';
import 'package:contact_app/bloc/contact/Contact_state.dart';
import 'package:contact_app/bloc/message/Message_bloc.dart';
import 'package:contact_app/bloc/message/Message_state.dart';
import 'package:contact_app/repositories/ContactRepository.dart';
import 'package:contact_app/repositories/MessageRepository.dart';
import 'package:contact_app/theme/colors/light_colors.dart';
import 'package:contact_app/ui/pages/ContactPage.dart';
import 'package:contact_app/ui/pages/MessagesPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/message/Message_event.dart';
import 'model/Contact.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: LightColors.kLightYellow, // navigation bar color
    statusBarColor: Color(0xffffb969), // status bar color
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create:(context)=>ContactBloc(ContactState([],RequestStatus.NONE,""), ContactRepository())),
          BlocProvider(create: (context)=>MessageBloc(initialState: MessageState(messages: [],currentEvent: ContactMessageEvent(contact: Contact()), errorMessage: ''), messageRepository: MessageRepository()))
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,  // remove debug banner
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: Theme.of(context).textTheme.apply(
                bodyColor: LightColors.kDarkBlue,
                displayColor: LightColors.kDarkBlue,
                fontFamily: 'Poppins'
            ),
          ),
          routes: {
            "/contacts":(context) => ContactPage(),
            "/messages":(context) => MessagesPage(),
          },
          initialRoute: '/contacts',
        )
    );
  }
}
