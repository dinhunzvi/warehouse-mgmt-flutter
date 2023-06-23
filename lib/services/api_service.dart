import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:varichem_warehouse/models/product.dart';

class ApiService {
  late final String token;

  final String baseUrl = "http://192.168.1.1:8000/api/";

  ApiService(this.token);

  Future<List<Product>> getProducts() async {
    http.Response response = await http.get(
      Uri.parse('${baseUrl}products'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
    );

    List products = jsonDecode(response.body);

    return products.map((product) => Product.fromJson(product)).toList();
  }

  Future<Product> addProduct(int measurementUnitId, int binLocationId,
      String name, String code) async {
    http.Response response = await http.post(Uri.parse('${baseUrl}products'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token'
        },
        body: jsonEncode({
          'measurement_unit_id': measurementUnitId,
          'bin_location_id': binLocationId,
          'name': name,
          'code': code
        }));

    if (response.statusCode == 422) {
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

    return Product.fromJson(jsonDecode(response.body));
  }

  Future<Product> updateProduct(Product product) async {
    http.Response response = await http.put(
        Uri.parse('${baseUrl}products/${product.id.toString()}'),
        headers: {
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token'
        });

    if (response.statusCode != 200) {
      throw Exception("Error updating product");
    }

    return Product.fromJson(jsonDecode(response.body));
  }

  Future<String> login(String email, String password, String deviceName) async {
    http.Response response = await http.post(Uri.parse('${baseUrl}auth/login'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json'
        },
        body: jsonEncode(
            {'email': email, 'password': password, 'device_name': deviceName}));

    if (response.statusCode == 422) {
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
