

import 'dart:math';

import 'package:contact_app/model/Contact.dart';
import 'package:faker/faker.dart';

class ContactRepository{
  
  List<Contact> contacts = List.generate(20, (i)=>Contact(id: i+1, group: Random().nextInt(10)>5?"BDCC":"GLSID", name: faker.person.name()));
  Future<List<Contact>> getAllContacts() async {
    var future = await Future.delayed(const Duration(seconds: 2));
    return contacts;
  }

  Future<List<Contact>> getContactsByGroup(String group) async {
    var future = await Future.delayed(const Duration(seconds: 2));
    return contacts.where((contact) => contact.group == group).toList();
  }

  Iterable<Contact> getContactById(int id){
    return contacts.where((contact) => contact.id==id);
  }
}