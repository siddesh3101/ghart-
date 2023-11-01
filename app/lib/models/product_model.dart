import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String? name;
  String? description;
  String? modelUrl;
  String? imageUrl;
  String? price;
  String? rating;

  ProductModel(
      {this.name,
      this.description,
      this.modelUrl,
      this.imageUrl,
      this.price,
      this.rating});
  ProductModel.fromMap(DocumentSnapshot data) {
    name = data['name'];
    description = data['description'];
    modelUrl = data['modelUrl'];
    imageUrl = data['imageUrl'];
    price = data['price'];
    rating = data['rating'];
  }
}
