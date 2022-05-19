import 'package:contact_app/Constants.dart';
import 'package:contact_app/bloc/Contact_bloc.dart';
import 'package:contact_app/bloc/Contact_event.dart';
import 'package:contact_app/bloc/Contact_state.dart';
import 'package:contact_app/repositories/ContactRepository.dart';
import 'package:contact_app/ui/pages/ContactPage.dart';
import 'package:contact_app/ui/widgets/ButtonC.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Contacts"),
        backgroundColor: primaryColor,
      ),
      body: Column(
        children:[

              BlocBuilder<ContactBloc, ContactState>(
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
                if (state.status == RequestStatus.Loading) {
                  return const CircularProgressIndicator();
                } else if (state.status == RequestStatus.Loaded) {
                  if (state.contacts.isEmpty) {
                    return const Text("There is no contacts");
                  } else {
                    return Expanded(
                      child: ListView.builder(
                          itemCount: state.contacts.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundColor: primaryColor,
                                child: Text(state.contacts[index].name.substring(0, 2)),
                              ),//Text
                              title: Text(state.contacts[index].name),
                            );
                          }),
                    );
                  }
                }
                else if (state.status == RequestStatus.None) {
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

            ]
      )
    );
  }
}
