import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:varichem_warehouse/models/product.dart';
import 'package:varichem_warehouse/providers/product_provider.dart';
import 'package:varichem_warehouse/widgets/add_product.dart';
import 'package:varichem_warehouse/widgets/edit_product.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context, listen: true);

    List<Product> products = provider.allProducts;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            Product product = products[index];
            return ListTile(
              title: Text(product.name),
              subtitle: Text(product.code),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context) {
                              return EditProduct(
                                  product: product,
                                  productCallBack: provider.updateProduct);
                            });
                      },
                      icon: const Icon(Icons.edit))
                ],
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return AddProduct(productCallback: provider.addProduct);
                });
          },
          child: const Icon(Icons.add)),
    );
  }
}
