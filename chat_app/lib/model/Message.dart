

import 'package:contact_app/model/Contact.dart';


enum Type{SENT, RECEIVED}

class Message{
  int id;
  DateTime dateTime;
  String content;
  int contactId;
  Type typeMessage;

  Message(this.id, this.dateTime, this.content, this.contactId, this.typeMessage);
}