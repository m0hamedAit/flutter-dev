

import 'package:contact_app/bloc/contact/Contact_state.dart';
import 'package:contact_app/bloc/message/Message_event.dart';
import 'package:contact_app/model/Message.dart';

class MessageState{
  List<Message> messages;
  String errorMessage;
  RequestStatus requestStatus;
  MessageEvent currentEvent;

  MessageState({required this.messages, required this.errorMessage, this.requestStatus = RequestStatus.NONE, required this.currentEvent});
}
