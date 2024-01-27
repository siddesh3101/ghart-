import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_hackathon/constants/colors.dart';
import 'package:flutter_hackathon/models/product_model.dart';
import 'package:flutter_hackathon/screens/arvr/product_detail_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  Stream<List<ProductModel>> getAllProducts() => FirebaseFirestore.instance
      .collection('products')
      .snapshots()
      .map((query) =>
          query.docs.map((item) => ProductModel.fromMap(item)).toList());

  List<ProductModel> prods = [];

  @override
  void initState() {
    super.initState();
    getAllProducts().listen((event) {
      setState(() {
        prods = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'AR Furniture',
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: prods.length == 0
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                          scrollDirection: Axis.vertical,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.75,
                                  mainAxisSpacing: 15,
                                  crossAxisSpacing: 20),
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: prods.length,
                          itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              // TODO
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ProductDetailScreen(
                                        product: prods[index],
                                      )));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color:
                                      MyColors.primaryColor.withOpacity(0.08),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    AspectRatio(
                                        aspectRatio: 1,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      prods[index]
                                                          .imageUrl
                                                          .toString()),
                                                  fit: BoxFit.cover)),
                                        )),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            prods[index].name.toString(),
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: MyColors.primaryColor,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            '\₹ ${prods[index].price.toString()}',
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: MyColors.blackColor,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
        ),
      ),
    );
  }
}
