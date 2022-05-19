

import 'dart:math';

import 'package:contact_app/model/Contact.dart';
import 'package:faker/faker.dart';

class ContactRepository{
  
  List<Contact> contacts = List.generate(20, (i)=>Contact(i+1, faker.person.name(), Random().nextInt(10)>5?"BDCC":"GLSID"));
  
  Future<List<Contact>> getAllContacts() async {
    var future = await Future.delayed(const Duration(seconds: 2));
    return contacts;
  }

  Future<List<Contact>> getContactsByGroup(String group) async {
    var future = await Future.delayed(const Duration(seconds: 2));
    return contacts.where((contact) => contact.group == group).toList();
  }
}