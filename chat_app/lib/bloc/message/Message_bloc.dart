import 'package:contact_app/bloc/contact/Contact_state.dart';
import 'package:contact_app/bloc/message/Message_event.dart';
import 'package:contact_app/bloc/message/Message_state.dart';
import 'package:contact_app/repositories/MessageRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/Message.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState>{
  MessageRepository messageRepository ;
  MessageBloc({required MessageState initialState, required this.messageRepository}) : super(initialState){
    on((event, emit) async{
      if(event is ContactMessageEvent){
        emit(MessageState(messages: [], errorMessage: "",currentEvent: event));
        try{
          List<Message> messages=await messageRepository.getMessagesByContact(event.contact.id);
          emit(MessageState(messages: messages, requestStatus: RequestStatus.LOADED, errorMessage: "",currentEvent: event));
        }catch(e){
          emit(MessageState(messages: [], requestStatus: RequestStatus.ERROR,errorMessage: e.toString(),currentEvent: event));
        }
      }

      else if(event is SaveMessageEvent){
        messageRepository.putMessage(event.message);
        try{
          List<Message> messages=await messageRepository.getMessagesByContact(event.message.contactId);
          emit(MessageState(messages: messages, requestStatus: RequestStatus.LOADED, errorMessage: "",currentEvent: event));
        }catch(e){
          emit(MessageState(messages: [], requestStatus: RequestStatus.ERROR,errorMessage: e.toString(),currentEvent: event));
        }
      }

    });
  }

}