

import 'package:contact_app/bloc/Contact_event.dart';
import 'package:contact_app/bloc/Contact_state.dart';
import 'package:contact_app/model/Contact.dart';
import 'package:contact_app/repositories/ContactRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState>{
  ContactRepository contactRepository;
  String lastEvent = "";

  ContactBloc(ContactState contactState, this.contactRepository) : super(contactState){

    on<ContactEvent>((event, emit) async{
      if(event is AllContactsEvent){
        lastEvent = "ALL";
        emit(ContactState([],RequestStatus.Loading, ""));
        try{
          List<Contact> contacts = await contactRepository.getAllContacts();
          emit(ContactState(contacts, RequestStatus.Loaded,""));
        }
        catch(error){
          emit(ContactState([], RequestStatus.Error,error.toString()));
        }
      }
      else if(event is BDCCContactsEvent){
          lastEvent = "BDCC";
          emit(ContactState([],RequestStatus.Loading, ""));
          try{
            List<Contact> contacts = await contactRepository.getContactsByGroup("BDCC");
            emit(ContactState(contacts, RequestStatus.Loaded,""));
          }
          catch(error){
            emit(ContactState([], RequestStatus.Error,error.toString()));
          }
      }
      else if(event is GLSIDContactsEvent) {
        lastEvent = "GLSID";
        emit(ContactState([], RequestStatus.Loading, ""));
        try {
          List<Contact> contacts = await contactRepository.getContactsByGroup("GLSID");
          emit(ContactState(contacts, RequestStatus.Loaded, ""));
        }
        catch (error) {
          emit(ContactState([], RequestStatus.Error, error.toString()));
        }
      }
    });
  }


}