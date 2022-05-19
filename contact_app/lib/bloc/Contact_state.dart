
import '../model/Contact.dart';

enum RequestStatus{Loading, Loaded, Error, None}

class ContactState{
  List<Contact> contacts;
  RequestStatus status;
  String errorMessage;

  ContactState(this.contacts, this.status, this.errorMessage);
}