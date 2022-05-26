


import 'dart:math';

import 'package:contact_app/model/Contact.dart';
import 'package:contact_app/model/Message.dart';

class MessageRepository{
  List<Message> messages = [
     Message(1,  DateTime(2022), "Bonjour",1, Type.RECEIVED),
     Message(2,  DateTime(2022), "Bonjour", 1, Type.SENT),
     Message(3,  DateTime(2022), "Bonjour", 2, Type.RECEIVED),
     Message(4,  DateTime(2022), "Bonjour", 2, Type.SENT),
     Message(5, DateTime(2022), "Bonjour", 2, Type.SENT),
  ];

  Future<List<Message>> getMessagesByContact(int contactId) async{
    var future = await Future.delayed(const Duration(seconds: 2));

    return messages.where((element) => element.contactId==contactId).toList();

  }

  void putMessage(Message message){
    message.id = messages.length+1;
    messages.add(message);
  }




}