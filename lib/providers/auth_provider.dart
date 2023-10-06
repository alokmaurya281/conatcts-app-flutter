import 'dart:convert';

import 'package:contacts_app/models/user_model.dart';
import 'package:contacts_app/utils/apis/apis_urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool _isLoading = false;

  String _error = '';
  String get error => _error;

  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading;

  String _accessToken = '';
  String get accessToken => _accessToken;

  User _user = User(id: '', username: '', email: '');
  User get user => _user;

  // setLoading effect

  Future<void> setLoading(bool status) async {
    _isLoading = status;
    notifyListeners();
  }

  // signup

  Future<void> signup(String email, String password, String username) async {
    _error = '';
    notifyListeners();
    try {
      final response = await http.post(
        Uri.parse(registerUrl),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "username": username,
          "email": email,
          "password": password,
        }),
      );
      final Map<String, dynamic> data = json.decode(response.body);
      if (response.statusCode == 201) {
        _user = User(
            id: data['data']['_id'],
            username: data['data']['username'],
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

  // For Login authentication

  Future<void> login(String email, String password) async {
    _error = '';
    notifyListeners();
    try {
      final response = await http.post(
        Uri.parse(loginUrl),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );
      final Map<String, dynamic> data = json.decode(response.body);
      if (response.statusCode == 200) {
        await setToken(true, data['accessToken']);
        await getToken();
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

  //for set the token

  Future<void> setToken(bool isLoggedIn, String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
    await prefs.setString('accessToken', token);
  }

  // get token

  Future<void> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLoggedIn = await prefs.getBool('isLoggedIn') ?? false;
    _accessToken = await prefs.getString('accessToken') ?? '';
    notifyListeners();
  }

  // signout

  Future<void> signout() async {
    await setToken(false, '');
    await getToken();
  }
}
