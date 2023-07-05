import 'package:flutter/cupertino.dart';
import 'package:varichem_warehouse/providers/auth_provider.dart';
import 'package:varichem_warehouse/services/api_service.dart';
import '../models/product.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> products = [];

  late ApiService apiService;

  late AuthProvider authProvider;

  ProductProvider( this.authProvider) {
    apiService = ApiService( authProvider.token);

    init();

  }

  Future<void> init() async {
    products = await apiService.getProducts();

    notifyListeners();

  }

  get allProducts {
    return products;

  }

  Future<void> addProduct( int measurementUnitId, String name, String code ) async {
    Product product = await
    apiService.addProduct(measurementUnitId, name, code);
    products.add( product);

    notifyListeners();

  }

  Future<void> updateProduct( Product product) async {
    Product updatedProduct = await apiService.updateProduct(product);
    int index = products.indexOf( product);
    products[index] = updatedProduct;

    notifyListeners();
    
  }
}