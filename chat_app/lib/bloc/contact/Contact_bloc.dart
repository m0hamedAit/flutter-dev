import 'package:contact_app/bloc/contact/Contact_state.dart';
import 'package:contact_app/model/Contact.dart';
import 'package:contact_app/repositories/ContactRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Contact_event.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState>{
  ContactRepository contactRepository;
  String lastEvent = "";

  ContactBloc(ContactState contactState, this.contactRepository) : super(contactState){

    on<ContactEvent>((event, emit) async{
      if(event is AllContactsEvent){
        lastEvent = "ALL";
        emit(ContactState([],RequestStatus.LOADING, ""));
        try{
          List<Contact> contacts = await contactRepository.getAllContacts();
          emit(ContactState(contacts, RequestStatus.LOADED,""));
        }
        catch(error){
          emit(ContactState([], RequestStatus.ERROR,error.toString()));
        }
      }
      else if(event is BDCCContactsEvent){
          lastEvent = "BDCC";
          emit(ContactState([],RequestStatus.LOADING, ""));
          try{
            List<Contact> contacts = await contactRepository.getContactsByGroup("BDCC");
            emit(ContactState(contacts, RequestStatus.LOADED,""));
          }
          catch(error){
            emit(ContactState([], RequestStatus.ERROR,error.toString()));
          }
      }
      else if(event is GLSIDContactsEvent) {
        lastEvent = "GLSID";
        emit(ContactState([], RequestStatus.LOADING, ""));
        try {
          List<Contact> contacts = await contactRepository.getContactsByGroup("GLSID");
          emit(ContactState(contacts, RequestStatus.LOADED, ""));
        }
        catch (error) {
          emit(ContactState([], RequestStatus.ERROR, error.toString()));
        }
      }
    });
  }


}