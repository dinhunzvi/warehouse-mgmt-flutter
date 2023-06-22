import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:varichem_warehouse/services/api_service.dart';

class AuthProvider extends ChangeNotifier {

  late String token;

  late ApiService apiService;

  bool isAuthenticated = false;

  AuthProvider() {
    init();
  }

  Future<void> init() async {
    token = await getToken();

    if ( token.isNotEmpty ) {
      isAuthenticated = true;
    }

    apiService = ApiService(token);

    notifyListeners();
  }

  Future<void> login( String email, String password, String deviceName) async {
    token = await apiService.login( email, password, deviceName);
    isAuthenticated = true;
    setToken( token);

    notifyListeners();
  }

  Future<void> logout() async {
    token = '';
    isAuthenticated = false;

    setToken(token);

    notifyListeners();

  }

  Future<void> setToken( String token) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString( 'token', token );
  }

  Future<String> getToken() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString( 'token' ) ?? '';
  }
}