
import '../../model/Contact.dart';

enum RequestStatus{LOADING, LOADED, ERROR, NONE}

class ContactState{
  List<Contact> contacts;
  RequestStatus status;
  String errorMessage;

  ContactState(this.contacts, this.status, this.errorMessage);
}