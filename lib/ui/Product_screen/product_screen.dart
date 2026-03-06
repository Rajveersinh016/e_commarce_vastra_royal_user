import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../models/catalog_model.dart';


class ProductScreen extends StatelessWidget {

  final String tag;

  ProductScreen({required this.tag});

  final DatabaseReference productRef =
  FirebaseDatabase.instance.ref("products");

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text(tag.toUpperCase()),
      ),

      body: StreamBuilder(
        stream: productRef.onValue,
        builder: (context, snapshot) {

          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final data =
              (snapshot.data! as DatabaseEvent).snapshot.value;

          if (data == null) {
            return Center(child: Text("No products"));
          }

          Map products = data as Map;

          List filteredProducts = products.entries
              .where((e) => e.value['tag'] == tag)
              .toList();

          return ListView.builder(
            itemCount: filteredProducts.length,
            itemBuilder: (context, index) {

              var product = filteredProducts[index].value;

              return ListTile(
                leading: Image.network(product['image']),
                title: Text(product['name']),
                subtitle: Text("₹${product['price']}"),
              );
            },
          );
        },
      ),
    );
  }
}