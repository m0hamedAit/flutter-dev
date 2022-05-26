
import 'package:contact_app/bloc/contact/Contact_state.dart';
import 'package:contact_app/bloc/message/Message_bloc.dart';
import 'package:contact_app/bloc/message/Message_event.dart';
import 'package:contact_app/bloc/message/Message_state.dart';
import 'package:contact_app/model/Message.dart';
import 'package:contact_app/theme/colors/light_colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/Contact.dart';
import '../widgets/message_container.dart';

class MessagesPage extends StatelessWidget{

  TextEditingController textController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    Contact contact=ModalRoute.of(context)!.settings.arguments as Contact;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: Text(contact.name), backgroundColor: LightColors.kDarkYellow),
      body: Stack(
        children: <Widget>[
          BlocBuilder<MessageBloc,MessageState>(builder: (context, state) {
            if(state.requestStatus==RequestStatus.LOADING){
              return const CircularProgressIndicator();
            }else if (state.requestStatus==RequestStatus.LOADED){
              return Column(
                children: <Widget>[
              Expanded(
                child: SizedBox(
                  height: 200.0,
                  child: ListView.builder(
                  itemBuilder: (context, index) {
                    return MessageContainer(
                        content: state.messages[index].content,
                        received: state.messages[index].typeMessage
                    );
                  },

                itemCount: state.messages.length),
                ),
              ),
                  Align(

                  alignment: Alignment.bottomLeft,
                    child: Container(
                      padding: EdgeInsets.only(left: 10,top: 10),
                      height: 60,
                      width: double.infinity,
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              controller: textController,
                              decoration: const InputDecoration(
                                hintText: "Write message...",
                                hintStyle: TextStyle(color: Colors.black54),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(40)),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 15,),
                          FloatingActionButton(
                            onPressed: (){
                              context.read<MessageBloc>().add(SaveMessageEvent(Message(0,  DateTime(2022), textController.text,contact.id, Type.SENT)));
                            },
                            child: const Icon(Icons.send,color: Colors.white,size: 18,),
                            backgroundColor: Colors.blue,
                            elevation: 0,
                          ),
                        ],

                      ),
                    ),
                  )
                ],
              );
            }else if(state.requestStatus==RequestStatus.ERROR){
              return Center(
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    Text("${state.errorMessage}"),
                    // ToAdd
                  ],
                ),
              );
            }else {
              return Container();
            }


          }),
        ],),


    );
  }
}