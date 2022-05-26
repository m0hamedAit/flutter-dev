
import 'package:contact_app/model/Contact.dart';
import 'package:contact_app/model/Message.dart';

abstract class MessageEvent{}

class ContactMessageEvent extends MessageEvent{
  Contact contact;

  ContactMessageEvent({required this.contact});
}

class SaveMessageEvent extends MessageEvent{
  Message message;

  SaveMessageEvent(this.message);
}