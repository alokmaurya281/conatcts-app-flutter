import 'dart:convert';

import 'package:contacts_app/models/contact_model.dart';
import 'package:contacts_app/utils/apis/apis_urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ContactsProvider extends ChangeNotifier {
  List<Contact> _contacts = [];

  List<Contact> get contactsList => _contacts;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> setLoading(bool status) async {
    _isLoading = status;
    // notifyListeners();
  }

  String _error = '';
  String get error => _error;

  Contact _contact =
      Contact(id: '', name: '', email: '', phone: '', userId: '');
  Contact get contact => _contact;

  // fetchContacts

  Future<void> fetchContactsList(String token) async {
    _error = '';
    _isLoading = true;
    // notifyListeners();
    try {
      final response = await http.get(
        Uri.parse(contacts),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );
      final Map<String, dynamic> data = json.decode(response.body);
      if (response.statusCode == 200) {
        _contacts = (data['data'] as List)
            .map((data) => Contact.fromJson(data))
            .toList();
        notifyListeners();
      } else {
        _error = data['message'];
        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addContact(
      String token, String name, String email, String phone) async {
    _error = '';
    notifyListeners();
    try {
      final response = await http.post(
        Uri.parse(createContact),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode({
          "name": name,
          "email": email,
          "phone": phone,
        }),
      );
      final Map<String, dynamic> data = json.decode(response.body);
      if (response.statusCode == 201) {
        _contact = Contact(
            id: data['data']['_id'],
            name: data['data']['name'],
            userId: data['data']['user_id'],
            phone: data['data']['phone'],
            email: data['data']['email']);
        notifyListeners();
      } else {
        _error = data['message'];
        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  /// update contact

  Future<void> updateContactDetails(
      String token, String name, String email, String phone, String id) async {
    _error = '';
    notifyListeners();
    try {
      final response = await http.put(
        Uri.parse('$updateContact/$id'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode({
          "name": name,
          "email": email,
          "phone": phone,
        }),
      );
      final Map<String, dynamic> data = json.decode(response.body);
      if (response.statusCode == 200) {
        _contact = Contact(
            id: data['data']['_id'],
            name: data['data']['name'],
            userId: data['data']['user_id'],
            phone: data['data']['phone'],
            email: data['data']['email']);
        notifyListeners();
      } else {
        _error = data['message'];
        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  /// get contact details by id

  Future<void> getContactDetailsById(String token, String id) async {
    _error = '';

    _contact = Contact(id: '', name: '', email: '', phone: '', userId: '');
    // notifyListeners();
    try {
      final response = await http.get(
        Uri.parse('$contactById/$id'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );
      final Map<String, dynamic> data = json.decode(response.body);
      if (response.statusCode == 200) {
        _contact = Contact(
            id: data['data']['_id'],
            name: data['data']['name'],
            userId: data['data']['user_id'],
            phone: data['data']['phone'],
            email: data['data']['email']);
        // _isLoading = false;
        notifyListeners();
      } else {
        _error = data['message'];
        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
    _isLoading = false;
    notifyListeners();
  }

  /// get contact details by id

  Future<void> deleteContactbyId(String token, String id) async {
    _error = '';

    _contact = Contact(id: '', name: '', email: '', phone: '', userId: '');
    // notifyListeners();
    try {
      final response = await http.delete(
        Uri.parse('$deleteContact/$id'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );
      final Map<String, dynamic> data = json.decode(response.body);
      if (response.statusCode == 200) {
        _contact = Contact(
            id: data['data']['_id'],
            name: data['data']['name'],
            userId: data['data']['user_id'],
            phone: data['data']['phone'],
            email: data['data']['email']);
        // _isLoading = false;
        notifyListeners();
      } else {
        _error = data['message'];
        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
    _isLoading = false;
    notifyListeners();
  }
}
