import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:varichem_warehouse/models/bin_location.dart';
import 'package:varichem_warehouse/models/goods_received_voucher.dart';
import 'package:varichem_warehouse/models/measurement_unit.dart';
import 'package:varichem_warehouse/models/product.dart';
import 'package:varichem_warehouse/models/raw_material.dart';

class ApiService {
  late final String token;

  final String baseUrl = "http://192.168.1.31:8000/api/";

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

  Future<Product> addProduct(
      int measurementUnitId, String name, String code) async {
    http.Response response = await http.post(Uri.parse('${baseUrl}products'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token'
        },
        body: jsonEncode({
          'measurement_unit_id': measurementUnitId,
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
      print('My error message' );
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

  Future<List<BinLocation>> getBinLocations() async {
    http.Response response =
        await http.get(Uri.parse('${baseUrl}bin-locations'), headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json'
    });

    List binLocations = jsonDecode(response.body);

    return binLocations
        .map((binLocation) => BinLocation.fromJson(binLocation))
        .toList();
  }

  Future<BinLocation> addBinLocation(String name) async {
    http.Response response =
        await http.post(Uri.parse('${baseUrl}bin-locations'),
            headers: {
              HttpHeaders.authorizationHeader: 'Bearer $token',
              HttpHeaders.contentTypeHeader: 'application/json',
              HttpHeaders.acceptHeader: 'application/json'
            },
            body: jsonEncode({'name': name}));

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

    return BinLocation.fromJson(jsonDecode(response.body));
  }

  Future<BinLocation> updateBinLocation(BinLocation binLocation) async {
    http.Response response = await http.put(
      Uri.parse('${baseUrl}bin-locations/${binLocation.id.toString()}'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.contentTypeHeader: 'application/json'
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Error updating bin location");
    }

    return BinLocation.fromJson(jsonDecode(response.body));
  }

  Future<List<MeasurementUnit>> getMeasurementUnits() async {
    http.Response response =
        await http.get(Uri.parse('${baseUrl}measurement-units'), headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json'
    });

    List measurementUnits = jsonDecode(response.body);

    return measurementUnits
        .map((measurementUnit) => MeasurementUnit.fromJson(measurementUnit))
        .toList();
  }

  Future<MeasurementUnit> addMeasurementUnit(String name, String code) async {
    http.Response response =
        await http.post(Uri.parse('${baseUrl}measurement-units'),
            headers: {
              HttpHeaders.authorizationHeader: 'Bearer $token',
              HttpHeaders.contentTypeHeader: 'application/json',
              HttpHeaders.acceptHeader: 'application/json'
            },
            body: jsonEncode({'name': name, 'code': code}));

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

    return MeasurementUnit.fromJson(jsonDecode(response.body));
  }

  Future<MeasurementUnit> updateMeasurementUnit(
      MeasurementUnit measurementUnit) async {
    http.Response response = await http.put(
        Uri.parse(
            '${baseUrl}measurement-units/${measurementUnit.id.toString()}'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.contentTypeHeader: 'application/json'
        });

    if (response.statusCode != 200) {
      throw Exception('Error updating measurement unit');
    }

    return MeasurementUnit.fromJson(jsonDecode(response.body));
  }

  Future<List<GoodsReceivedVoucher>> getGoodsReceivedVouchers() async {
    http.Response response = await http
        .get(Uri.parse('${baseUrl}goods-received-vouchers'), headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json'
    });

    List goodsReceivedVouchers = jsonDecode(response.body);

    return goodsReceivedVouchers
        .map((goodsReceivedVoucher) =>
            GoodsReceivedVoucher.fromJson(goodsReceivedVoucher))
        .toList();
  }

  Future<List<RawMaterial>> getRawMaterials() async {
    http.Response response =
        await http.get(Uri.parse('${baseUrl}raw-materials'), headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });

    List rawMaterials = jsonDecode(response.body);

    return rawMaterials
        .map((rawMaterial) => RawMaterial.fromJSON(rawMaterial))
        .toList();
  }

  Future<RawMaterial> addRawMaterial(
      int measurementUnitId, int binLocationId, String name) async {
    http.Response response =
        await http.post(Uri.parse('${baseUrl}raw-materials'),
            headers: {
              HttpHeaders.authorizationHeader: 'Bearer $token',
              HttpHeaders.acceptHeader: 'application/json',
              HttpHeaders.contentTypeHeader: 'application/json'
            },
            body: jsonEncode({
              'measurement_unit_id': measurementUnitId,
              'bin_location_id': binLocationId,
              'name': name
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

    return RawMaterial.fromJSON(jsonDecode(response.body));
  }
  
  Future<RawMaterial> updateRawMaterial( RawMaterial rawMaterial) async {
    http.Response response = await http.put(
        Uri.parse( '${baseUrl}raw-materials/${rawMaterial.id.toString()}'),
    headers: {
          HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });

    if ( response.statusCode != 200 ) {
      throw Exception( 'Error updating raw material' );
    }

    return RawMaterial.fromJSON( jsonDecode( response.body));
  }
}
