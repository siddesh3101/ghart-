import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String? name;
  String? description;
  String? modelUrl;
  String? imageUrl;
  ProductModel({this.name, this.description, this.modelUrl, this.imageUrl});
  ProductModel.fromMap(DocumentSnapshot data) {
    name = data['name'];
    description = data['description'];
    modelUrl = data['modelUrl'];
    imageUrl = data['imageUrl'];
  }
}
