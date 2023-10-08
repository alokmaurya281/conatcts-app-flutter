import 'dart:convert';

import 'package:contacts_app/models/user_model.dart';
import 'package:contacts_app/utils/apis/apis_urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _error = '';
  String get error => _error;

  User _user = User(id: '', username: '', email: '');
  User get user => _user;

  Future<void> setLoading(bool status) async {
    _isLoading = status;
    // notifyListeners();
  }

  /// get profile details

  Future<void> userProfileData(String token) async {
    _error = '';

    _user = User(id: '', username: '', email: '');
    // notifyListeners();
    try {
      final response = await http.get(
        Uri.parse(userProfileUrl),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );
      final Map<String, dynamic> data = json.decode(response.body);
      if (response.statusCode == 200) {
        _user = User(
            id: data['data']['id'],
            username: data['data']['username'],
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

  Future<void> updateUserData(
      String token, String username, String email) async {
    _error = '';

    _user = User(id: '', username: '', email: '');
    // notifyListeners();
    try {
      final response = await http.get(
        Uri.parse(userProfileUrl),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );
      final Map<String, dynamic> data = json.decode(response.body);
      if (response.statusCode == 200) {
        _user = User(
            id: data['data']['id'],
            username: data['data']['username'],
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
