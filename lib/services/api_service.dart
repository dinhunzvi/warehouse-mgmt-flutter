import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class ApiService {

  late final String token;

  final String baseUrl = "http://192.168.1.1:8000/api/";

  ApiService( this.token );

  Future<String> login ( String email, String password, String deviceName ) async {
    http.Response response = await http.post( Uri.parse('${baseUrl}auth/login'),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json'
    },
      body: jsonEncode({ 'email': email, 'password': password, 'device_name': deviceName})
    );

    if ( response.statusCode == 422 ) {
      Map<String, dynamic> body = jsonDecode(response.body);
      Map<String, dynamic> errors = body['errors'];

      String errorMessage = '';

      errors.forEach((key, value) {
        value.forEach((element) {
          errorMessage += element + '\n';
        });
      });
      throw Exception(errorMessage);
    }

    return response.body;
  }
}