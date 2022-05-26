
import 'package:contact_app/bloc/contact/Contact_bloc.dart';
import 'package:contact_app/bloc/contact/Contact_state.dart';
import 'package:contact_app/ui/widgets/ButtonC.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../bloc/contact/Contact_event.dart';
import '../../bloc/message/Message_bloc.dart';
import '../../bloc/message/Message_event.dart';
import '../../theme/colors/light_colors.dart';
import '../widgets/top_container.dart';


class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  Text subheading(String title) {
    return Text(
      title,
      style: const TextStyle(
          color: LightColors.kDarkBlue,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2),
    );
  }

  static CircleAvatar calendarIcon() {
    return const CircleAvatar(
      radius: 25.0,
      backgroundColor: LightColors.kGreen,
      child: Icon(
        Icons.calendar_today,
        size: 20.0,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: LightColors.kLightYellow,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TopContainer(
              height: 150,
              width: width,
              padding: EdgeInsets.zero,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          CircularPercentIndicator(
                            radius: 90.0,
                            lineWidth: 5.0,
                            animation: true,
                            percent: 1,
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: LightColors.kBlue,
                            backgroundColor: LightColors.kDarkYellow,
                            center: const CircleAvatar(
                              backgroundColor: LightColors.kBlue,
                              radius: 35.0,
                              backgroundImage: AssetImage(
                                'assets/images/avatar.png',
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: const Text(
                                  'm0hamedAit',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    color: LightColors.kLavender,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              Container(
                                child: const Text(
                                  'Student',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ]),
            ),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  BlocBuilder<ContactBloc, ContactState>(  // recevoir nouveau state
                    builder:(context, state){
                      return Container(
                          padding: const EdgeInsets.only(bottom:10),
                          child:
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ButtonC("ALL",AllContactsEvent()),
                              ButtonC("BDCC",BDCCContactsEvent()),
                              ButtonC("GLSID",GLSIDContactsEvent()),
                            ],
                          )
                      );
                    },
                  ),
                  BlocBuilder<ContactBloc,ContactState>(
                      builder: (context, state) {
                        if (state.status == RequestStatus.LOADING) {
                          return const CircularProgressIndicator();
                        } else if (state.status == RequestStatus.LOADED) {
                          if (state.contacts.isEmpty) {
                            return const Text("There is no contacts");
                          } else {
                            return Row(
                              children:<Widget>[
                                Expanded(
                              child: SizedBox(
                                height: height - 250,
                                child: ListView.builder(
                                  itemCount: state.contacts.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      onTap: (){
                                        context.read<MessageBloc>().add(ContactMessageEvent(contact: state.contacts[index]));
                                        Navigator.pushNamed(context, "/messages",arguments:state.contacts[index] );
                                      },
                                      leading: CircleAvatar(
                                        backgroundColor: LightColors.kDarkBlue,
                                        child: Text(state.contacts[index].name.substring(0, 2)),
                                      ),//Text
                                      title: Text(
                                        state.contacts[index].name,
                                        style: const TextStyle(
                                          color: Colors.black,
                                         ),),
                                    );
                                  }),
                              )
                                )],);
                            }
                        }
                        else if (state.status == RequestStatus.NONE) {
                          return const Text("");
                        } else {
                          return Column(
                            children: [
                              Text(" ${state.errorMessage}"),
                              ElevatedButton(onPressed: () {
                                ContactBloc contactBloc = context.read<ContactBloc>();
                                //context.read<ContactBloc>().add(contactBloc.lastEvent);
                              }, child: const Text("reload"))
                            ],
                          );
                        }
                      })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
